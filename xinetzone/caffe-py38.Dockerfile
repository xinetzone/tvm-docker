# 镜像名称 xinetzone/tvmx:caffe-py38
FROM python:3.8
# 元数据
LABEL maintainer="xinetzone" email="q735613050@163.com"
# COPY sources.list /etc/apt/sources.list

# 保证 libopencv-dev 正常安装
# ENV DEBIAN_FRONTEND=noninteractive 
# ENV LANG=C.UTF-8
# 添加源并安装一些必需包
# RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y --no-install-recommends \
    libatlas-base-dev \
    libleveldb-dev \
    liblmdb-dev \
    libgflags-dev \
    libhdf5-serial-dev \
    libopencv-dev \
    libgoogle-glog-dev \
    libsnappy-dev \
    python3-numpy pip \
    && pip install invoke numpy scikit-image six protobuf==3.20.3 \
        --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 
# 添加源并更新，添加 TVM 必备包
# COPY caffe-env/temp /data/
ENV CAFFE_ROOT=/data/caffe
    # && invoke compile
# 设置环境变量
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/.build_release/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/.build_release/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
VOLUME [ "/data", "/home" ]
WORKDIR /data
