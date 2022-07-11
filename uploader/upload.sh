#!/bin/bash

source ./query_var.env

pushd ../data/
git pull
git add ${DT_YEAR}/${DT_MONTH}/${DT_DAY}
echo ${DT_YEAR}-${DT_MONTH}-${DT_DAY} | git commit -F-
git push

