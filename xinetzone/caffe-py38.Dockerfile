# 镜像名称 xinetzone/tvmx:caffe-py38
FROM python:3.8
# COPY sources.list /etc/apt/sources.list

# 保证 libopencv-dev 正常安装
# ENV DEBIAN_FRONTEND=noninteractive 
# ENV LANG=C.UTF-8
# 添加源并安装一些必需包
# RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ make cmake \
    libatlas-base-dev \
    libleveldb-dev \
    liblmdb-dev \
    libgflags-dev \
    libhdf5-serial-dev \
    libopencv-dev \
    libgoogle-glog-dev \
    libsnappy-dev \
    python3-numpy pip \
    && pip install invoke --no-cache-dir \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 

