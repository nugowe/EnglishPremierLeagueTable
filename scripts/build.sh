#!/bin/bash

set -x

echo "Running R script"

Rscript /opt/epl/EPLTable.R 




INDEX_BUILD (){

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")    
echo """
  epl-table_logs:
    version: 1
      logfile-name: s3://$S3_BUCKET/index/$EPL_FILE
        timestamp: $CURRENT_TIME

""" > index.yaml


aws s3 cp index.yaml s3://$S3_BUCKET/index/index.yaml



}


S3_PUBLISH () {

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S") 
aws s3 cp s3://$S3_BUCKET/index/index.yaml index.yaml
cat index.yaml | awk "/version/{print$2}" | awk -F":" '{print $2}' > index_observe.yaml
summation=1
    
sum=$(( $old_index_value + $summation ))
echo """
  epl-table_logs:
    version: $sum
      logfile-name: s3://$S3_BUCKET/index/$EPL_PNG_FILE 
        timestamp: $CURRENT_TIME

""" >> index.yaml



}

aws s3api list-objects --bucket $S3_BUCKET --query "Contents[?contains(Key, 'index.yaml')]" > files.txt

INDEX_FILE=$(cat files.txt | awk "/Key/{print$1}" | awk -F":" '{print $2}' | awk -F"/" '{print $2}') 


if [[ -z $INDEX_FILE ]] || [[ $INDEX_FILE=="null" ]]; then
  INDEX_BUILD && S3_PUBLISH
else
  S3_PUBLISH
fi


aws s3 cp ./EPLTable.png s3://epltable/ --recursive

