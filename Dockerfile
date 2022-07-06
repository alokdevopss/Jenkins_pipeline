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





FROM python:3.6.8-alpine3.9

# LABEL MAINTAINER="FirstName LastName "

# ENV GROUP_ID=1000 
#     USER_ID=1000

WORKDIR /var/www/

ADD ../../requirements.txt /var/www/requirements.txt
RUN pip install -r requirements.txt
ADD . /var/www/
RUN pip install gunicorn

RUN addgroup -g $GROUP_ID www
RUN adduser -D -u $USER_ID -G www www -s /bin/sh

USER www

EXPOSE 5000

CMD [ "gunicorn", "-w", "4", "--bind", "0.0.0.0:5000", "wsgi"]


