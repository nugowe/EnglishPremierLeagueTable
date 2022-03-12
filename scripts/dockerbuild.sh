#!/bin/bash

docker build -t nosaugowe/epl .

aws s3 cp /opt/epl/EPLTable.png s3://epltable/EPLTable.png