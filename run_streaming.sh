export SPARK_HOME=`pwd`/spark-1.6.1-bin-hadoop2.6
spark-1.6.1-bin-hadoop2.6/bin/spark-submit --master local[4] --class com.example.streaming.CarEventsProcessor car-streaming-data-0.1-jar-with-dependencies.jar localhost:9092 jobDescRecepie localhost:2181 sample4 &
