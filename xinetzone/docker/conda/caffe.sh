conda create -n ai python=3.11 -y
conda activate ai
# 安装 boost
conda install conda-forge::boost
apt-get update --fix-missing
# # Install dependencies
apt-install-and-clear -y --no-install-recommends protobuf-compiler pip \
    libprotobuf-dev libhdf5-serial-dev libopenblas-dev libgflags-dev \
    libgoogle-glog-dev libleveldb-dev liblmdb-dev libsnappy-dev \
    libsnappy-dev
pip install plyvel lmdb
mkdir -p ${CAFFE_HOME}
tar -xf /install/caffe.tar.gz
mv /caffe /caffe_src
# git clone --depth 1 https://github.com/weiliu89/caffe /caffe_src
cd /caffe_src
echo "Building Caffe"
mkdir /caffe_src/build && cd /caffe_src/build
cmake -DCMAKE_INSTALL_PREFIX=${CAFFE_HOME}\
    -DCMAKE_BUILD_TYPE=Release \
    -DCPU_ONLY=1 \
    -Dpython_version=3 \
    -DUSE_OPENCV=OFF \
    -DUSE_LEVELDB=OFF \
    -DUSE_LMDB=OFF \
    -DBUILD_docs=OFF \
    -DBLAS=open \
    ..
make all -j$(expr $(nproc) - 1)
make pycaffe -j$(expr $(nproc) - 1)
make test -j$(expr $(nproc) - 1)

echo "Installing Caffe to /opt/caffe"
make install

# echo "Removing build directory"
# cd / && rm -rf /caffe_src

PYCAFFE_ROOT=${CAFFE_HOME}/python
echo "${CAFFE_HOME}/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
# # # site_packages=$("${TVM_VENV}/bin/python3" -c 'import site; print(site.getsitepackages()[0])')
# # # ln -s ${PYCAFFE_ROOT}/caffe "${site_packages}/caffe"
# rm /install/caffe.tar.gz

