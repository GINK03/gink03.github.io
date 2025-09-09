---
layout: post
title: "Cloudflare Access"
date: 2025-09-09
excerpt: "Cloudflare Accessの設定方法と使い方"
tag: ["Cloudflare", "Access", "Tunnel", "設定方法", "使い方"]
config: true
comments: false
sort_key: "2025-09-09-cloudflare-access"
update_dates: ["2025-08-23", "2025-08-24"]
---

# Cloudflare Accessの設定方法と使い方

## 概要
 - Cloudflare AccessはCloudflareのZero Trustセキュリティソリューションの一部
 - Cloudflare Tunnelで通信をCloudflareに転送し、その認証にCloudflare Accessを使用するユースケースが多い
   - 例: 自身でホストしているcode-serverやNextcloudなどのアプリケーションに対して、Cloudflare Accessを利用して認証を行うなど

## 事前準備
 - [/cloudflare-tunnel/](/cloudflare-tunnel/)の手順でCloudflare Tunnelを設定済みであること

## Cloudflare Accessの設定手順（セルフホストアプリケーションの場合）
 - Zero Trustダッシュボードにアクセス
 - Accessからアプリケーションを追加
 - アプリケーションの種類を「Self-hosted」を選択
  - アプリケーションの名前、ドメイン、セッション持続時間、Accessポリシーを設定
   - ドメインはCloudflare Tunnelで設定したドメインを指定
 - 「次へ」をクリックし、設定を保存

## ログイン方法の設定
 - IDプロバイダーを設定
   - Google Workspace、GitHub、Oktaなどの主要なIDプロバイダーが利用可能
   - Googleの場合はGCPのOAuth認証情報を作成し、クライアントIDとクライアントシークレットを取得して設定
