#!/bin/bash

docker build -t nosaugowe/epl .

aws s3 cp /opt/epl/EPLTable.R s3://epltable/EPLTable.png