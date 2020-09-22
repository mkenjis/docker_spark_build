# to download Spark, issue
# wget http://ftp.unicamp.br/pub/apache/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz

FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes default-jre \
    && apt-get install --yes python \
    && apt-get install --yes python-pip \
    && pip install --upgrade pip \
    && pip install "jupyter[all]"
	
WORKDIR /opt/local/spark-2.4.7
COPY spark-2.4.7 .

WORKDIR /root

RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '172.17.0.2'" >>.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >>.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8888" >>.jupyter/jupyter_notebook_config.py

COPY jupyter_notebook_config.json .jupyter
COPY winequality-red.csv .

ENV SPARK_HOME=/opt/local/spark-2.4.7
ENV PATH=$PATH:.:$SPARK_HOME/bin:$SPARK_HOME/sbin

ENV PYSPARK_PYTHON=/usr/bin/python2.7
ENV PYSPARK_DRIVER_PYTHON=/usr/local/bin/jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --port=8888 --allow-root"

EXPOSE 4040 8888

CMD ["pyspark"]
