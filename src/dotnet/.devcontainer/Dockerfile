FROM mcr.microsoft.com/devcontainers/dotnet:0-7.0

ARG REDIS_INSTALL
# install redis
# https://redis.io/docs/getting-started/installation/install-redis-on-linux/
RUN if [["$REDIS_INSTALL" = "true"]]; then \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install lsb-release gpg -y && \
    curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list && \
    apt-get update && apt-get install redis -y; \
    else echo ""; fi