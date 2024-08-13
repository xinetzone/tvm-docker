# 镜像名称 xinetzone/tvmx:tvm-caffe-torch-onnx
FROM xinetzone/tvmx:tvm-caffe
WORKDIR /data
# COPY sources.list /etc/apt/sources.list
# 保证 libopencv-dev 正常安装
# ENV DEBIAN_FRONTEND=noninteractive 
# ENV LANG=C.UTF-8
# 添加源并安装一些必需包
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
# RUN sed -i s/deb.debian.org/mirrors.ustc.edu.cn/g /etc/apt/sources.list \
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     git gcc g++ libtinfo-dev zlib1g-dev build-essential make cmake \
#     gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf ccache patchelf \
#     # && apt-get install pkg-config-arm-linux-gnueabihf
RUN pip install torch torchvision torchaudio -i https://pypi.tuna.tsinghua.edu.cn/simple --index-url https://download.pytorch.org/whl/cpu --no-cache-dir \
    && pip install decorator scipy attrs pandas toml synr d2py invoke \
    onnx matplotlib tqdm brevitas --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    # libopenjp2-7-dev libgdal-dev \
    && rm -rf /var/lib/apt/lists/* 
# 设置环境变量
WORKDIR /home/workspace/
# COPY bugs/cProfile.py /usr/local/lib/python3.8/cProfile.py
