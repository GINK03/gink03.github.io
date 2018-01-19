---
layout: post
title: "ArchLinux setup"
date: 2017-08-07
excerpt: "ArchLinux setup"
tags: [archlinux]
config: true
comments: false
---

# なんだかんだでもっとも軽いArchLinux

## Install 

AtchLinuxをddコマンドで焼いたisoを対話形式でインストール可能  
パーティションの整理などがめんどくさいので、ここはもうシステムに任せてちゃっちゃとやったほうがいい　

[Arch Anywhere](https://arch-anywhere.org/)

ISOをusbにフラッシュする
```console
$ sudo dd if=foo.img of=/dev/disk1 bs=1m
```
なお、一部のマシンRyzenなどでは、うまくこのインストーラではインストールできない  
そのため、解決策というか、妥協策で、/etc/arch-anywhere.confをviなどで開き、lspciと記述されている箇所を削除する  
```console
$ sudo vi /etc/arch-anywhere.conf
... # remove lspci
```


## enable sshd
Arch Linuxはsystemctlでサービスの管理をしており、モダン感がある  
つまり、sshdサービスを有効にするにはこうする  
```console
$ sudo pacman -S openssh
$ sudo systemctl enable sshd
$ sudo systemctl start sshd
```

## installing softwear
基本は最初にチェックがついているソフトウェアで良い
desktopはplasma, unityなど使い慣れているものでよい
言語は日本語か英語で良い

## yaourt
入れる
/etc/pacman.conf
```console
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
```
install
```console
$ sudo pacman --sync --refresh yaourt
```

## gcc & make & cmake & clang & kotlin & go & fakeroot & patch
```console
sudo pacman -S gcc
sudo pacman -S kotlin
sudo pacman -S clang
sudo pacman -S golang
sudo pacman -S go
sudo pacman -S make
sudo pacman -S cmake
sudo pacman -S fakeroot
sudo pacman -S patch
```

## mecab
yaourt経由でインストールできる  
gcc,make,g++が入っていないとmakeでこけるので気がつける  
あと、mecab-dicも入れてないとダメっぽい
```console
$ yaourt mecab
...
```

PATHがneologdと不整合を起こすので、手動で、pathを変更する
```console
$ sudo cp -r mecab/ ../libexec/
```

neologd
```console
$ git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
$ ./bin/install-mecab-ipadic-neologd -n
```

mecabrcを編集する  
これを追加
```console
/usr/lib/mecab/dic/mecab-ipadic-neologd
```

テスト
```console
$ echo "艦これ" | mecab
艦これ  名詞,固有名詞,一般,*,*,*,艦これ,カンコレ,カンコレ
EOS
```

## minio
AWS S3コンパチブルなサービスを展開できる
PATHに~/go/binを追加して以下のgoパッケージを追加  
```console
$ go get -u github.com/minio/minio
$ mkdir minio
$ minio server minio
```
mcのインストール
```console
$ go get github.com/minio/mc
[in go/src/mc-dir]$ go build .
$ mv mc ~/go/bin
```
こんな風にmcに登録する
```console
$ mc config host add minio http://192.168.15.24:9000 XM8X9Y7Z3X7O4XH1ELMY cPxbdMMHYliagVktI31eE+l/aB/kVvKW83ux01RJ S3v4
$ mc ls minio
[2017-08-07 12:44:44 JST]     0B mac/
```

## plasmaにmozcをインストールする

[参考](https://ponu2.blogspot.jp/2016/03/arch-linuxplasmafcitx-mozc.html)
やり方が安定しないのは良くない  
あと、設定から、mozcと日本語キーボードを並列で利用する必要があり、ctrl+spaceで切り替えることが可能  

## ipアドレスをstaticにする
dhcpcdが有効になっていると、ipが更新されなくなるので、停止する
```console
$ sudo systemctl disable dhcpcd
$ sudo systemctl stop dhcpcd
```
ipコマンドでipアドレスを設定する  
めんどくさいので、これをスタートアップに登録するとか
```console
ip addr flush dev enp6s0
ip route flush dev enp6s0
ip link set enp6s0 down
ip link set enp6s0 up
ip addr add 192.168.15.9/24 broadcast 192.168.15.255 dev enp6s0
ip route add default via 192.168.15.1
```

## network manger + nmcliで設定する
一番ロバストか
```console
# nmcli connection modify eth0 ipv4.method manual ipv4.addresses 192.168.15.41/24 ipv4.gateway 192.168.15.1 ipv4.dns 8.8.8.8
```
arch (Rashpberry PI3)ではwlanを無効化しておく必要があって、これを
行わないと、NetworkManagerがバグって大変なことになる
/etc/modprobe.d/raspi-blacklist.confを作成して、追記する
```console

#wifi
blacklist brcmfmac
blacklist brcmutil
#bt
blacklist btbcm
blacklist hci_uart
```

## ip addrコマンドでスタティックIPにする
何をやってもうまくいかないケースがあり、もうこの場合、network managerやnetctlなどを外す
結果として、ip addrだけでなんとかする
```console
ip addr flush dev eth0
ip addr add 192.168.15.41/24 broadcast 192.168.15.255 dev eth0
ip route add default via 192.168.15.1
```

## Arch Linux for ARMで見つけたスタティックIPにする方法
血反吐吐きながら、探した  
ネットワークの相互影響は、あらゆる箇所で参照、変更されており、なかなかカオス  
例えば、ここを編集することで物によってはstatic IPにすることができる  
/etc/systemd/network/eth0.network
```console
[Match]
Name=eth0

[Network]
Address=192.168.1.8/24
Gateway=192.168.1.1
DNS=8.8.8.8
DNS=8.8.4.4
```
