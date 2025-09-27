# How to start forna on Docker

open -a Docker

# building log
## ViennaRNA for python2.7
```sh
tar -zxvf ViennaRNA-2.7.0.tar.gz
cd ViennaRNA-2.7.0
export CC=clang CXX=clang++
./configure --with-python2
make
sudo make install
```# MacSiliconFornaEnv
