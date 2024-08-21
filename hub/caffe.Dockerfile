# FROM xinetzone/conda-caffe:latest as builder
# WORKDIR /caffe_src
# RUN make clean
# WORKDIR /data
# FROM ubuntu:latest
# COPY --from=builder /caffe_src /data/caffe_src
# 镜像名称 caffe-py38
# FROM xinetzone/tvmx:cpu-caffe-torch as caffe-env
# WORKDIR /data
# FROM python:3.8
# WORKDIR /data
# COPY --from=caffe-env /opt/caffe ./
# FROM xinetzone/tvmx:cpu-caffe-torch
# COPY ./update_caffe.sh /data
# WORKDIR /data
# RUN bash update_caffe.sh
FROM ubuntu:22.04

COPY utils/apt-install-and-clear.sh /usr/local/bin/apt-install-and-clear
RUN apt-get update --fix-missing

# Caffe deps
COPY install/ubuntu_install_boost.sh /install/ubuntu_install_boost.sh
RUN bash /install/ubuntu_install_boost.sh

# Caffe
COPY install/ubuntu_install_caffe.sh /install/ubuntu_install_caffe.sh
RUN bash /install/ubuntu_install_caffe.sh
