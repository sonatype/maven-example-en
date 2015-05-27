#!/bin/bash
#
# assemble.sh - Assemble the web site
#
# The book and examples must already be built via other build steps
# before calling this script.

# Fail if anything errors
set -e
# Fail if a function call is missing an argument
set -u

site=target/site
html=$site/reference
pdf=$site/pdf

rm -rf $html
rm -rf $pdf

echo "Copying resources for site"
mkdir -p $html
mkdir -p $pdf

# Relies on examples already being built
cp examples/target/mvnexbook-examples-1.0-project.zip target/site/mvnex-examples.zip

# Relies on book already being built
cp -r target/book-mvnex.chunked/* $html
cp target/book-mvnex.pdf $pdf/mvnex-pdf.pdf

echo "Invoking templating process"
../documentation-wrapper/apply-template.sh ../maven-example-en/$html "Maven by Example" "017156762307045728421:x1zm0asungi"

cp $html/index.html $html/public-book.html


