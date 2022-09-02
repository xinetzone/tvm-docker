# TVM/VTA Docker

## 基础 docker 环境

```bash
docker build -t tvmx:base -f basic/tvm-base.Dockerfile ./basic
docker build -t tvmx:torch -f basic/tvm-torch.Dockerfile ./basic
docker build -t tvmx:xinet -f basic/tvm-xinet.Dockerfile ./basic
```

1. `basic/tvm-base.Dockerfile`：TVM 基础环境
2. `basic/tvm-torch.Dockerfile`：TVM + Torch 环境
3. `basic/tvm-xinet.Dockerfile`：添加 sudo 支持（密码默认为 `1`）
4. `basic/sources.list`：添加豆瓣源
5. `xinetzone/tvm-base.Dockerfile`：提供最基础的 TVM ubuntu22.04 环境

## 自定义

`basic/tvm-base.Dockerfile` 默认 Python 3.8，可以自定义生成其他基础镜像，比如 `xinetzone/xinetzone:anaconda3`：

```Dockerfile
# 镜像名称 tvmx:base
FROM xinetzone/xinetzone:anaconda3
```

## 注意事项

使用 `basic/tvm-base.Dockerfile` 搭建 TVM 基础环境后，将 [TVM 源码](https://github.com/daobook/tvm) 挂载到该镜像生成的容器下，接着，进入 TVM 根目录，执行如下命令配置 TVM：

```bash
pip install invoke d2py
cd xinetzone
invoke init
invoke config
invoke make
```

如果想要启用 CUDA，只需：

```bash
invoke config --cuda
invoke make
```

更多配置见：`xinetzone/tasks.py`。
