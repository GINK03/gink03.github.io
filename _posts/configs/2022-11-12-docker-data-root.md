---
layout: post
title: "docker data-root"
date: 2022-11-12
excerpt: "dockerのdata-rootの設定"
tags: ["container", "docker", "dockerfile"]
config: true
comments: false
sort_key: "2022-11-12"
update_dates: ["2022-11-12"]
---

# dockerのdata-rootの設定

## 概要
 - dockerのコンテナのキャッシュやボリュームは、デフォルトでは`/var/lib/docker`にすべて配置される
   - 大きなコンテナを作っていると、disk usageが100%になってOSが不安定になるので別のディレクトリに再マップする
   - これらのファイルを管理するディレクトリを、`data-root`という

## data-rootを変更するにあたって
 - dockerのサービスを無効化する必要
   - 外部ディスクをマウントしてからdockerのサービスを有効化する必要があるため

```console
$ sudo systemctl disable docker
```

## `/etc/docker/daemon.json`を編集する
 - data-rootにしたいディレクトリを設定
 - ディレクトリのパーミッションは自動的に適切に編集される

```json
{
    "data-root": "/mnt/sdc/docker"
}
```

## dockerのサービスを再起動

```console
$ sudo systemctl restart docker
```

```console
$ sudo systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; disabled; vendor preset: enabled)
     Active: active (running) since Sat 2022-11-12 12:43:45 JST; 4s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 1738514 (dockerd)
      Tasks: 17
     Memory: 56.6M
        CPU: 263ms
     CGroup: /system.slice/docker.service
             └─1738514 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

---

## 参考
 - [Best way to change the Docker data directory on Ubuntu Server 18.04/DOCKER COMMUNITY FORUMS](https://forums.docker.com/t/best-way-to-change-the-docker-data-directory-on-ubuntu-server-18-04/70896)
