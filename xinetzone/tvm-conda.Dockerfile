# 镜像名称 xinetzone/tvmx:conda
FROM xinetzone/tvmx:base
RUN pip install decorator scipy attrs pandas toml synr d2py invoke \
    torch torchvision torchaudio --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    # 添加 miniconda 环境
    && apt-get update && apt-get install -y wget \
    && mkdir -p ~/miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
    && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
    && rm -rf ~/miniconda3/miniconda.sh \
    && ~/miniconda3/bin/conda init bash \
    && ~/miniconda3/bin/conda init zsh
WORKDIR /home/workspace/
