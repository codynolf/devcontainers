# Pull base image
ARG BASE_IMAGE_TAG
FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu

# Env variables
ARG SCALA_VERSION
ENV SCALA_VERSION ${SCALA_VERSION:-3.3.1}
ARG SBT_VERSION
ENV SBT_VERSION ${SBT_VERSION:-1.10.11}
ARG FLINK_INSTALL
ARG FLINK_VERSION
ENV FLINK_VERSION ${FLINK_VERSION:-1.17.1}
ARG USER_ID
ENV USER_ID ${USER_ID:-1001}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1001}

RUN \
  apt-get update && \
  apt-get install git -y && \
  apt-get install rpm -y && \
  apt-get install systemd -y && \
  apt-get install curl -y && \
  apt-get install tar -y && \
  rm -rf /var/lib/apt/lists/*

# Install sbt
RUN mkdir -p /usr/share && \
  curl -fsL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" -o /tmp/sbt.tgz && \
  tar xfz /tmp/sbt.tgz -C /usr/share && \
  chown -R root:root /usr/share/sbt && \
  chmod -R 755 /usr/share/sbt && \
  ln -s /usr/share/sbt/bin/sbt /usr/local/bin/sbt

# Install Scala
RUN \
  case $SCALA_VERSION in \
    "3"*) URL=https://github.com/lampepfl/dotty/releases/download/$SCALA_VERSION/scala3-$SCALA_VERSION.tar.gz SCALA_DIR=/usr/share/scala3-$SCALA_VERSION ;; \
    *) URL=https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz SCALA_DIR=/usr/share/scala-$SCALA_VERSION ;; \
  esac && \
  curl -fsL $URL | tar xfz - -C /usr/share && \
  mv $SCALA_DIR /usr/share/scala && \
  chown -R root:root /usr/share/scala && \
  chmod -R 755 /usr/share/scala && \
  ln -s /usr/share/scala/bin/* /usr/local/bin && \
  case $SCALA_VERSION in \
    "3"*) echo '@main def main = println(s"Scala library version ${dotty.tools.dotc.config.Properties.versionNumberString}")' > test.scala ;; \
    *) echo "println(util.Properties.versionMsg)" > test.scala ;; \
  esac && \
  scala -nocompdaemon test.scala && rm test.scala

# install flink
RUN if [["$FLINK_INSTALL" = "true"]]; then wget -qO- https://dlcdn.apache.org/flink/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-scala_2.12.tgz | tar -xzf -; else echo ""; fi
ENV PATH "$PATH:/flink-$FLINK_VERSION/bin"

# Symlink java to have it available on sbtuser's PATH
RUN ln -s /opt/java/openjdk/bin/java /usr/local/bin/java

# Add and use user sbtuser
RUN groupadd --gid $GROUP_ID sbtuser && useradd -m --gid $GROUP_ID --uid $USER_ID sbtuser --shell /bin/bash
USER sbtuser

# Switch working directory
WORKDIR /home/sbtuser

# Prepare sbt (warm cache)
RUN mkdir -p project && \
    echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt && \
    echo "sbt.version=${SBT_VERSION}" > project/build.properties && \
    echo "// force sbt compiler-bridge download" > project/Dependencies.scala && \
    echo "case object Temp" > Temp.scala && \
    sbt sbtVersion && \
    sbt compile && \
    rm -r project && rm build.sbt && rm Temp.scala && rm -r target

# Link everything into root as well
# This allows users of this container to choose, whether they want to run the container as sbtuser (non-root) or as root
USER root
RUN \
  rm -rf /tmp/..?* /tmp/.[!.]* * && \
  ln -s /home/sbtuser/.cache /root/.cache && \
  ln -s /home/sbtuser/.sbt /root/.sbt && \
  touch /home/sbtuser/.sbt/.credentials && \
  if [ -d "/home/sbtuser/.ivy2" ]; then ln -s /home/sbtuser/.ivy2 /root/.ivy2; fi

# Switch working directory back to root
## Users wanting to use this container as non-root should combine the two following arguments
## -u sbtuser
## -w /home/sbtuser
WORKDIR /root

CMD sbt