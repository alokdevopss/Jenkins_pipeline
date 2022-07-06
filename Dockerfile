# # base image
# FROM openjdk:11

# # define spark and hadoop versions
# ENV SPARK_VERSION=3.2.0
# ENV HADOOP_VERSION=3.3.1
# # RUN mkdir target
# # COPY /target/spark-3.2.1-bin-hadoop3.2.tgz  /home/alok/spark-3.2.1-bin-hadoop3.2.tgz 
# # CMD ["java","-jar","/home/alok/spark-3.2.1-bin-hadoop3.2.tgz"]

# # download and install spark
# RUN mkdir -p /opt && \
#     cd /opt && \
#     curl http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz | \
#         tar -zx && \
#     ln -s spark-${SPARK_VERSION}-bin-hadoop2.7 spark && \
#     echo Spark ${SPARK_VERSION} installed in /opt

# # download and install hadoop
# RUN mkdir -p /opt && \
#     cd /opt && \
#     curl http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
#         tar -zx hadoop-${HADOOP_VERSION}/lib/native && \
#     ln -s hadoop-${HADOOP_VERSION} hadoop && \
#     echo Hadoop ${HADOOP_VERSION} native libraries installed in /opt/hadoop/lib/native

# add scripts and update spark default config
# ADD common.sh spark-master spark-worker /
# ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
# ENV PATH $PATH:/opt/spark/bin






FROM python:3.9-alpine3.15
RUN apk add --update git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git



