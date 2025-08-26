---
layout: post
title: "macOS lauchctl" 
date: 2025-08-26
excerpt: "macOSのlaunchctlの使い方"
tags: ["macOS"]
config: true
comments: false
sort_key: "2025-08-26"
update_dates: ["2025-08-26"]
---

# macOSのlaunchctlの使い方

## 概要
 - XML形式の設定ファイルを使用して、macOSのサービスやデーモンを管理するためのコマンドラインツール

## plistを置くパスによる違い

| ディレクトリ | スコープ | 実行タイミング |
|---|---|---|
| ~/Library/LaunchAgents | ユーザー | ユーザーのログイン時 |
| /Library/LaunchAgents | システム | いずれかのユーザーのログイン時 |
| /Library/LaunchDaemons | システム | システムの起動時 |

## Linuxのsystemctlとの違い

| 操作内容 | systemctl (Linux) | launchctl (macOS) |
|---|---|---|
| サービスの有効化（自動起動登録） | systemctl --user enable myapp.service | launchctl load ~/Library/LaunchAgents/com.myapp.plist |
| サービスの無効化 | systemctl --user disable myapp.service | launchctl unload ~/Library/LaunchAgents/com.myapp.plist |
| サービスの即時起動 | systemctl --user start myapp.service | launchctl start com.myapp.label |
| サービスの即時停止 | systemctl --user stop myapp.service | launchctl stop com.myapp.label |
| サービスの状態確認 | systemctl --user status myapp.service | launchctl list \| grep com.myapp.label |

## plistの例

**microsocksをユーザーログイン時に起動する例（~/Library/LaunchAgents/com.microsocks.plist）**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.microsocks</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/microsocks</string>  <!-- Intelなら/usr/local/bin/microsocks -->
        <string>-i</string>
        <string>127.0.0.1</string>
        <string>-p</string>
        <string>1080</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```
