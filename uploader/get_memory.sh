#!/bin/bash

source ./grafana.env
source ./query_var.env

generate_post_data()
{
  cat <<EOF
{
  "queries": [
    {
      "refId":"A",
      "instant":false,
      "exemplar":true,
      "expr":"sum by (instance) (container_memory_working_set_bytes{id=\"/\"})",
      "datasource":{"uid":"UtxwLYT7k","type":"prometheus"},
      "queryType":"timeSeriesQuery",
      "utcOffsetSec":32400,
      "legendFormat":"",
      "interval":"",
      "datasourceId":2,
      "intervalMs":60000,
      "maxDataPoints":1667
    }
  ],
  "from":"${TS_FROM}",
  "to":"${TS_TO}"
}
EOF
}

echo ${DT_YEAR}-${DT_MONTH}-${DT_DAY}
mkdir -p ../data/${DT_YEAR}/${DT_MONTH}/${DT_DAY}

curl -H "Authorization: Bearer ${GRAFANA_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "$(generate_post_data)" \
 ${GRAFANA_URL}/api/ds/query \
 > ../data/${DT_YEAR}/${DT_MONTH}/${DT_DAY}/memory.json

