---
layout: post
title: "uutils/coreutils"
date: "2022-07-05"
excerpt: "uutils/coreutilsの使い方"
config: true
tag: ["rust", "coreutils", "gnu"]
comments: false
sort_key: "2022-07-05"
update_dates: ["2022-07-05"]
---

# uutils/coreutilsの使い方

## 概要
 - GNU coreutilsのrustで再実装されたバージョン
 - Windowsでもビルドしてインストールできる
 - busybox的な使い方もできる

## インストール

### cargoで入れる

```console
$ cargo install coreutils
```

### 自力でビルドする

```console
$ git clone https://github.com/uutils/coreutils
$ cd coreutils

$ cargo build --release
```

makeを使って個々の機能をバイナリとして切り出すこともできる

```console
$ make PROG_PREFIX=u
$ make install
```

## サポートしているコマンド(一部抜粋)

```console
[, b2sum, b3sum, base32, base64, basename, basenc, cat, cksum, comm, cp, csplit, cut, date,
dd, df, dir, dircolors, dirname, du, echo, env, expand, expr, factor, false, fmt, fold,
hashsum, head, join, link, ln, ls, md5sum, mkdir, mktemp, more, mv, nl, numfmt, od, paste,
pr, printenv, printf, ptx, pwd, readlink, realpath, relpath, rm, rmdir, seq, sha1sum,
sha224sum, sha256sum, sha3-224sum, sha3-256sum, sha3-384sum, sha3-512sum, sha384sum,
sha3sum, sha512sum, shake128sum, shake256sum, shred, shuf, sleep, sort, split, sum, tac,
tail, tee, test, touch, tr, true, truncate, tsort, unexpand, uniq, unlink, vdir, wc, yes
```

## 具体的な使用例

### ls

```console
$ coreutils ls
```

### df

```console
$ coreutils df
```

---

## 参考
 - [uutils/coreutils](https://github.com/uutils/coreutils)
