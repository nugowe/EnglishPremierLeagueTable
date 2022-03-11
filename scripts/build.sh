#!/bin/bash

set -x


sudo apt-get install -yq tzdata && sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && sudo dpkg-reconfigure -f noninteractive tzdata


echo "obtaining R directory"

Rscript /opt/epl/scripts/EPLTable.R


