# 镜像名称 xinetzone/tvmx:tvm-full
FROM xinetzone/tvmx:tvm-caffe-torch-onnx
# 安装 LLVM
COPY install/ubuntu2204_install_llvm.sh /install/ubuntu2204_install_llvm.sh
RUN bash /install/ubuntu2204_install_llvm.sh \
    && pip install pytest --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 