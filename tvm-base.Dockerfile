# tvm:base
FROM continuumio/miniconda3 AS builder
RUN chmod -R a+w /opt/conda/ 
FROM xinetzone/tvmx:caffe-py38
COPY --from=builder /opt/conda /opt/conda
RUN /opt/conda/bin/conda create -n ai python=3.12
RUN /opt/conda/bin/conda init
RUN . /root/.bashrc && \
    /opt/conda/envs/ai/bin/pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple \
    "onnx" "numpy" "pandas" "plotly" "pillow" "scipy" \
    "pytest" "tqdm" "opencv-python" "toml" "tabulate" "tomlkit" "openpyxl" \
    "telnetlib3" \
    && \
    /opt/conda/envs/ai/bin/pip install --no-cache-dir \
    --index-url https://download.pytorch.org/whl/cpu \
    "torch" "torchvision" "torchaudio"

# 创建非特权用户
RUN useradd -m ai
USER ai
# 设置默认环境变量
ENV PATH="/opt/conda/envs/ai/bin:$PATH"

    
