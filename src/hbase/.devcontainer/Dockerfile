ARG BASE_IMAGE_TAG
FROM eclipse-temurin:${BASE_IMAGE_TAG:-11.0.16.1_1-jdk}

RUN \
  apt-get update && \
  apt-get install git nano -y

#ARG HBASE_VERSION
RUN \
    mkdir /hbase && \
    curl -fsL "https://dlcdn.apache.org/hbase/2.5.5/hbase-2.5.5-bin.tar.gz" | tar xzvf - -C /hbase

#ENTRYPOINT ["/bin/bash", "/hbase/hbase-2.5.5/bin/start-hbase.sh"]