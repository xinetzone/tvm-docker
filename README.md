# TVM/VTA Docker

```bash
docker build -t xinetzone/tvmx:base -f xinetzone/tvm-base.Dockerfile ./xinetzone --no-cache
docker build -t xinetzone/tvmx:conda -f xinetzone/tvm-conda.Dockerfile ./xinetzone --no-cache
```

- `xinetzone/tvmx:base`：TVM 基础环境
- `xinetzone/tvmx:conda`：TVM 基础环境 + PyTorch GPU + miniconda


## 制作 caffe 包

- `xinetzone/tvmx:caffe-py38`：caffe Python3.8 环境需要挂载 caffe
- `xinetzone/tvmx:caffe-full`：caffe Python3.8 完整环境
- `xinetzone/tvmx:tvm`：TVM 基础环境 + caffe + torch + onnx
- `xinetzone/tvmx:tvm-conda`：TVM 基础环境 + caffe + torch + onnx + miniconda

```bash
cd xinetzone/caffe-env && invoke tar && cp tasks.py temp/tasks.py && cd ../..
docker build -t xinetzone/tvmx:caffe-py38 -f xinetzone/caffe-py38.Dockerfile ./xinetzone --no-cache
docker build -t xinetzone/tvmx:caffe-full -f xinetzone/caffe-full.Dockerfile ./xinetzone --no-cache
docker build -t xinetzone/tvmx:tvm -f xinetzone/tvm.Dockerfile ./xinetzone --no-cache
docker build -t xinetzone/tvmx:tvm-full-conda -f xinetzone/tvm-full-conda.Dockerfile ./xinetzone --no-cache
```

其中 `/media/pc/data/lxw/ai/tvm-docker/xinetzone/caffe-env` 是 `tvm-docker/xinetzone/caffe-env` 的绝对路径。

## 保存

```bash
docker save -o tvm.tar xinetzone/tvmx:tvm
docker save -o tvm-full-conda.tar xinetzone/tvmx:tvm-full-conda
docker save -o tvm-conda.tar xinetzone/tvmx:conda
```

## 其他

```bash
docker run -it -d -v /media/pc/data/lxw/ai/tvm-docker/xinetzone/caffe-env:/data xinetzone/tvmx:ttvm
```

```bash
docker run -it -d -v /media/pc/data/lxw/work/workspace:/home/workspace -v /media/pc/data/lxw/home:/media/pc/data/lxw/home -v /media/pc/data/board/arria10/lxw/npu_user_demos:/home/workspace/npu_user_demos xinetzone/tvmx:tvm-full-conda
```
