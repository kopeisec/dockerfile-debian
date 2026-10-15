FROM debian:12
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade
RUN \
    apt update && \
    apt upgrade -y && \
    apt install -y \
      ca-certificates \
      apt-transport-https \
    && true