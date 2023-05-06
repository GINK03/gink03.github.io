---
layout: post
title: "systemctl"
date: 2023-05-06
excerpt: "systemctlの使い方"
tags: ["systemctl", "linux", "systemd"]
config: true
comments: false
sort_key: "2023-05-06"
update_dates: ["2023-05-06"]
---

# systemctlの使い方

## 概要
 - systemctlはシステム関連の様々な操作を行うことができる
 - systemdの操作もsystemctlの役割

### ログ
 - `journalctl`コマンドを利用する
 - stdout, stderr的な内容が出力される  
 - NOTE: systemdの種類によってはユーザ権限で動作することができ、`-f` オプションでトレイリングになる(要順序確認)  
 - `--since`, `--until`を指定することでログの期間を指定することができる
 - `--reverse`を指定することで降順に表示させることができる
 - デフォルトではページャが有効になっており`--no-pager`で無効化できる
 - `-l|--full`は表示可能なログをすべて表示する
 - `-o json`でアウトプットをjsonフォーマットとすることができる

**サービスのログをトレイリング**  
```console
$ journalctl -u hoge.service -f
```

**カーネルのログ(dmseg)を表示**  
```console
$ journalctl -k
```

## ユニットの一覧を表示

```console
$ systemctl list-units
```
 - アクティブなunitや無効化されたunitが確認できる

## 設定ファイルの再読み込み

```console
$ systemctl reload 
```

## 使用できるユニット一覧を表示

```console
$ systemctl list-unit-files
```
 - 起動、無効、エラーなどを確認できる

## システムのサスペンド(スリープ)/シャットダウン/再起動
 - サスペンド(スリープ)
   - `sudo systemctl suspend`
 - シャットダウン
   - `sudo systemctl halt` 
   - `sudo systemctl poweroff`
 - 再起動
   - `sudo systemctl reboot`

## ランレベルを確認する

```console
$ systemctl get-default
graphical.target
```
 - グラフィカルになっていることが確認できる

## ランレベルを変更する
 
```console
$ systemctl set-default runlevel3.taget
```
 - `set-default`はデフォルトのランレベルを設定する

または

```console
$ sudo systemctl set-default multi-user
```
 - GUIを無効にしてCUIにする際のコマンド
   - ubuntuではgnomeやkdeが無効化できる

## シングルユーザモードで起動する(レスキューモード)

```console
$ systemctl rescue
```

## エマージェンシーモードに移行する

```console
$ systemctl emergency
```
