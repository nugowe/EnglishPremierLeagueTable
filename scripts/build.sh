#!/bin/bash

set -x

echo "Running R script"

Rscript /opt/epl/EPLTable.R 

aws s3 /opt/epl/EPLTable.png s3://epltable/epl/EPLTable.png




