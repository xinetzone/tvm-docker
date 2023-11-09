# 镜像名称 xinetzone/tvmx:caffe-conda
FROM xinetzone/tvmx:py38
# 添加 miniconda
# 配置环境
RUN mkdir -p ~/miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
    && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
    && rm -rf ~/miniconda3/miniconda.sh
    # && ~/miniconda3/bin/conda init bash \
    # && ~/miniconda3/bin/conda init zsh
# COPY py38.yaml /root/workspace/py38.yaml
# WORKDIR /root/workspace/
# RUN ~/miniconda3/bin/conda env create -f py38.yaml -y \
#     && ~/miniconda3/bin/conda clean -a
WORKDIR /home/workspace/
