---
layout: post
title: "HUGE FILE IN GIT"
date: 2017-04-12
excerpt: ""
tags: [やっちまった時]
comments: false
---

# あるある
 気づかずにでかいファイルをコミットし続ける。-> 巻き戻りポイントを見失う -> だめっぽい
 
## リカバー方
過去すべてのcommitに遡って、でかいファイルのgitのcachedを全部、逐次、消していく  
遡及の魔法
```sh 
git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch examples/dumps.ok.ng.txt" -- --all
```
