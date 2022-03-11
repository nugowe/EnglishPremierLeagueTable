#!/bin/bash

set -x





sudo apt-get install -yq tzdata && sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && sudo dpkg-reconfigure -f noninteractive tzdata

sudo apt-get install r-base


Rscript /opt/epl/scripts/EPLTable.R


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


aws s3api list-objects --bucket $S3_BUCKET --prefix 'index' --query 'Contents[].{Key: Key, Size: Size}' > files.json

echo files.json

INDEX_FILE=$(cat files.json | jq '.[0].Size') 

if [[ $INDEX_FILE == 0 ]]; then
    INDEX_BUILD
else 
    echo "Index file present!"
fi


if [[ ! -e ./index.yaml ]]; then
    CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S") 
    aws s3 cp s3://$S3_BUCKET/index/index.yaml index.yaml
    cat index.yaml | awk "/version/{print$2}" | awk -F":" '{print $2}' > index_observe.yaml
    summation=1
    old_index_value=$(cat index_observe.yaml)
    sum=$(( $old_index_value + $summation ))
    echo """
  epl-table_logs:
    version: $sum
      logfile-name: s3://$S3_BUCKET/index/$EPL_PNG_FILE 
        timestamp: $CURRENT_TIME

  """ >> index.yaml

  echo "Performing a final transfer..."
  aws s3 cp /opt/epl/scripts/epltable.png s3://$S3_BUCKET/epl/$EPL_PNG_FILE && aws s3 cp /opt/epl/index.yaml s3://$S3_BUCKET/index/index.yaml

fi



