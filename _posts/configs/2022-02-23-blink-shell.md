---
layout: post
title: "blink shell"
date: 2022-02-23
excerpt: "blink shellの使い方"
project: false
config: true
tag: ["blink shell", "ios", "ターミナルエミュレータ"]
comments: false
sort_key: "2022-02-23"
update_dates: ["2022-02-23"]
---

# blink shellの使い方

## 概要
 - iosで動作するターミナルエミュレータ
 - ssh, moshがビルトインされているので秘密鍵を設定すれば任意のlinuxにアクセスすることができる
 - appleの規約により実行可能なバイトコードを作成する機能は無効なので`gcc`や`python`は含まれていない

## 使用できるコマンド

```console
$ blink> 
awk          bench        build        cat          cd           chflags      chksum       clear        code         compress     config       
cp           curl         date         diff         dig          du           echo         ed           egrep        env          exit         
facecam      fcp          fgrep        find         geo          grep         gunzip       gzip         head         help         history      
host         ifconfig     link         link-files   ln           ls           md5          mkdir        mosh         mv           nc           
nslookup     open         openurl      pbcopy       pbpaste      ping         printenv     pwd          readlink     rlogin       rm           
rmdir        say          scp          sed          setenv       sftp         showkey      skstore      sort         ssh          ssh-add      
ssh-agent    ssh-copy-id  ssh-keygen   stat         sum          tail         tar          tee          telnet       touch        tr           
udptunnel    uname        uncompress   uniq         unlink       unsetenv     uptime       wc           whoami       whois        xargs        
xcall
```

## 基本的な操作
 - **設定画面の開き方**
   - アプリのターミナルで`config`と入力する
 - **タブの新規作成**
   - `Cmd + T`
 - **前のタブに移動**
   - `Cmd + Shift + [` 
 - **次のタブに移動**
   - `Cmd + Shift + ]`
 - **ズームイン** 
   - `Cmd + +`
 - **ズームアウト**
   - `Cmd + -`

## 任意のフォントのインストール 
 - `Settings` -> `Appearances` -> `New a new Font`
   - 新しく設定したいフォントの名前を設定
   - css拡張子のオンライン上に公開されているフォントをダウンロード
   - ダウンロードしたファイルを設定
 - **参考** 
   - [Blink Shell Fonts](https://github.com/BlinkSh/fonts)
