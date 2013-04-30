#!/bin/bash

rm -rf target/site/reference
rm -rf target/site/pdf

pushd .
cd examples
mvn clean install
popd 

mkdir -p target/site/reference
mkdir -p target/site/pdf

cp examples/target/mvnexbook-examples-1.0-project.zip target/site/mvnex-examples.zip

cp -r target/book-mvnex.chunked/* target/site/reference
mkdir -p target/site/reference/css
cp -r site/css target/site/reference
cp -r site/js target/site/reference
cp -r site/assets target/site/reference
cp -r site/images target/site/reference

cp target/book-mvnex.pdf target/site/pdf/mvnex-pdf.pdf

python template.py

cp target/site/reference/index.html target/site/reference/public-book.html

rsync -e ssh -av target/site/* deployer@marketing01.int.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/mvnex-book/
