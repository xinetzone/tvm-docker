# 镜像名称 xinetzone/tvmx:tvm-full-conda-llvm
FROM xinetzone/tvmx:tvm-full-conda
WORKDIR /root/workspace/
COPY llvm.sh /root/workspace/llvm.sh
# 配置环境
RUN apt-get update && apt install -y --no-install-recommends lsb-release software-properties-common \
    && chmod +x llvm.sh \
    && ./llvm.sh all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt \
    && apt-get update && apt install -y --no-install-recommends llvm-12 \
    && rm -rf /var/lib/apt/lists/* 
    # && ~/miniconda3/bin/conda init bash \
    # && ~/miniconda3/bin/conda init zsh
