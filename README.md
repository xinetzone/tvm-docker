# 构建 TVM 流程

![repo size](https://img.shields.io/github/repo-size/xinetzone/tvm-docker.svg)
[![GitHub issues][issue-badge]][issue-link]
[![GitHub forks][fork-badge]][fork-link]
[![GitHub stars][star-badge]][star-link]
[![GitHub license][license-badge]][license-link]
[![contributors][contributor-badge]][contributor-link]
[![watcher][watcher-badge]][watcher-link]
[![Binder][binder-badge]][binder-link]
[![Documentation Status][status-badge]][status-link]

学无止境！

[pypi-badge]: https://img.shields.io/pypi/v/tvm-docker.svg
[issue-badge]: https://img.shields.io/github/issues/xinetzone/tvm-docker
[issue-link]: https://github.com/xinetzone/tvm-docker/issues
[fork-badge]: https://img.shields.io/github/forks/xinetzone/tvm-docker
[fork-link]: https://github.com/xinetzone/tvm-docker/network
[star-badge]: https://img.shields.io/github/stars/xinetzone/tvm-docker
[star-link]: https://github.com/xinetzone/tvm-docker/stargazers
[license-badge]: https://img.shields.io/github/license/xinetzone/tvm-docker
[license-link]: https://github.com/xinetzone/tvm-docker/LICENSE
[contributor-badge]: https://img.shields.io/github/contributors/xinetzone/tvm-docker
[contributor-link]: https://github.com/xinetzone/tvm-docker/contributors
[watcher-badge]: https://img.shields.io/github/watchers/xinetzone/tvm-docker
[watcher-link]: https://github.com/xinetzone/tvm-docker/watchers
[binder-badge]: https://mybinder.org/badge_logo.svg
[binder-link]: https://mybinder.org/v2/gh/xinetzone/tvm-docker/main
[install-badge]: https://img.shields.io/pypi/dw/tvm-docker?label=pypi%20installs
[install-link]: https://pypistats.org/packages/tvm-docker
[status-badge]: https://readthedocs.org/projects/tvm-docker/badge/?version=latest
[status-link]: https://tvm-docker.readthedocs.io/zh/latest/?badge=latest

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

