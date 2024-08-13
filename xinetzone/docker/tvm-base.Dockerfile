# 镜像名称 xinetzone/tvmx:tvm-base
FROM ubuntu:22.04
COPY utils/apt-install-and-clear.sh /usr/local/bin/apt-install-and-clear
RUN apt-get update --fix-missing
COPY install/ubuntu_setup_tz.sh /install/ubuntu_setup_tz.sh
# 设置时区
RUN bash /install/ubuntu_setup_tz.sh
# 安装核心包
COPY install/ubuntu2004_install_core.sh /install/ubuntu_install_core.sh
RUN bash /install/ubuntu_install_core.sh
# 安装 cmake
COPY install/ubuntu_install_cmake_source.sh /install/ubuntu_install_cmake_source.sh
RUN bash /install/ubuntu_install_cmake_source.sh
# 安装 PAPI
COPY install/ubuntu_install_papi.sh /install/ubuntu_install_papi.sh
RUN bash /install/ubuntu_install_papi.sh ""
# # BYODT deps
# COPY install/ubuntu_install_universal.sh /install/ubuntu_install_universal.sh
# RUN bash /install/ubuntu_install_universal.sh
# # 安装 DNNL
# COPY install/ubuntu_install_dnnl.sh /install/ubuntu_install_dnnl.sh
# RUN bash /install/ubuntu_install_dnnl.sh
# # NNPACK deps
# COPY install/ubuntu_install_nnpack.sh /install/ubuntu_install_nnpack.sh
# RUN bash /install/ubuntu_install_nnpack.sh
