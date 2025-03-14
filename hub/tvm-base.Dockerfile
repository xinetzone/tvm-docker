# tvm:base
FROM xinetzone/tvmx:tvm-full-conda
RUN /root/miniconda3/bin/conda init
# RUN /root/miniconda3/bin/conda create -n ai python=3.12 \
#     && . /root/.bashrc \
#     && conda activate ai \
#     && pip install --no-cache-dir onnx numpy pandas plotly pillow scipy \
#     pytest tqdm opencv-python toml tabulate tomlkit openpyxl \
#     telnetlib3 -i https://pypi.tuna.tsinghua.edu.cn/simple \
#     && pip install --no-cache-dir torch torchvision torchaudio \
#     --index-url https://download.pytorch.org/whl/cpu
