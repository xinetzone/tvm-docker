# 镜像名称 xinetzone/tvmx:py38
FROM xinetzone/tvmx:caffe-py38
# 元数据
LABEL maintainer="xinetzone" email="q735613050@163.com"
# COPY sources.list /etc/apt/sources.list

VOLUME [ "/data" ]
# 添加源并更新，添加 TVM 必备包
COPY caffe-env/temp /data/
ENV CAFFE_ROOT=/data/caffe
WORKDIR /data
RUN pip install invoke --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && invoke compile
# 设置环境变量
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/.build_release/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/.build_release/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# 保证 libopencv-dev 正常安装
ENV DEBIAN_FRONTEND=noninteractive 
ENV LANG=C.UTF-8
# 添加源并更新，添加 TVM 必备包
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf\
    && pip install scikit-image protobuf==3.20.3 decorator scipy attrs pandas toml synr d2py invoke --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    # && apt-get install pkg-config-arm-linux-gnueabihf
    && pip install torch torchvision torchaudio -i https://pypi.tuna.tsinghua.edu.cn/simple --index-url https://download.pytorch.org/whl/cpu --no-cache-dir \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /home/workspace/
COPY bugs/cProfile.py /usr/local/lib/python3.8/cProfile.py
