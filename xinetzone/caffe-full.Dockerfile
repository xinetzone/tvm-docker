# 镜像名称 xinetzone/tvmx:caffe-full
# FROM xinetzone/tvmx:caffe-full-compile
FROM xinetzone/tvmx:caffe-py38
WORKDIR /data
COPY caffe-env/temp /data
RUN invoke compile

# WORKDIR /home/workspace/
# COPY bugs/cProfile.py /usr/local/lib/python3.8/cProfile.py
