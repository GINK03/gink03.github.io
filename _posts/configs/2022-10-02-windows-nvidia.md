---
layout: post
title: "windows nvidia"
date: 2022-10-02
excerpt: "windowsでnvidia製品を使う"
tags: ["windows", "microsoft", "nvidia"]
config: true
comments: false
sort_key: "2022-10-02"
update_dates: ["2022-10-02"]
---

# windowsでnvidia製品を使う

## 概要
 - ゲーム・クリエイティブ用にnvidia GPUを使うことがある
 - nvidiaドライバはwindowsが勝手にインストールしてくれるが、最新バージョンではなく、GPUの管理に必要なソフトウェアも入らない
   - 明示的にインストールするには、nvidiaのサイトからGPUを選択してダウンロードする

## GEFORCE EXPERIENCEについて
 - ドライバーの更新を行える
 - インストールされているゲームを分析して、最適な設定を提案してくれる

## トラブルシューティング

### WSLgが動作しない
 - 原因
   - ドライバとの相性で動作しないことがある
 - 対応
   - WSLgの動作を諦める
   - nvidiaドライバを削除してデフォルトのドライバーに戻す
