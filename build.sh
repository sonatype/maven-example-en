#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

mkdir -p target/images
mkdir -p target/figs

# Build the Single HTML Page Version
# asciidoc -o target/book-mvnex.html book-mvnex.asciidoc 

# Build the PDF
echo "Building PDF"
rm -rf target/images
rm -rf target/figs
cp -r figs target
cp -r images target
a2x -k -fpdf -dbook --dblatex-opts=" -P doc.publisher.show=0 -P latex.output.revhistory=0  -s ./latex/custom-docbook.sty" -D target book-mvnex.asciidoc
echo "done"

# Build the Chunked HTML
echo "Building Mutli Page HTML"
a2x -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1" -dbook --dblatex-opts=" -P doc.publisher.show=0 -P latex.output.revhistory=0" -D target book-mvnex.asciidoc
echo "done"
