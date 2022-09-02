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

## 自定义

`basic/tvm-base.Dockerfile` 默认 Python 3.8，可以自定义生成其他基础镜像，比如 `xinetzone/xinetzone:anaconda3`：

```Dockerfile
# 镜像名称 tvmx:base
FROM xinetzone/xinetzone:anaconda3
```

## 注意事项