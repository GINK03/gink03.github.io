---
layout: post
title: "docker trivy"
date: 2023-12-30
excerpt: "docker trivyの概要と使い方"
tags: ["security", "docker", "trivy"]
config: true
comments: false
sort_key: "2023-12-30"
update_dates: ["2023-12-30"]
---

# docker trivyの概要と使い方

## 概要
 - trivyは、dockerイメージの脆弱性を検知するツール
 - GCPのArtifact Registryに登録されているdockerイメージに対して、定期的に実行することで、脆弱性を検知することができる
 - ローカルでも実行可能でリモートにプッシュすることなく、脆弱性を検知することができる

## インストール

**nix**
```console
$ nix-env -iA nixpkgs.trivy
```

**mac**
```console
$ brew install trivy
```

## 使い方

**dockerイメージを検知**
```console
$ trivy image python:3.11-slim
```

## 参考
 - [trivy](https://github.com/aquasecurity/trivy)
