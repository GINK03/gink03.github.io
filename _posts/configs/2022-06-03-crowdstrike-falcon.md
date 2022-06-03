---
layout: post
title: "crowdstrike falcon"
date: "2022-06-03"
excerpt: "crowdstrike falconの使い方と環境構築"
config: true
tag: ["crowdstrike", "falcon", "セキュリティ"]
comments: false
sort_key: "2022-06-03"
update_dates: ["2022-06-03"]
---

# crowdstrike falconの使い方と環境構築

## 概要
 - セキュリティソフトウェア
 - osxにデーモンとしてインストールされ、clamavなどをラップして定期的に実行、レポーティングを行っているようである
 - osx版やlinux版など様々なバージョンがある
 - 法人契約で1000人単位で契約するもので一般人がどうこうするものではない
 - 適切に理者によって管理されていることの証左になるので、一般ユーザとして使用しているときは無理にアンインストール等はしない
   - osx版は管理者によってインストールされると、一般使用者は停止/アンインストールすることができない
   - なんらかの偶発的な原意によって、サービスの一部が停止すると、管理者にアラートが飛ぶ

## `falconctl`の使い方
 - 統計情報の確認
   - `sudo /Applications/Falcon.app/Contents/Resources/falconctl stats | less`
 - サービスのunload
   - `sudo /Applications/Falcon.app/Contents/Resources/falconctl unload  -t <管理者のみが知りうるトークン>`

