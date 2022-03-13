#!/bin/bash

set -x

echo "Running R script"

Rscript /opt/epl/EPLTable.R 

aws s3 cp ./EPLTable.png s3://epltable/ --recursive







