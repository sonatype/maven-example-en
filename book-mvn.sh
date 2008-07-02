#!/bin/bash

MVN_VER=`mvn -v | grep 'Maven version:' | awk '{print $3}'`

echo "You are using Maven '${MVN_VER}'"

if [ "${MVN_VER}" == "2.1-SNAPSHOT" ]; then

  echo "This book's required plugins are not compatible with Maven 2.1-SNAPSHOT. Please try another version."
  exit 1
  
fi

sed -e "s|@PWD@|`pwd`|g" settings.xml.template > settings.xml

mvn -s ./settings.xml $*
