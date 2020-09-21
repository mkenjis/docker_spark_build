# to download Spark, issue
# wget http://ftp.unicamp.br/pub/apache/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz

FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes default-jre \
    && apt-get install --yes python \
	&& apt-get install --yes python-pip
	
WORKDIR /opt/local/spark-2.4.7
COPY spark-2.4.7 .

WORKDIR /root
COPY winequality-red.csv .

ENV SPARK_HOME=/opt/local/spark-2.4.7
ENV PATH=$PATH:.:$SPARK_HOME/bin:$SPARK_HOME/sbin

EXPOSE 4040

CMD ["spark-shell"]
