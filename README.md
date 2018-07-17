
# Flume->Kafka->Spark->Solr: data-pipeline
This project creates data pipeline which gets data from flume sender and processes using Kafka-> spark and stores in Solr through a single script.


![My Image](https://github.com/sricheta92/Data-Pipeline/blob/master/arch.png)




**Assumptions:**
```
Requires Docker
```


**Steps:**

 Download data-pipeline repository.

**Starting the script:**


 This might take some time (~approx 15-20 minutes) as it downloads all required packages, and starts Kafka, Spark, Solr and Flume
```
 sh startStreaming.sh <HOST MACHINE IP> or <EC2 INSTANCE NAME> <PEM file> <INPUT FILE TO BE READ>
```

![My Image](https://github.com/sricheta92/Data-Pipeline/blob/master/start.png)

![My Image](https://github.com/sricheta92/Data-Pipeline/blob/master/output.png)

```
Dashboard URL -  http://<Your mahchine name>:8963/solr
```

![My Image](https://github.com/sricheta92/Data-Pipeline/blob/master/solr.png)

