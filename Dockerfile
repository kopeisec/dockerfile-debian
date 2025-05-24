FROM debian:11
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade
RUN \
    apt update && \
    apt upgrade -y

# Install basic tools \
RUN \
    apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        iputils-ping \
        jq \
        ncat \
        ncdu \
        net-tools \
        pv \
        rsync \
        tree \
        tzdata \
        wget \
        xz-utils \
    && echo "Basic tools installed."

# Install mc
RUN \
    case $(uname -m) in \
    x86_64|amd64) \
        curl https://dl.min.io/client/mc/release/linux-amd64/mc \
            -fsSL --create-dirs -o /usr/bin/mc \
    ;; \
    aarch64|arm64) \
        curl https://dl.min.io/client/mc/release/linux-arm64/mc \
            -fsSL --create-dirs -o /usr/bin/mc \
    ;; \
    esac && \
    chmod +x /usr/bin/mc

# Install yq
RUN \
    case $(uname -m) in \
    x86_64|amd64) \
        curl https://github.com/mikefarah/yq/releases/download/v4.45.1/yq_linux_amd64 \
            -fsSL --create-dirs -o /usr/bin/yq \
    ;; \
    aarch64|arm64) \
        curl https://github.com/mikefarah/yq/releases/download/v4.45.1/yq_linux_arm64 \
            -fsSL --create-dirs -o /usr/bin/yq \
    ;; \
    esac && \
    chmod +x /usr/bin/yq

# Install rclone
RUN \
    apt install -y rclone

# Install go1.23.9
RUN \
    install_go_sdk() { \
        go_version="${1:?}" && \
        case $(uname -m) in \
            x86_64|amd64) \
                curl -fsSLO "https://go.dev/dl/${go_version}.linux-amd64.tar.gz" && \
                tar -zxf "${go_version}.linux-amd64.tar.gz" && \
                mv go/   "${go_version}/" && \
                rm -f    "${go_version}.linux-amd64.tar.gz" \
                ;; \
            aarch64|arm64) \
                curl -fsSLO "https://go.dev/dl/${go_version}.linux-arm64.tar.gz" && \
                tar -zxf "${go_version}.linux-arm64.tar.gz" && \
                mv go/   "${go_version}/" && \
                rm -f    "${go_version}.linux-arm64.tar.gz" \
                ;; \
        esac \
    } && \
    mkdir -p /gosdk/ && \
    cd /gosdk/ && \
    install_go_sdk 'go1.20.14' && \
    install_go_sdk 'go1.21.13' && \
    install_go_sdk 'go1.22.12' && \
    install_go_sdk 'go1.23.9' && \
    install_go_sdk 'go1.24.3'

# Install mediawiki-page-publish
RUN \
    GOROOT="/gosdk/go1.20.14" && \
    PATH="${GOROOT}/bin:${PATH}" && \
    mkdir -p /src/ && \
    cd /src/ && \
    git clone https://github.com/ismdeep/mediawiki-page-publish.git && \
    cd /src/mediawiki-page-publish/ && \
    go build -o /usr/bin/mediawiki-page-publish -mod vendor -trimpath -ldflags '-s -w' . && \
    cd / && \
    rm -rf /src/ && \
    rm -rf /root/.cache/ && \
    rm -rf /root/go/
