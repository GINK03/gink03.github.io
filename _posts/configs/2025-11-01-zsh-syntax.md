---
layout: post
title: "zsh 記法と構文"
date: 2025-11-01
excerpt: "zsh の記法と構文の基本"
config: true
tag: ["zsh", "syntax"]
comments: false
sort_key: "2025-11-01"
update_dates: ["2025-11-01"]
---

# zsh の記法と構文

## 設定を無視して zsh を起動

```console
$ zsh -f
```

## 複数のコマンドの実行

### `;`
 - 左のコマンドが正常に実行できてもできなくても右のコマンドを実行

### `&&`
 - 左のコマンドが正常に実行できた時、右のコマンドを実行する

### `||`
 - 左のコマンドが正常に実行できない時、右のコマンドを実行する

## シングルクオートとダブルクオートの違い
 - シングルクオート
   - シェル変数を内部で展開しない
 - ダブルクオート
   - シェル変数を内部で展開する

## インターネット上にある zsh スクリプトを読み込む
ダウンロード場所を指定しておき、存在しなければ読み込む  

```shell
# gistによる機能拡張
function load_remote_zshrc() {
  # 1. .tmpが存在しなかったら作成
  # 2. .tmp/zshrcが存在しなかったらダウンロード
  if [[ ! -d ~/.tmp ]]; then
        echo "create local .tmp directory"
        mkdir ~/.tmp
  fi
  if [[ ! -f ~/.tmp/zshrc ]]; then
        echo "create local .tmp directory"
        curl -o ~/.tmp/zshrc https://gist.githubusercontent.com/GINK03/e96cf8fa45a5c97846d5b6cb362d5ce7/raw/zshrc
  fi
  source ~/.tmp/zshrc
}
load_remote_zshrc
```

## 関数を定義して呼び出す

```shell
# 定義
# rf <filename>
function rf {
  # 必須な引数
  readonly file_name=${1:?"rgで検索するファイル名の引数"}
  rg --files | rg $file_name # ラップしたコマンド
}
# 呼び出し
rf "hoge"
```

## if文

```shell
if [[ "$PARAM" = "master" ]]; then
  echo "これはmaster"
elif [[ "$PARAM" = "main" ]]; then
  echo "これはmain"
else
  echo "これはFalse"
fi
```
 - 必ず `[[` のあとに space 一個 `]]` の前に space 一個が必要

### ディレクトリがあるかどうかのチェック

```shell
if [[ -d ~/.tmp ]]; then
  echo "存在する"
else
  echo "存在しない"
fi
```

### ファイルがあるかどうかのチェック

```shell
if [[ -f ~/target_file ]]; then
  echo "存在する"
else
  echo "存在しない"
fi
```

## シンボリックリンクがあるかどうかのチェック

```shell
if [[ -L ~/.zshrc ]]; then
  echo "存在する"
else
  echo "存在しない"
fi
```

### 特定のコマンドが存在するかのチェック
この例では`lsb_release`が存在するかの確認  
`which`では`alias`が設定されているときは正しくハンドルされないので、`type`のほうが汎用性がある  

```shell
if type "lsb_release" > /dev/null; then
  echo "存在する"
fi
```

## for文

```shell
for bin in peco vim nvim tmux
do
  echo $bin
done
```
 - peco, vim, nvim, tmux がそれぞれ改行されて出力される

```shell
names=("山田" "田中" "斎藤")
for name in ${names[@]}; do
  echo $name
done

"""
山田
田中
斎藤
"""
```

## case文

例えば OS で処理を分けるとき
```shell
case $(uname) in
  Darwin)
    echo "macOS"
  ;;
  Linux)
    echo "Linux"
esac
```

## プログラムの異常終了をキャッチする

```console
$ echo $?
1
```
 - `0`のとき正常
 - `1`のとき異常
 - その他のとき何らかのソフトウェアごとに予約された動作

## string を split してリストにする

```shell
# spaceで分割する
string="aaa bbb ccc ddd"
parts=(${(@s: :)string})
echo $parts[2] # bbbが出力
parts=(${(@s/ /)string})
echo $parts[2] # bbbが出力
```
 - この記法はzshでしか動作しない(bash, shはエラー)

## コマンドを実行する直前の hook と直後の hook

```shell
autoload -Uz add-zsh-hook
preexec_any_function () {
  # コマンドを実行する前の関数
}
precmd_any_function () {
  # コマンドを実行後の関数
}
# hookに関数を登録
add-zsh-hook preexec preexec_any_function
add-zsh-hook precmd  precmd_any_function
```

## Python でコマンドを作る
 1. `.zshrc`にpythonスクリプトを記入して変数に代入する
 2. インラインのpythonの引数に変数を与えたものにエイリアスを張る

```shell
export my_python_command_script='
import os
import sys

for arg in sys.argv[1:]:
    print(f"{arg}という引数が入力されました")
'
alias my_python_command="python3 -c '$my_python_command_script'"
```

## terminal に git の branch を表示する

`zsh` には `vcs_info` というモジュールが存在し git の branch を取得できる  
`precmd 関数` はコマンドを打つ前に自動で走るコマンドでこの中に記すことでコマンドごとに最新の branch 情報に更新できる

```shell
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats "%b"
function precmd() {
  vcs_info
  PS1="%{$fg[cyan]%}%n@%m%{$reset_color%}:%1 %~ (${vcs_info_msg_0_})$ "
}
setopt prompt_subst
```

## terminal に `datetime` を表示する
`PS1` のフォーマットは以下のようになる

```shell
%D{ %Y-%m-%d %H:%M:%S}
```

## terminal を改行する

`PS1`に直接`\n`を書けないので、以下のように変数を作って代替する

```shell
NEWLINE=$'\n'
PS1="hogehoge ${NEWLINE} foobar"
```

## alias の実体を確認する

```console
$ type -a n
n is an alias for nvim
...
```

## alias を解除する

`sudo`, `ip`などをラップしていると不整合を起こすことがあるのでそのような場合に使える

```console
$ unalias sudo
```

## root ユーザになる

環境によって方法が異なる

```console
$ sudo su
```

または

```console
$ sudo -s
```

