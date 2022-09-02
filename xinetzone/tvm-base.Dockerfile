# 镜像名称 xinetzone:tvm-base
FROM ubuntu:22.04
# 添加源并更新
# COPY sources.list /etc/apt/sources.list
# 元数据
LABEL maintainer="xinetzone" email="q735613050@163.com"
# 添加源并更新，添加 TVM 必备包
RUN apt-get update \
    && apt-get install --assume-yes apt-utils \
    && apt-get install -y gcc g++ libtinfo-dev zlib1g-dev build-essential cmake \
    && apt install -y clang clangd llvm liblldb-dev libedit-dev libxml2-dev \
    && apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
    && apt-get install -y pip \
    && python3 -m pip install decorator scipy attrs pandas toml synr d2py
# && apt-get install pkg-config-arm-linux-gnueabihf