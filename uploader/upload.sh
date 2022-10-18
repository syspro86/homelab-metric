#!/bin/bash

cd $(dirname $0)
source ./query_var.env

./get_cpu.sh
./get_memory.sh

cd ../data/
git pull
git add ${DT_YEAR}/${DT_MONTH}/${DT_DAY}
echo ${DT_YEAR}-${DT_MONTH}-${DT_DAY} | git commit -F-
git push

