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
# FROM continuumio/miniconda3

# COPY utils/apt-install-and-clear.sh /usr/local/bin/apt-install-and-clear
# RUN apt-get update --fix-missing \
#     && apt-install-and-clear -y --no-install-recommends clang g++ gcc

# # Caffe & Caffe deps
# COPY install/ubuntu_install_caffe.sh /install/ubuntu_install_caffe.sh
# RUN conda create -n py310 python=3.10
# # Make RUN commands use the new environment:
# 
# RUN conda install -c conda-forge anaconda::mkl gtest libstdcxx-ng boost make cmake \
#     && bash /install/ubuntu_install_caffe.sh
FROM xinetzone/tvmx:caffe-torch
RUN python -c "import caffe"
# RUN conda create -n py310 python=3.10
# # Make RUN commands use the new environment (https://kevalnagda.github.io/conda-docker-tutorial)
# SHELL ["conda", "run", "-n", "py310", "/bin/bash", "-c"]
# RUN pip install nuitka && cd /caffe_src/python \
#     && python3 -m nuitka --module caffe/ --include-package=caffe \
#     && ls
