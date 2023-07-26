---
layout: post
title: "jupyter nbconvert"
date: 2023-07-26
excerpt: "jupyterでのnbconvertによるドキュメント共有方法"
tag: ["jupyter", "kaggle", "python", "pdf", "html"]
comments: false
sort_key: "2023-07-26"
update_dates: ["2023-07-26"]
---

# jupyterでのnbconvertによるドキュメント共有方法 

## 概要
 - jupyterの実行環境を持たない人に分析結果を報告する場合、HTMLやPDFで出力すると良い
   - HTMLは画像がbase64でエンコードされて、単一のファイルになるのでポータビリティがよい
   - PDFはページごとに分割されるので一覧性が低い
 - 単純に実行するだけの場合は、scriptに変換するとよい
 - jupyter labではGUIのメニューの`Save and Export Notebook As...`から以下の方法を選べる
   - Asciidoc
   - HTML
   - LATEX
   - Markdown
   - PDF
   - Qtpdf
   - Qtpng
   - Executable Script
   - ReStructured Text
   - Webpdf

## コマンドでの変換
 - pdf
   - `$ jupyter nbconvert --to html <any.ipynb>`
 - executable script
   - `$ jupyter nbconvert --to script <any.ipynb>`
 - html
   - `$ jupyter nbconvert --to html <any.ipynb>`

## 参考
 - [Using as a command line tool/nbconvert.readthedocs.io](https://nbconvert.readthedocs.io/en/latest/usage.html#using-as-a-command-line-tool)
