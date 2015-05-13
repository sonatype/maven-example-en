#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

rm -rf target/site/reference
rm -rf target/site/pdf

echo "Copying resources for site"
mkdir -p target/site/reference
mkdir -p target/site/pdf

# this relies on the example project being build prior to this and is achieved
# with a separate build step
cp examples/target/mvnexbook-examples-1.0-project.zip target/site/mvnex-examples.zip

cp -r target/book-mvnex.chunked/* target/site/reference

laf=../documentation-wrapper
cp -r $laf/* target/site/reference

cp target/book-mvnex.pdf target/site/pdf/mvnex-pdf.pdf

echo "Applying website template"
python template.py -l=$laf/template.html

cp target/site/reference/index.html target/site/reference/public-book.html
