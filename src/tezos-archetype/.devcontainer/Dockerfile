FROM ubuntu:22.04

# Environment Variables
ARG NODEJS_MAJOR_VERSION
ENV NODEJS_MAJOR_VERSION ${NODEJS_MAJOR_VERSION:-20}

# Install tezos-client
RUN apt-get update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:serokell/tezos -y
RUN touch /.containerenv
RUN apt-get install -y apt-transport-https tezos-client

# Install nodejs
RUN apt-get update
RUN apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODEJS_MAJOR_VERSION.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install nodejs -y

# Install completium-cli
RUN npm i '@completium/completium-cli' -g
RUN completium-cli init
RUN completium-cli mockup init
RUN completium-cli set endpoint mockup

# Set Tezos Environment to Ghostnet
#RUN octez-client --endpoint 'https://ghostnet.ecadinfra.com config update'
#RUN export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=yes

# Install git
RUN apt-get install git -y