FROM debian:10
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade
RUN \
    (\
      true && \
      echo 'deb http://archive.debian.org/debian           buster           main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian           buster-updates   main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian           buster-backports main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian-security  buster/updates   main contrib non-free' && \
      true) | tee /etc/apt/sources.list && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
      ca-certificates \
      apt-transport-https \
    && true
