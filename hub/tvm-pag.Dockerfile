# 镜像名称 build-tvm
FROM python:3.12
# 添加源并更新
COPY sources.list /etc/apt/sources.list
# 添加 TVM 必备包
RUN apt-get update \
    && apt-get install -y --no-install-recommends ccache patchelf \
    && pip install --upgrade pip \
    && pip3 install d2py nuitka invoke hatch tqdm --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple
WORKDIR /home/workspace/tools/npu_packege_build_tools
