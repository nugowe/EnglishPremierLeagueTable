#!/bin/bash

docker build -t nosaugowe/epl .

aws s3 cp /opt/epl/scripts/build.sh s3://epltable/EPLTable.png