#!/bin/sh

/bin/sleep $1 | true
java -Djava.security.egd=file:/dev/./urandom -jar /usr/local/bin/app.jar
