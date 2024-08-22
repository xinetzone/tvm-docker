# # FROM xinetzone/conda-caffe:latest as builder
# # WORKDIR /caffe_src
# # RUN make clean
# # WORKDIR /data
# # FROM ubuntu:latest
# # COPY --from=builder /caffe_src /data/caffe_src
# # 镜像名称 caffe-py38
# # FROM xinetzone/tvmx:cpu-caffe-torch as caffe-env
# # WORKDIR /data
# # FROM python:3.8
# # WORKDIR /data
# # COPY --from=caffe-env /opt/caffe ./
# # FROM xinetzone/tvmx:cpu-caffe-torch
# # COPY ./update_caffe.sh /data
# # WORKDIR /data
# # RUN bash update_caffe.sh
# # FROM continuumio/miniconda3

# # COPY utils/apt-install-and-clear.sh /usr/local/bin/apt-install-and-clear
# # RUN apt-get update --fix-missing \
# #     && apt-install-and-clear -y --no-install-recommends clang g++ gcc

# # # Caffe & Caffe deps
# # COPY install/ubuntu_install_caffe.sh /install/ubuntu_install_caffe.sh
# # RUN conda create -n py310 python=3.10
# # # Make RUN commands use the new environment:
# # 
# # RUN conda install -c conda-forge anaconda::mkl gtest libstdcxx-ng boost make cmake \
# #     && bash /install/ubuntu_install_caffe.sh
# FROM xinetzone/tvmx:caffe-full as builder
# COPY utils/apt-install-and-clear.sh /usr/local/bin/apt-install-and-clear
# # 安装 conda
# RUN apt-get update && \
#     apt-get install -y wget bzip2
# RUN apt-get update --fix-missing \
#     && apt-install-and-clear -y --no-install-recommends wget bzip2
# # 下载Miniconda安装脚本
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
# # 运行安装脚本并删除它
# RUN bash miniconda.sh -b -p /opt/conda && rm miniconda.sh
# # 设置环境变量以使用Miniconda
# ENV PATH="/opt/conda/bin:$PATH"
# WORKDIR /caffe_src/python
# RUN conda create -n py310 python=3.10 && conda create -n py311 python=3.11 && conda create -n py312 python=3.12
# # Make RUN commands use the new environment (https://kevalnagda.github.io/conda-docker-tutorial)

# # SHELL ["conda", "run", "-n", "py310", "/bin/bash", "-cex"]
# # # 构建 caffe 包
# RUN cd /caffe_src/python/ && conda run -n py310 /bin/bash -c python3 -m pip install nuitka \
#     && conda run -n py310 /bin/bash -c python3 -m nuitka --module caffe --include-package=caffe \
#     && conda run -n py311 /bin/bash -c python3 -m pip install nuitka \
#     && conda run -n py311 /bin/bash -c python3 -m nuitka --module caffe --include-package=caffe \
#     && conda run -n py312 /bin/bash -c python3 -m pip install nuitka \
#     && conda run -n py312 /bin/bash -c python3 -m nuitka --module caffe --include-package=caffe \
#     && cd / && tar -czvf caffe_src.tar.gz /caffe_src/*

# WORKDIR /caffe_src/python

FROM continuumio/miniconda3
WORKDIR /data
COPY libs /data/libs
# # COPY --from=builder /caffe_src/python/caffe.cpython-39-x86_64-linux-gnu.so caffe.cpython-39-x86_64-linux-gnu.so
