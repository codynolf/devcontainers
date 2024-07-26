ARG BASE_IMAGE_TAG
FROM eclipse-temurin:${BASE_IMAGE_TAG:-11.0.16.1_1-jdk}

ARG HBASE_VERSION

RUN \
  apt-get update && \
  apt-get install git nano -y

#ARG HBASE_VERSION
RUN \
    mkdir /hbase && \
    curl -fsL "https://dlcdn.apache.org/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz" | tar xzvf - -C /hbase

ENV HBASE_HOME /hbase/hbase-$HBASE_VERSION

#CMD ["$HBASE_HOME/start-hbase.sh"]