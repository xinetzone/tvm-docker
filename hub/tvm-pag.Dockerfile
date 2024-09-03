FROM python:3.10
# 添加源并更新
# COPY sources.list /etc/apt/sources.list
# 添加 TVM 必备包
RUN apt-get update \
    && apt-get install -y --no-install-recommends ccache patchelf \
    && pip install --upgrade pip \
    && pip3 install d2py nuitka==1.6.6 invoke hatch tqdm --no-cache-dir
