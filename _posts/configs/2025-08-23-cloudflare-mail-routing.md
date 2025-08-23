---
layout: post
title: "Cloudflare Mail Routing"
date: 2025-08-23
excerpt: "Cloudflare Mail Routingの設定方法と使い方"
tag: ["Cloudflare", "Mail Routing", "設定方法", "使い方"]
config: true
comments: false
sort_key: "2025-08-23-cloudflare-mail-routing.md"
update_dates: ["2025-08-23", "2025-08-24"]
---

# Cloudflare Mail Routingの設定方法と使い方

## 概要
 - Cloudflare Mail Routing は、ドメインのメールアドレスを他のメールサービスに転送する機能

## 主な機能

- **200個程度のメールアドレス**: そのドメインで最大200個程度のメールアドレスを使用可能
- **メール転送**: そのメールアドレスにメールが送られたら Gmail でキャッチするなどができる
- **カスタムルール**: 特定のアドレスパターンに対して異なる転送先を設定可能

## 使用例

- `info@example.com` → `yourname@gmail.com` に転送
- `sales@example.com` → チームの共有メールボックスに転送
- `*@example.com` → すべてのメールを特定のアドレスに転送

## gmailのエイリアス送信
- [/google-gmail/](/google-gmail/)を参照
