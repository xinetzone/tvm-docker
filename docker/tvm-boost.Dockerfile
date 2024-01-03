# 镜像名称 xinetzone/tvmx:tvm-boost
FROM xinetzone/tvmx:tvm-base
# Caffe deps
COPY install/ubuntu_install_boost.sh /install/ubuntu_install_boost.sh
RUN bash /install/ubuntu_install_boost.sh
