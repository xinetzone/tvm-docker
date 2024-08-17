# FROM xinetzone/conda-caffe:latest as builder
# WORKDIR /caffe_src
# RUN make clean
# WORKDIR /data
# FROM ubuntu:latest
# COPY --from=builder /caffe_src /data/caffe_src
# 镜像名称 caffe-py38
FROM xinetzone/tvmx:cpu-caffe-torch
