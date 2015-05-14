#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

html=target/site/reference
pdf=target/site/pdf

rm -rf target/site/reference
rm -rf target/site/pdf

echo "Copying resources for site"
mkdir -p target/site/reference
mkdir -p target/site/pdf

# this relies on the example project being build prior to this and is achieved
# with a separate build step
cp examples/target/mvnexbook-examples-1.0-project.zip target/site/mvnex-examples.zip

cp -r target/book-mvnex.chunked/* $html
cp target/book-mvnex.pdf $pdf/mvnex-pdf.pdf

echo "Invoking templating process"
../documentation-wrapper/apply-template.sh ../maven-example-en/$html "Maven by Example" "017156762307045728421:x1zm0asungi"

cp $html/index.html $html/public-book.html


