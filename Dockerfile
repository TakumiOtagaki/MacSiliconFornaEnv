# Python 2.7 をamd64で固定（Apple Siliconでもエミュレーションで動作）
FROM --platform=linux/amd64 python:2.7

# pipは Python2 対応の最終版に固定（>=21系はPy2未対応）
RUN python -m pip install --upgrade "pip==20.3.4" "setuptools<45" "wheel<0.35"

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
