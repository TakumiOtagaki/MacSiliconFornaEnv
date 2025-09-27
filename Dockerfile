# Python 2.7 をamd64で固定（Apple Siliconでもエミュレーションで動作）
FROM --platform=linux/amd64 python:2.7-buster
ARG DEBIAN_FRONTEND=noninteractive

# buster のリポジトリをアーカイブに差し替え（EOL対策）
RUN sed -i 's/deb.debian.org/archive.debian.org/g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list \
 && sed -i 's/^deb-src/# deb-src/g' /etc/apt/sources.list

# pipは Python2 対応の最終版に固定（>=21系はPy2未対応）
RUN python -m pip install --upgrade "pip==20.3.4" "setuptools<45" "wheel<0.35"

# ビルドに必要な依存
RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get install -y --no-install-recommends \
    build-essential autoconf automake libtool pkg-config \
    swig libgmp-dev libmpfr-dev zlib1g-dev ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# リポの ViennaRNA ソースを投入（パスはユーザ記載の構成に合わせる）
# ViennaRNA をビルド
WORKDIR /build
COPY app/ViennaRNA-2.6.4 /build/ViennaRNA-2.6.4
WORKDIR /build/ViennaRNA-2.6.4
RUN ./configure --with-python2 --without-python3 --prefix=/usr/local \
 && make -j"$(nproc)" \
 && make install

# Python から確実に見えるようにパスを通す
ENV PYTHONPATH=/usr/local/lib/python2.7/dist-packages:/usr/local/lib/python2.7/site-packages:$PYTHONPATH \
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# 依存インストール
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# アプリ配置
COPY app/ /app/

# アプリが使用するポート（例：8000）
EXPOSE 8000

# デフォルトの起動コマンド（必要に応じて docker-compose 側で上書き可能）
CMD ["python2", "forna/forna_server.py", "-s", "-d"]
