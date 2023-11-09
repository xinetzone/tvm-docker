# 镜像名称 xinetzone/tvmx:caffe-py38
FROM python:3.8
# COPY sources.list /etc/apt/sources.list

# 保证 libopencv-dev 正常安装
ENV DEBIAN_FRONTEND=noninteractive 
ENV LANG=C.UTF-8
# 添加源并安装一些必需包
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && apt-get install -y --no-install-recommends \
    g++  \
    make \
    cmake \
    g++-arm-linux-gnueabihf \
    libatlas-base-dev \
    libleveldb-dev \
    liblmdb-dev \
    libgflags-dev \
    libhdf5-serial-dev \
    libopencv-dev \
    libgoogle-glog-dev \
    libsnappy-dev \
    python3-numpy \
    && pip install invoke --no-cache-dir \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 
# 安装 caffe
VOLUME /data
WORKDIR /data
# COPY caffe-env/* /data
# RUN tar -xvf caffe.tar.gz \
#     && tar -xvf boost-1.81.0.tar.gz \
#     && tar -xvf protobuf-3.17.3.tar.gz \
#     && rm *.gz
# 安装 py_caffe 依赖项
ENV CAFFE_ROOT=/data/caffe

# # 设置环境变量
# ENV PYCAFFE_ROOT $CAFFE_ROOT/python
# ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
# # # ENV PATH $CAFFE_ROOT/.build_release/tools:$PYCAFFE_ROOT:$PATH
# # # RUN echo "$CAFFE_ROOT/.build_release/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
# WORKDIR /home/workspace/

