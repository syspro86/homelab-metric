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
      "expr":"sum by (instance) (irate(container_cpu_usage_seconds_total{id=\"/\"} [5m]))",
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
 > ../data/${DT_YEAR}/${DT_MONTH}/${DT_DAY}/cpu.json

