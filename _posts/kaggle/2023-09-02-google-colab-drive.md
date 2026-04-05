---
layout: post
title: "google colabでgoogle drive"
date: 2023-09-02
excerpt: "google colabでgoogle driveの使い方"
tags: ["jupyter", "google colab", "colab", "google drive"]
kaggle: true
comments: false
sort_key: "2023-09-03"
update_dates: ["2023-09-03"]
---

# google colabでgoogle driveの使い方

## 概要
 - colabからgoogle driveをマウントできる
 - csvの出力先をGoogle Driveに設定すればGoogle Sheetsですぐ開くことができ、便利
 - 共通で使用するデータソース・ライブラリを等を置いておくなどの使い方も可能
 - マウントパス
   - ユーザのドライブ
     - `/content/drive/MyDrive`
   - 共有ドライブ
     - `/content/drive/Shareddrives`

## マウント

```python
from google.colab import drive
drive.mount('/content/drive')
```

## csvをGoogle Driveに保存

```python
df.to_csv('/content/drive/MyDrive/<filename.csv>', index=False)
```

 - Google Driveを開き(https://drive.google.com/drive/u/2/searchなど)、ファイル名で検索し、Google Sheetsで開く

## 保存を明示的に同期

```python
drive.flush_and_unmount()
print('All changes made in this colab session should now be visible in Drive.')
```

## google driveのパッケージをインストール

```python
!pip install ${PKG} -t "/content/drive/MyDrive/colab/libs" 2>&1 > /dev/null
```
