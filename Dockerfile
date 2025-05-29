FROM debian:11
ENV DEBIAN_FRONTEND=noninteractive
ENV GO_VERSION="go1.20.14"
ENV GOROOT="/gosdk/${GO_VERSION}"
ENV PATH="${GOROOT}/bin:${PATH}"

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
        neofetch \
        build-essential \
        git \
        debhelper \
        rsync \
    && echo "Basic tools installed."

# Install Go SDK
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
    install_go_sdk "${GO_VERSION}"

