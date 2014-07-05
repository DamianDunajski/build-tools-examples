#!/bin/bash

cd `dirname $0`
cd ..

sbt "project client" clean compile stage \
    "project service" clean compile assembly
