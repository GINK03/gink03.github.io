---
layout: post
title: "userとgroup"
date: "2021-12-03"
excerpt: "userとgroupについて"
project: false
config: true
tag: ["linux", "user", "group"]
comments: false
sort_key: "2021-12-03"
update_dates: ["2021-12-03"]
---

# userとgroupについて

## 概要
 - linuxでは、ユーザとグループの概念がある
   - ユーザ
     - ファイルやディレクトリの所有者
   - グループ
     - ユーザをまとめるためのもの
     - docker, libvirtなどの特定の権限を持つユーザをまとめるために使われる

## ファイルと役割
 - `/etc/shadow`
   - セキュアなユーザアカウント情報
 - `/etc/passwd`
   - ユーザ情報
   - `account:password:UID:GID:GECOS:directory:shell`
 - `/etc/gshadow`
   - グループアカウントの暗号化された情報
 - `/etc/group`
   - グループ情報

## useraddコマンド

### 概要
 - ユーザを追加する

### 引数
 - `-m`
   - ホームディレクトリの作成
 - `-g`
   - デフォルトのユーザが所属するグループ
   - 引数がない場合、ユーザ名と同じグループが生成される
 - `-G`
   - 追加グループ
 - `-s`
   - デフォルトログインシェル

## usermodコマンド

### 概要
 - ユーザ情報を変更する

### 具体例

**ホームディレクトリを変更**  
```console
# usermod -d <new-home-path> -m <username>
```

**ユーザの名前を変更**  
```console
# usermod -l <newname> <oldname>
```

**ユーザを他のグループに追加する**  
```console
# usermod -aG <additional-group> <username>
```

## passwdコマンド

### 概要
 - ユーザの情報の様々な変更

### 具体例

**ユーザのパスワードを変更**  
```console
# passwd <username>
```

**グループパスワードの変更**  
```console
# passwd -g <group>
```

**アカウントのロックとロック解除**  
```console
# passwd -l <username> # lock
# passwd -u <username> # unlock
```

## groupsコマンド

### 概要
 - ユーザの所属しているグループを表示

```console
$ groups
<username> adm cdrom sudo dip plugdev kvm lpadmin lxd sambashare docker libvirt
```

## idコマンド

### 概要
 - 様々なユーザとグループに関する操作

## groupaddコマンド

### 概要
 - groupを追加するコマンド

### 具体例

```console
# groupadd <group>
```

## gpasswdコマンド

### 概要
 - userをgroupに追加,削除するコマンド

### 具体例

**ユーザを追加する**  
```console
# gpasswd -a <user> <group>
```

**ユーザを削除する**  
```console
# gpasswd -d <user> <group>
```

## groupmodコマンド

### 概要
 - group情報を変更する

### 具体例

**グループの名前の変更**  
```console
# groupmod -n <new-group> <old-group>
```




