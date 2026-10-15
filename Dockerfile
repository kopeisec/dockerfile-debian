FROM debian:11
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade
RUN \
    (\
      true && \
      echo 'deb http://archive.debian.org/debian           bullseye           main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian           bullseye-updates   main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian           bullseye-backports main contrib non-free' && \
      echo 'deb http://archive.debian.org/debian-security  bullseye-security  main contrib non-free' && \
      true) | tee /etc/apt/sources.list && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
      ca-certificates \
      apt-transport-https \
    && true
