# 镜像名称 xinetzone/tvmx:tvm-conda-caffe
FROM xinetzone/tvmx:tvm-conda
# Caffe
ENV CAFFE_HOME /opt/caffe
ENV PYCAFFE_HOME $CAFFE_HOME/python
ENV PYTHONPATH $PYCAFFE_HOME:$PYTHONPATH
COPY caffe.tar.gz /install/caffe.tar.gz
COPY conda/caffe.sh /install/ubuntu_install_caffe.sh 
RUN bash /install/ubuntu_install_caffe.sh && echo "conda activate ai" >> ~/.bashrc
# # 安装 PAPI
# COPY install/ubuntu_install_papi.sh /install/ubuntu_install_papi.sh
# RUN bash /install/ubuntu_install_papi.sh ""
# # BYODT deps
# COPY install/ubuntu_install_universal.sh /install/ubuntu_install_universal.sh
# RUN bash /install/ubuntu_install_universal.sh
# # 安装 DNNL
# COPY install/ubuntu_install_dnnl.sh /install/ubuntu_install_dnnl.sh
# RUN bash /install/ubuntu_install_dnnl.sh
# # NNPACK deps
# COPY install/ubuntu_install_nnpack.sh /install/ubuntu_install_nnpack.sh
# RUN bash /install/ubuntu_install_nnpack.sh
