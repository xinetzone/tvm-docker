# 镜像名称 xinetzone/tvmx:tvm-caffe
FROM xinetzone/tvmx:tvm-boost
# Caffe
ENV CAFFE_HOME /opt/caffe
ENV PYCAFFE_HOME $CAFFE_HOME/python
ENV PYTHONPATH $PYCAFFE_HOME:$PYTHONPATH
COPY caffe.tar.gz /install/caffe.tar.gz
# COPY caffe_src /caffe_src
COPY install/ubuntu_install_caffe.sh /install/ubuntu_install_caffe.sh
RUN bash /install/ubuntu_install_caffe.sh && rm -rf /var/lib/apt/lists/* 
