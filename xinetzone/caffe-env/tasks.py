from invoke import task

@task
def tar(ctx):
    # 清除遗留文件
    cmd = "rm -rf temp&&mkdir -p temp"
    # 解压文件
    cmd += "&& tar -xvf caffe.tar.gz && tar -xvf boost-1.81.0.tar.gz" 
    cmd += "&& tar -xvf protobuf-3.17.3.tar.gz "
    cmd += "&& mkdir -p temp && mv protobuf-3.17.3 temp/protobuf-3.17.3"
    cmd += "&& mv caffe/ temp/caffe/"
    cmd += "&& mv boost-1.81.0/ temp/boost-1.81.0/"
    ctx.run(cmd)

@task
def compile(ctx):
    # 编译 bootst
    cmd = "cd /data/boost-1.81.0/ && ./bootstrap.sh"
    cmd += "&& ./b2 cflags='-fPIC' cxxflags='-fPIC' ./b2 install"
    # 编译 protobuf
    cmd += "&& cd /data/protobuf-3.17.3/ && ./autogen.sh"
    cmd += "&& ./configure && make -j$(nproc)"
    cmd += "&& make check -j$(nproc)"
    cmd += "&& make install && ldconfig"
    # 编译 caffe 
    cmd += "&& cd /data/caffe && make all -j$(nproc) && make pycaffe -j$(nproc)"
    # 清理
    cmd += "&& rm -rf /data/boost-1.81.0/ && rm -rf /data/protobuf-3.17.3/"
    ctx.run(cmd)
