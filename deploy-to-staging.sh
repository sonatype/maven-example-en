#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

function rsyncToDest {
    source=$1
    target=/var/www/domains/sonatype.com/www/shared/books/$2
    options=$3
    connection=deployer@marketing02.int.sonatype.com
    echo "Uploading $1 to $2 on $connection"
    ssh $connection mkdir -pv $target
    rsync -e ssh $options -av target/$source  $connection:$target
}

rsyncToDest site/ mvnex-book/ --delete
