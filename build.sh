#!/bin/bash
#
# build.sh - Build the book in target/.

# Fail if anything errors
set -e
# Fail if a function call is missing an argument
set -u

book_file=book-mvnex.asciidoc

# Build the Single Page HTML
# asciidoc -o target/book-mvnex.html $book_file

dblatex_opts_common=" -P doc.publisher.show=0 -P latex.output.revhistory=0"

# Build the PDF
echo "Building PDF"
rm -rf target/images
rm -rf target/figs
cp -r figs target
cp -r images target
a2x -k -f pdf -d book \
   --dblatex-opts=" $dblatex_opts_common -s ./latex/custom-docbook.sty" \
   -D target $book_file
echo "done"

# Build the Chunked HTML
echo "Building Multi Page HTML"
a2x -k -f chunked -d book \
   --dblatex-opts=" $dblatex_opts_common " \
   --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1" \
   -D target $book_file
echo "done"
