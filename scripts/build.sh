#!/bin/bash

set -e

echo "Running R script"

Rscript /opt/epl/EPLTable.R 

echo "Transferring EPLDashboard to s3.........."

aws s3 sync ./$EPL_PNG_FILE s3://$S3_BUCKET/$EPL_PNG_FILE

