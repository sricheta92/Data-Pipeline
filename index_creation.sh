solr-5.5.1/bin/solr delete -c sample4
solr-5.5.1/bin/solr zk -upconfig -n sample4 -d solr-5.5.1/server/solr/configsets/basic_configs/conf/ -z localhost:2181
solr-5.5.1/bin/solr create -c sample4
curl -X POST http://localhost:8983/solr/sample4/config -d '{"set-property":{"updateHandler.autoSoftCommit.maxTime":"2000"}}'
