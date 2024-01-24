# 构建 TVM 流程

在 `docker/` 下构建：

0. 构建 TVM 基础环境：
    ```bash
    docker build -f tvm-base.Dockerfile -t xinetzone/tvmx:tvm-base . --no-cache
    ```
1. 构建 caffe 镜像：
    ```bash
    docker build -t xinetzone/tvmx:tvm-boost -f tvm-boost.Dockerfile . --no-cache
    docker build -t xinetzone/tvmx:tvm-caffe -f tvm-caffe.Dockerfile . --no-cache
    ```
2. 构建 caffe+torch+onnx+llvm 镜像：
    ```bash
    docker build -t xinetzone/tvmx:tvm-caffe-torch-onnx -f tvm-caffe-torch-onnx.Dockerfile . --no-cache
    docker build -t xinetzone/tvmx:tvm-full -f tvm-full.Dockerfile . --no-cache
    ```
3. 构建 torch+onnx+llvm 镜像：
    ```bash
    docker build -t xinetzone/tvmx:tvm -f tvm.Dockerfile . --no-cache
    ```

## conda 镜像

```bash
docker build -t xinetzone/tvmx:tvm-conda -f tvm-conda.Dockerfile . --no-cache
docker build -t xinetzone/tvmx:tvm-conda-caffe -f tvm-conda-caffe.Dockerfile . --no-cache
```

