---
layout: post
title: "macOSのトラブルシューティング"
date: 2023-07-16
excerpt: "macOSのトラブルシューティング"
tags: ["apple", "macos", "トラブルシューティング", "trouble shottings"]
config: true
comments: false
sort_key: "2023-07-16"
update_dates: ["2023-07-16"]
---

# macOSのトラブルシューティング

### `open and save panel service not responding`とプロセスに表示されアプリがストールする
 - 原因
   - macOS sonoma以降のクラウドドライブのバグ
 - 対応
   - iCloud Driveを一時的にオフにする

### macOS sonomaのスクリーンロック画面からパスワードでログインできない
 - 原因
   - Active Directoryと内容の同期が取れていないバグ
 - 対応
   - Apple Watch, 指紋認証などのバイオメトリック認証でログインする

### ネットワークが`self-assigned ip address`になり通信できない
 - 原因
   - DHCPサーバからIPアドレスの通知を受け取れなくなっている
 - 対応
   - (たぶん、必要がなさそうなsharingサービスを使用しない)
   - 再起動

### GUIの重く、まともに操作できない
 - 原因
   - メモリの使用しすぎ・WindowServerの不調
 - 対応
   - `アクティビティモニター`から`WindowServer`を強制終了
     - WindowsServerを終了すると、今開いているアプリはすべて終了されるので注意

### google日本語入力の切り替えが遅い場合
 - 原因
   - 権限が適切にアサインされていない
 - 対応
   - [参考](https://www.ytyng.com/blog/mac-os-big-sur-google-japanese-input-full-disk-access/)

### osがクラッシュするのでログを確認したい
 - 原因
   - ログを確認しないと原因を確定できない
 - 対応
   - `コンソール`アプリーケーションを立ち上げる
   - `ログレポート`から日付を参考にクラッシュ日時に近いログを探す
     - 確認したところ、スリープ時にT2チップがスリープ時にエラーを発生させていることが確認できた

```json
{"caused_by":"bridgeos","macos_system_state":"unknown","bug_type":"210","os_version":"Bridge OS 6.2 (19P744)","timestamp":"2022-02-24 03:46:45.00 +0000","incident_id":"9555A628-6A59-4A09-B754-C6B78FC5B13A"}
{
  "build" : "Bridge OS 6.2 (19P744)",
  "product" : "iBridge2,16",
  "kernel" : "Darwin Kernel Version 21.3.0: Wed Jan  5 20:03:37 PST 2022; root:xnu-8019.80.24~19\/RELEASE_ARM64_T8010",
  "incident" : "9555A628-6A59-4A09-B754-C6B78FC5B13A",
  "crashReporterKey" : "c0dec0dec0dec0dec0dec0dec0dec0dec0de0001",
  "date" : "2022-02-24 03:46:45.68 +0000",
  "panicString" : "Unexpected SoC (system) watchdog reset occurred during sleep\/wake transition",
  "panicFlags" : "0x0",
  "foregroundAppHash" : "0",
  "macOSPanicString" : "not yet set",
  "binaryImages" : []
}
```

### macbook同士をtype-cで接続するとクラッシュする
 - 原因
   - type-cの通信エラーを吐き出し続けて最終的にはOSがクラッシュする 
 - 対応
   - macbook同士を接続しない

### 拡張子の対応付を修正する
 - 原因
   - Finderの設定が誤っている
 - 対応
   - 対象の拡張子のファイルを右クリック
   - `情報を見る`を選択
   - `このアプリケーションで開く`を選択
   - `すべてを変更`を適応

### (クラッシュ)Wake transition timed out after 180 seconds while calling power state change callbacks. Suspected bundle: com.apple.iokit.IOPCIFamily.
 - 原因
   - macのスリープをトリガーとしてたまに起きるバグ
 - 対応
   - OSのアップデートで治る例が多いとされている
   - 最新のOSにしていてもたまに起こることもあり、根治法は不明
   - 経験則的には、CPU負荷が高いときにディスプレイを閉じると発生する事があり、明示的にスリープをさせてからディスプレイを閉じたほうがいいかもしれない(確定していない)
 - 参考
   - [Kernel Panic every time I close computer/Apple Community](https://discussions.apple.com/thread/253692363)

### CPUの使用率が異常なとき
 - 原因
   - 一概には言えないが一部のサービスやプロセスが暴走していることがある
 - 対応
   - activityモニタから確認CPU usageを確認する
   - 異常なCPU使用のプロセス名を特定する
   - 一時的な対処
     - サービスの場合
       - launchctl stop <service-name>
     - プロセスをkillするだけで良い場合
       - `ps aux | grep <process-name>`でpidを確認
       - `sudo kill -9 <pid>`で終了
     - どうしてもプロセスを停止できない場合
       -  `ps aux | grep <process-name>`などで実行バイナリを特定
       - `sudo mv <binary-path> <binary-path>.back`などとしてpathから外す

### ショートカットキーがなにかのプロセス・アプリケーションに食べられてしまうとき
 - 原因
   - 対象のアプリケーションの特定が困難で一見するとキーの不良にも見えるが、ソフトウェア起因である
 - 対応
   - karabinerでキーコンビネーションが認識されているかどうかでハードウェア・ソフトウェアの切り分けを行う
   - GUIアプリが原因のとき、shortcutdetectiveというアプリを用いることで確認できる
   - CUIプロセスが原因のとき、`ps ux`コマンドでそれらしいのをkillしながら特定
     - `skhd`daemonがoption系のショートカットを食べていた

### Docker Desktop for Macと相性が悪い
 - 対策
   - dockerが必要な操作を行った後(コンテナの開発など)はDocker Desktop for Macを終了し、macosを再起動する
 - クラッシュしてしまった場合
   - 強制再起動
   - 他のソフトウェアが破損した場合は再インストールする
