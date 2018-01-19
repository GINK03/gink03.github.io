---
layout: post
title: "TorrentDataset"
date: 2017-05-19
excerpt: ""
tags: [torrent]
comments: false
---

# Torrentで機械学習に使用したデータセットを配布する
 そもそも極めてデータサイズが大きいことになりがちが機械学習という分野において、データセットの配布は割と真剣に議論されるべき問題であるように見える  
 現実的な配布方がS3でデータを公開し、ユーザにダウンロードしてもらうことらしいが、一日50GByteを30日間ダウンロードさせると、大体月あたり5000円ほどかかるらしい。  
 金銭的に厳しいようなイメージを多少持ったので、Torrentでの配布にしたい。

## ctorrentでアップロード用の.torrentファイルを作る
まず、具体例を示すとこのようになっている。  
```console
$ ctorrent -t -u "http://tracker.kicks-ass.net/announce" -s deep_furigana_vars.torrent vars.zip 
```

- \-u {$TRACKER_NAME} : どこのトラッカーに登録するからしい
- \-s {$OUTPUT_FILENAME} : 出力トレントファイル名
- {$LAST} : 出力ファイル名


