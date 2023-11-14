# 镜像名称 build-tvm
FROM python:3.8.13
# 添加源并更新
# COPY sources.list /etc/apt/sources.list
# 添加 TVM 必备包
RUN apt-get update && apt-get install -y --no-install-recommends ccache patchelf \
    && pip install --upgrade pip \
    && pip install tqdm nuitka==1.6.6 invoke hatch d2py \
        --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && rm -rf /var/lib/apt/lists/* 

# # 添加 TVM 环境
# RUN echo "export TVM_HOME=/data/workspace/tvm" >> /root/.bashrc \
#     && echo "export PYTHONPATH=\$TVM_HOME/python:\${PYTHONPATH}" >> /root/.bashrc \
#     && echo "export VTA_HW_PATH=\$TVM_HOME/3rdparty/vta-hw" >> /root/.bashrc \
#     && echo "export PYTHONPATH=\$TVM_HOME/vta/python:\${PYTHONPATH}" >> /root/.bashrc

COPY tasks.py /tasks.py
