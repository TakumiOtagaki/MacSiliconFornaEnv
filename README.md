# How to start forna on Docker
## Installation
```sh
git clone --recurse-submodules git@github.com:TakumiOtagaki/forna_on_M2MacBook.git
# 既存 clone に後から submodule を欲しい時
git submodule update --init --recursive
```

```
open -a Docker
make up
```

# building log
## ViennaRNA for python2.7
```sh
cd app
tar -zxvf ViennaRNA-2.6.4.tar.gz # put ViennaRNA-2.6.4 in app directory
cd ViennaRNA-2.6.4
export CC=clang CXX=clang++
./configure --with-python2
make
sudo make install
```# MacSiliconFornaEnv
