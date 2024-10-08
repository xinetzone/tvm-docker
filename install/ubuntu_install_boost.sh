#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -euxo pipefail

apt-install-and-clear -y --no-install-recommends curl
# sudo apt-get install python3-dev -y --no-install-recommends
curl -LO https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz
tar -xf boost_1_81_0.tar.gz

pushd boost_1_81_0
./bootstrap.sh --with-python="$(which python3)"
./b2 install --with-python --with-system --with-filesystem --with-thread --with-regex
popd

ln -s /usr/local/lib/libboost_python3.so.1.81.0 /usr/local/lib/libboost_python.so
ln -s /usr/local/lib/libboost_python3.a /usr/local/lib/libboost_python.a
rm boost_1_81_0.tar.gz
