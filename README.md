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

## 安装 Podman

```bash
sudo apt update
sudo apt install podman
```

## 构建

构建包含 caffe、pytorch、onnx 的 tvm 基础镜像
```bash
podman build -f ./tvm-base.Dockerfile -t xinetzone/tvmx:base-full . --no-cache
```
