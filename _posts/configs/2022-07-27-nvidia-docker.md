---
layout: post
title: "nvidia docker"
date: 2022-07-27
excerpt: "nvidia dockerの使い方"
tags: ["nvidia", "container", "docker"]
config: true
comments: false
sort_key: "2022-07-27"
update_dates: ["2022-07-27"]
---

# nvidai dockerの使い方

## 概要
 - cuda関連のソフトウェアの依存を正しくインストールすることが困難なのでコンテナで提供してしまうという発想
   - cupy, cuml, cudfなどは依存の調整が難しい
 - dockerのインストールだけでなく特殊なソフトウェアのインストールも必要

## nvidia-docker2のインストール

**GPG Keyの設定**  

```console
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

**nvidia-docker2のインストールとdockerの再起動**  

```console
$ sudo apt-get update
$ sudo apt-get install -y nvidia-docker2
$ sudo systemctl restart docker
```

## Dockerfileで使うライブラリをインストールする
 - 毎回、jupyter上でインストールする手間が省ける
 - `cudf`が入っている環境に、`pandas-gbq`を入れると壊れたりする

```dockerfile
# rapidsaiのbaseを利用するとき
# FROM rapidsai/rapidsai:22.06-cuda11.0-runtime-ubuntu18.04-py3.8
# 必要最低限のnvidia/cudaを利用するとき
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

# install base softwares
RUN apt update
RUN apt install build-essential mecab libmecab-dev mecab-ipadic -y
RUN pip install mecab-python3
RUN apt install curl python3-pip git make sudo less file tmux htop -y
# RUN cd tmp; git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git;
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/mecab-ipadic-neologd
RUN /tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y

COPY ./requirements.txt /app/
# mecabrcはMeCabに必要
RUN echo "dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd" > /usr/local/etc/mecabrc

# RUN pip install -r /app/requirements.txt
# RUN pip install gunicorn
RUN pip install faiss_cpu MeCab redis mojimoji loguru

# WORKDIR /app
# CMD #gunicorn --bind 0.0.0.0:$PORT --timeout 300 --workers=2 bin:app
ENV TEST=1
ENV REDIS_HOST="localhost"
# CMD bash
CMD bash /rapids/utils/start-jupyter.sh; bash
```

## 起動
 
```console
$ docker run -it -v $PWD/host:/rapids/notebooks/host --gpus all -p 8888:8888 nvidia-docker
```

---

## トラブルシューティング

### `-it`, `--intractive, --tty`オプションを付けないと動作しないとき
 - 原因
   - `rapidsai`のコンテナのスクリプトが`-it`を期待しているため、GCPのスタートアップスクリプトのように`tty`が存在できない場合、起動できない
 - 対応
   - `nvidia/cuda:~`のbaseを利用すると`tty`を期待しないため、動作することがある

---

## 参考
 - [rapidsai/rapidsai/dockerhub](https://hub.docker.com/r/rapidsai/rapidsai/)
 - [NVIDIA Container Toolkit Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
 - [RAPIDS](https://rapids.ai/start.html#rapids-release-selector)
