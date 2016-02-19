#!/bin/bash
#
# build.sh - Build the book in target/.
#
# Options:
#
#   -f <formats>  
#           comma-separated list of formats to build. 
#           Valid formats: pdf, chunked, html, epub
#           Defaults to "pdf,chunked"
#
#   -v      enable verbose output
#
# Environment variables used:
#
# ASCIIDOC  asciidoc command to use. Defaults to "asciidoc".

# Fail if anything errors
set -e
# Fail if a function call is missing an argument
set -u

# Parse arguments
formats_arg="pdf,chunked"
verbose=0
while getopts "vf:" opt; do
	case "$opt" in
		v)  verbose=1
        ;;
    f)  formats_arg=$OPTARG
        ;;
  esac
done
IFS="," read -a formats <<< "$formats_arg"
if [ "$verbose" = 1 ]; then 
	vflag="-v"
	dblatex_vflag="-V"
	zip_vflag="-v"
else 
	vflag=""
  dblatex_vflag="-q"
  zip_vflag="-q"
fi
if [ -z "${ASCIIDOC+x}" ]; then ASCIIDOC=asciidoc; fi
asciidoc_exe="$ASCIIDOC"

function array_contains() {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

valid_formats=( pdf chunked html epub )
for format in ${formats[@]}; do
	if ! array_contains "$format" "${valid_formats[@]}"; then
		echo "Error: invalid format: '$format'" >&2
		exit 1
	fi
done

book=book-mvnex
book_file=$book.asciidoc

mkdir target

# Build the Single Page HTML
if array_contains "html" "${formats[@]}"; then
  echo "Building Single Page HTML"
  $asciidoc_exe $vflag -o target/$book.html $book_file
fi

dblatex_opts_common="$dblatex_vflag -P doc.publisher.show=0 -P latex.output.revhistory=0"

# Build the PDF
if array_contains "pdf" "${formats[@]}"; then
  echo "Building PDF"
  cp -r figs target
  cp -r images target
  $asciidoc_exe $vflag -d book -b docbook \
    -o target/$book.xml $book_file
  xmllint --nonet --noout --valid target/$book.xml
  dblatex -t pdf $dblatex_opts_common \
    -p docbook-xsl/dblatex.xsl \
    -s latex/asciidoc-dblatex.sty \
    -s latex/custom-docbook.sty \
    target/$book.xml
  echo "done"
fi

run_xslt_fcn() {
	fcn=$1
  if [ "$verbose" = 1 ]; then
  	$fcn
  else
  	# Sadly, xsltproc lists all files written on STDERR
  	$fcn 2>/dev/null
  fi
}

# Build the Chunked HTML
if array_contains "chunked" "${formats[@]}"; then
  echo "Building Multi Page HTML"
  $asciidoc_exe $vflag -d book -b docbook \
    -o target/$book.xml $book_file
  xmllint --nonet --noout --valid target/$book.xml
  (
  	cd target
    chunked_dir=$book.chunked
    xslt_chunked() { 
      # Don't include $vflag in xsltproc. It's just *too* verbose.
      xsltproc --stringparam chunk.section.depth 1 \
        --stringparam callout.graphics 0 --stringparam navig.graphics 0 \
        --stringparam admon.textlabel 1 --stringparam admon.graphics 0 \
        --stringparam toc.section.depth 1  --stringparam base.dir "$chunked_dir" \
        ../docbook-xsl/custom-chunked.xsl \
        "$book.xml"
    }
    run_xslt_fcn xslt_chunked
    mkdir -p $chunked_dir/figs
    cp ../docbook-xsl/docbook-xsl.css $chunked_dir
    cp -r ../figs/web $chunked_dir/figs
  )
  [ $? = 0 ] || exit 1
  echo "done"
fi

# Build the EPUB
if array_contains "epub" "${formats[@]}"; then
  echo "Building EPUB"
  $asciidoc_exe $vflag -d book -b docbook \
    -o target/$book.xml $book_file
  xmllint --nonet --noout --valid target/$book.xml
  (
  	cd target
    epub_dir=$book.epub.d
    mkdir -p $epub_dir
    cd $epub_dir
    xslt_epub() {
      # Don't include $vflag in xsltproc. It's just *too* verbose.
      xsltproc --stringparam chunk.section.depth 0\
        --stringparam callout.graphics 0 --stringparam navig.graphics 0 \
        --stringparam admon.textlabel 1 --stringparam admon.graphics 0 \
        --stringparam toc.section.depth 1 \
        ../../docbook-xsl/epub.xsl \
        "../$book.xml"
      }
    run_xslt_fcn xslt_epub
    oebps=OEBPS
    cp -r ../../covers $oebps
    mkdir -p $oebps/figs
    cp -r ../../figs/web $oebps/figs
    cp ../../docbook-xsl/docbook-xsl.css $oebps
    mkdir -p $oebps/images/icons
    cp -r ../../images/icons/callouts $oebps/images/icons

    echo 'application/epub+zip' > mimetype
    zip $zip_vflag -Z store ../book-mvnex.epub mimetype
    zip $zip_vflag -r -u ../book-mvnex.epub *
  )
  [ $? = 0 ] || exit 1
  echo "done"
fi