# caffe 编译疑难解答：

## (1) Makefile 编译方法
```
cd path_to_caffe
cp Makefile.config.example Makefile.config
# 修改 Makefile.config
make all -j$(nproc)
make test -j$(nproc)    # 可选
make runtest -j$(nproc) # 可选
make pycaffe -j$(nproc)
export caffe/python:$PYTHONPATH
```
## (2) Cmake 编译方法
```
cd path_to_caffe
mkdir build
cd build
cmake ..
make -j$(nproc)
make install
```
`Dockerfile` 编译中途如果提示找不到 `pycaffe`, 我自己的解决办法是
```
cd path_to_caffe
cd python
python3 -m pip install --upgrade pip
pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
```
但是这样耗时贼长, 结果还不一定能编译成功, 所以更推荐 `Makefile` 编译, 即 `Dockerfile` 中使用的编译方法.

## (3) 提示找不到文件，例如 hdf5.h opencv2 啥的, 到 `Makefile` 和 `Makefile.config` 中添加对应的路径

## (4) 提示 boost-python39 未定义引用啥的, 全都是 `Py` 开头的一些东西, 如: 
```
/usr/bin/ld: /usr/lib/x86_64-linux-gnu/libboost_python39.so.1.74.0: undefined reference to `PyExc_ValueError'
/usr/bin/ld: /usr/lib/x86_64-linux-gnu/libboost_python39.so.1.74.0: undefined reference to `PyLong_AsLong'
/usr/bin/ld: /usr/lib/x86_64-linux-gnu/libboost_python39.so.1.74.0: undefined reference to `PyNumber_InPlaceFloorDivide'
/usr/bin/ld: /usr/lib/x86_64-linux-gnu/libboost_python39.so.1.74.0: undefined reference to `PyBool_Type'
```
修改 caffe/Makefile.config 中的内容
```
# Uncomment to use Python 3 (default is Python 2)
PYTHON_LIBRARIES := boost_python38 python3.8   
```
将boost_python3x 改成你对应的 python 版本, 比如我这里是`py38`, 所以改成了 `boost_python38`, 后面的 `python3.8` 版本号也要对应上

查看一下 `/usr/local/lib`(源码编译安装路径) 或 `/usr/lib/x86_64-linux-gnu`(apt-get 安装路径) 文件夹内是否包含 `libpython3.8.so` 库文件, 

如果版本不匹配, 需要手动下载老版本的 `boost` 源码自行编译, `Dockerfile` 中有 `boost` 源码编译方法和安装方法, 照着做就行.

## (5) 编译成功后 `import caffe` 提示 `TypeError: Couldn't build proto file into descriptor pool: duplicate file name (caffe/proto/caffe.proto)`

原因是 protobuf 版本的问题, 我安装的 protobuf==3.19.0 可以正常使用, 但是升级版本就会报错
```
pip3 install protobuf==3.19.0
```
提示缺少 `google.xxxx` 之类的包, 也是安装 `protobuf` 就可解决

## (6) protobuf 编译问题

编译 caffe 时提示:
```
1074.6 src/caffe/util/io.cpp: In function ‘bool caffe::ReadProtoFromBinaryFile(const char*, google::protobuf::Message*)’:
1074.6 src/caffe/util/io.cpp:57:34: error: no matching function for call to ‘google::protobuf::io::CodedInputStream::SetTotalBytesLimit(const int&, int)’
1074.6    57 |   coded_input->SetTotalBytesLimit(kProtoReadBytesLimit, 536870912);
1074.6       |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1074.6 In file included from src/caffe/util/io.cpp:2:
1074.6 /usr/local/include/google/protobuf/io/coded_stream.h:390:8: note: candidate: ‘void google::protobuf::io::CodedInputStream::SetTotalBytesLimit(int)’
1074.6   390 |   void SetTotalBytesLimit(int total_bytes_limit);
1074.6       |        ^~~~~~~~~~~~~~~~~~
1074.6 /usr/local/include/google/protobuf/io/coded_stream.h:390:8: note:   candidate expects 1 argument, 2 provided
```

protobuf 的 `SetTotalBytesLimit` 接口从 v18.3 开始就已经转为单个参数, 

请使用 protobuf-17.3 版本编译.

protobuf 18.x+ 编译流程:
```
cd protobuf/
cmake .
cmake --build . --parallel 10
cmake --install .
```
protobuf 17.3 编译流程:
```
./autogen.sh
./configure
make -j$(nproc)
make check -j$(nproc)
make install
```
