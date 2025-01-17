FROM hub.deepin.com/library/debian:12
ENV DEBIAN_FRONTEND=noninteractive
RUN set -e; \
    mkdir -p /etc/apt/sources.list.d/; \
    rm -rf /etc/apt/sources.list.d/debian.sources; \
    echo "\
deb http://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
deb http://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
deb http://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
deb http://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\n" > /etc/apt/sources.list.d/ustc.list; \
    apt-get update; \
    apt-get install -y apt-transport-https ca-certificates; \
    echo "\
deb https://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
deb https://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
deb https://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
deb https://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\n" > /etc/apt/sources.list.d/ustc.list;
RUN apt update && \
    apt upgrade -y && \
    apt install -y git cmake make ca-certificates jq pv