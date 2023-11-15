# 镜像名称 xinetzone/tvmx:caffe-full
# FROM xinetzone/tvmx:caffe-full-compile
FROM xinetzone/tvmx:caffe-py38
# 元数据
LABEL maintainer="xinetzone" email="q735613050@163.com"
# COPY sources.list /etc/apt/sources.list

VOLUME [ "/data" ]
# 添加源并更新，添加 TVM 必备包
COPY caffe-env/temp /data/
ENV CAFFE_ROOT=/data/caffe
WORKDIR /data
RUN pip install invoke numpy scikit-image protobuf==3.20.3 --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && invoke compile
# 设置环境变量
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/.build_release/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/.build_release/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# WORKDIR /home/workspace/
# COPY bugs/cProfile.py /usr/local/lib/python3.8/cProfile.py
