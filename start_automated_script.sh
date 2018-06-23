

echo "step 1) starting Kafka"

sh run_kafka.sh

sleep 15

echo "Step 2) Start Solr"

sh run_solr.sh
sleep 15

echo "Step 3) Initialize Solr"


sh index_creation.sh

sleep 15

kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic jobDescRecepie
echo "Step 4) Starting Spark"

sh run_streaming.sh

sleep 60
echo "Step 5"

../flume/bin/flume-ng agent --conf ../flume/conf/ -f ../flume/conf/flume-conf.properties -Dflume.root.logger=DEBUG,console -n a1




