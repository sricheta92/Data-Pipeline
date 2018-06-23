FROM centos:centos6


#Intsall tools which are required
#RUN apt-get update && apt-get install -y wget curl git sudo tar bc man unzip passwd vim
#RUN apt-get install -y software-properties-common

#RUN apt-add-repository ppa:webupd8team/java
#RUN apt-get install oracle-java8-installer


RUN yum -y update;
RUN yum -y clean all;


#Intsall tools which are required
RUN yum install -y wget dialog curl sudo lsof vim axel telnet nano openssh-server openssh-clients bzip2 passwd tar bc git unzip

#Install Java
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

#Create pipeline-admin user.
RUN useradd pipeline-admin -u 1000
RUN echo pipeline-admin | passwd pipeline-admin --stdin

ENV HOME /home/testy
WORKDIR $HOME

USER pipeline-admin
USER root

RUN wget http://archive.apache.org/dist/flume/stable/apache-flume-1.8.0-bin.tar.gz
RUN tar -xvf apache-flume-1.8.0-bin.tar.gz
RUN mv apache-flume-1.8.0-bin flume

ENV PATH $HOME/flume/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

#USER root

#Environment variables
ADD flume-env.sh flume/conf/flume-env.sh
#RUN echo . ./flume-env.sh >> .bashrc

ADD my_log_file.log $HOME/log-sample/my_log_file.log
RUN chmod +x /home/testy/log-sample/my_log_file.log


#Install Spark
#Spark 2.0.0, precompiled with : mvn -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.0 -Dyarn.version=2.6.0 -DskipTests -Dscala-2.11 -Phive -Phive-thriftserver clean package
RUN wget http://archive.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz 
RUN tar -xvzf spark-1.6.1-bin-hadoop2.6.tgz
ADD spark-1.6.1-bin-hadoop2.6 /home/testy/spark-solr/spark-1.6.1-bin-hadoop2.6

ENV SPARK_HOME $HOME/spark

#Install Kafka
#RUN yum install zookeeperd
RUN wget http://apache.belnet.be/kafka/0.10.2.1/kafka_2.10-0.10.2.1.tgz
RUN tar xvzf kafka_2.10-0.10.2.1.tgz
RUN mv kafka_2.10-0.10.2.1 kafka
ADD kafka /home/testy/spark-solr/kafka

ENV PATH $HOME/spark/bin:$HOME/spark/sbin:$HOME/kafka/bin:$PATH

#Startup (start SSH, Cassandra, Zookeeper, Kafka producer)
ADD run_kafka.sh  /home/testy/spark-solr/run_kafka.sh
RUN chmod +x /home/testy/spark-solr/run_kafka.sh

#Solr setup
RUN wget http://archive.apache.org/dist/lucene/solr/5.5.1/solr-5.5.1.tgz
RUN tar xvzf solr-5.5.1.tgz
ADD solr-5.5.1 /home/testy/spark-solr/solr-5.5.1
ADD run_solr.sh  /home/testy/spark-solr/run_solr.sh
RUN chmod +x /home/testy/spark-solr/run_solr.sh
ADD run_solr.sh  /home/testy/spark-solr/index_creation.sh
RUN chmod +x /home/testy/spark-solr/index_creation.sh


ADD flume-conf.properties /home/testy/flume/conf/flume-conf.properties
RUN chown pipeline-admin:pipeline-admin /home/testy/flume/conf/flume-conf.properties


ADD start-flume.sh /home/testy/flume/bin/start-flume.sh
RUN chmod +x /home/testy/flume/bin/start-flume.sh

ADD car-streaming-data-0.1-jar-with-dependencies.jar /home/testy/spark-solr/car-streaming-data-0.1-jar-with-dependencies.jar
ADD run_streaming.sh /home/testy/spark-solr/run_streaming.sh
RUN chmod +x /home/testy/spark-solr/run_streaming.sh

ADD start_automated_script.sh /home/testy/spark-solr/start_automated_script.sh
RUN chmod +x /home/testy/spark-solr/start_automated_script.sh

EXPOSE 4545
