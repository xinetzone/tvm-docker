from invoke import task

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
