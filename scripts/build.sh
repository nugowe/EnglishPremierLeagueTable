#!/bin/bash

set -x


Rscript /opt/epl/scripts/EPLTable.R && bash /opt/epl/scripts/adhocTransfer.sh


echo "listing pwd"

ls



