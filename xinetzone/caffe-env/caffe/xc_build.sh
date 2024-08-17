export CAFFE_ROOT=/media/pc/data/xc/venv/caffe
cd $CAFFE_ROOT
make all -j$(nproc)
make pycaffe -j$(nproc)
# export PYCAFFE_ROOT=$CAFFE_ROOT/python
# export PYTHONPATH=$PYCAFFE_ROOT:$PYTHONPATH
# echo "$CAFFE_ROOT/.build_release/lib" >> /etc/ld.so.conf.d/caffe.conf
# ldconfig