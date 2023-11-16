# 镜像名称 xinetzone/tvmx:tvm-full-conda-llvm
FROM xinetzone/tvmx:tvm-full-conda
WORKDIR /root/workspace/
# COPY llvm.sh /root/workspace/llvm.sh
# 配置环境
RUN apt-get update && apt install -y --no-install-recommends lsb-release software-properties-common \
    # && chmod +x llvm.sh \
    # && ./llvm.sh all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt \
    && apt-get update && apt install -y --no-install-recommends \
    git gcc g++ libtinfo-dev zlib1g-dev build-essential make cmake \
    llvm clang clangd liblldb-dev libedit-dev libxml2-dev \
    && pip install nuitka==1.6.6 hatch --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && rm -rf /var/lib/apt/lists/* 
