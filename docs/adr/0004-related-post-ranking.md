# 0004. 関連記事を共有タグ数と記事品質で事前計算する

> **Status**: Accepted（2026-07-16 決定）

## Context（背景）
 - [[0003-content-quality-and-topic-navigation]] では各タグの先頭記事を最大1件選んでいた
 - タグの並び順と記事順に結果が依存し、複数タグを共有する記事を優先できなかった
 - Liquidで全記事を採点すると1752記事それぞれで全候補を走査するためビルド負荷が大きい
 - 本文へリンクを一括追記すると編集意図とMarkdown差分を損なう

## Decision（決定）
 - `scripts/generate_related_posts.rb`で関連記事を事前計算する
 - 共有タグ数を最優先し、本文500文字以上、同じカテゴリ、公開日の近さ、ファイルパスの順で候補を決める
 - 各記事の関連記事は最大5件とし、自己参照と重複を禁止する
 - 記事メタデータとURL一覧を`_data/related_posts.json`へ正規化して保存する
 - pre-commitとGitHub Actionsで生成データの鮮度を検査する
 - 記事本文は変更せず、表示時に`_includes/related-posts.html`から生成データを読む

## 検討した代替案
 - Liquid内で共有タグ数を計算する案はビルド時の反復回数が大きいため不採用
 - 本文へ関連記事を追記する案は1752記事の恒久的な本文変更になるため不採用
 - ベクトル検索を使う案は依存関係と再現性のコストが現在の規模に対して大きいため不採用

## Consequences（影響）
 - 1512記事に最大5件の関連記事を表示できる
 - 生成処理は約2秒、生成JSONは約417KB増える
 - タイトル、日付、タグ、ファイルパスを変更した場合は生成データの更新が必要になる
 - タグがない候補や共有タグがない候補は選ばれない
 - 編集者が明示的に選ぶリンクほど意味関係を保証できない

## 参考
 - 生成処理: `scripts/generate_related_posts.rb`
 - 生成データ: `_data/related_posts.json`
 - 表示: `_includes/related-posts.html`
 - 上位方針: [[0003-content-quality-and-topic-navigation]]
