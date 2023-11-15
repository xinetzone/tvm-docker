# 镜像名称 xinetzone/tvmx:tvm-full-conda-llvm
FROM xinetzone/tvmx:tvm-full-conda
WORKDIR /root/workspace/
COPY llvm.sh /root/workspace/llvm.sh
# 配置环境
RUN apt-get update && apt install -y --no-install-recommends lsb-release software-properties-common \
    && chmod +x llvm.sh \
    && ./llvm.sh all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt \
    && apt-get update && apt install -y --no-install-recommends \
    llvm-12 clang-12 clangd-12 liblldb-dev libedit-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/* 
