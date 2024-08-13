# 镜像名称 xinetzone/tvmx:base
FROM ubuntu:22.04
# 元数据
LABEL maintainer="xinetzone" email="q735613050@163.com"
# COPY sources.list /etc/apt/sources.list
# 添加源并更新，添加 TVM 必备包
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    git gcc g++ libtinfo-dev zlib1g-dev build-essential make cmake \
    clang clangd llvm liblldb-dev libedit-dev libxml2-dev \
    gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf pip \
    && pip install decorator scipy attrs pandas toml synr --no-cache-dir \
    # && apt-get install pkg-config-arm-linux-gnueabihf
    && rm -rf /var/lib/apt/lists/* 
