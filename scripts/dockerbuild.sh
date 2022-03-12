#!/bin/bash

docker build -t nosaugowe/epl .

aws cp /opt/epl/EPLTable.png s3://epltable/EPLTable.png