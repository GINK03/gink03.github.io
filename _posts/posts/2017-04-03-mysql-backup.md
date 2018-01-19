---
layout: post
title: "MySQL backup"
date: 2012-04-03
excerpt: "MySQL Backup"
tags: [mysql]
comments: false
---

# バックアップ
```sh
$ mysqldump -u root -x --all-databases > dump.sql
```

# リストア
```sh
$ mysql -u root -p < dump.sql
```
