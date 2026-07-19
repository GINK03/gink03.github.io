# Search Consoleインデックス改善計画

> Status: Active
> Updated: 2026-07-16

## 目的

Googleに未認識の重要記事について、発見、クロール、インデックスの各段階を計測しながら改善する

全記事の登録を保証する計画ではなく、重要記事を絞ったトピッククラスタと内部リンクの強化により、技術的に改善可能な範囲を検証する

## 現状

### Search Console

| 項目 | 2026-07-16の状態 |
|---|---|
| sitemap | `https://gink03.github.io/sitemap.xml` |
| 最終送信 | `2026-07-04T01:08:18.179Z` |
| 処理状態 | `isPending: true` |
| warnings / errors | `0 / 0` |
| トップ `/` | `PASS`、Submitted and indexed |
| トップの最終クロール | `2026-06-26T08:17:27Z` |
| `/posts/` | URL is unknown to Google |
| `/git/` | URL is unknown to Google |
| `/markdown/` | URL is unknown to Google |
| `/sops/` | URL is unknown to Google |
| `/dijkstra/` | URL is unknown to Google |

7月4日の調査結果と比較して、代表記事の状態変化はない

### サイト

| 指標 | 件数 |
|---|---:|
| 記事 | 1752 |
| 本文500文字未満 | 584 |
| 本文1000文字未満 | 1126 |
| 本文内の内部リンクなし | 1606 |
| 関連記事が1件以上生成される記事 | 1512 |
| 関連記事が5件生成される記事 | 1340 |
| 関連記事が0件の記事 | 240 |

本文の内部リンク集計は、レイアウトが出力する関連記事を含まない

短文、重複、概要、画像などの詳細は[短文記事とメタデータの統合監査](./content-consolidation.md)を参照する

## 診断

 - sitemap、robots.txt、canonical、内部リンク、HTTP応答を妨げる技術的エラーは現時点で見つかっていない
 - sitemapはURLの発見を助けるが、クロールやインデックスを保証しない
 - 約1800ページという規模だけでは、Googleが説明する典型的な大規模サイトのクロールバジェット問題とは断定できない
 - 古い記事もURL unknownであるため、待機だけでなく、記事の重要度、内容の独自性、サイト内の文脈的なつながりを強化して検証する
 - 原因をドメイン権威またはクロールバジェットだけに固定せず、変更前後のURL Inspection結果で判断する

## 実行計画

### 1. 重要記事30件を選ぶ

初回は5クラスタから各6件を選び、合計30件を固定サンプルとする

初期クラスタ候補

 1. Git / GitHub
 2. Markdown / ドキュメント
 3. クラウド / インフラ / セキュリティ
 4. アルゴリズム / データ構造
 5. Python / データ分析

選定基準

 - 本文1000文字以上を優先する
 - 現在も利用できる内容を優先する
 - タイトル、概要、本文の検索意図が一致している
 - 自己参照canonical、HTTP 200、indexing allowedである
 - 短文、重複、作業メモだけの記事を初回サンプルに含めない
 - すでに表示回数や外部参照がある記事を取得できる場合は優先する

選定結果はURL、クラスタ、文字数、タグ、内部リンク元、Inspection状態を表にして本書へ追記する

### 2. トピックハブを整備する

 - 既存カテゴリページが検索意図に合う場合は、そのページをハブとして拡充する
 - 既存カテゴリが広すぎる場合だけ専用ハブを追加する
 - 各ハブに対象領域の概要、学習順序、重要記事への説明的リンクを置く
 - 単なる全件一覧ではなく、基礎、実践、関連概念など意味のある単位で整理する
 - トップまたは登録済みカテゴリから各ハブへリンクする
 - 各重要記事から所属ハブへ戻れる導線を設ける

### 3. 関連記事を補強する

現在の`scripts/generate_related_posts.rb`は共通タグ、短文判定、同一セクション、公開日の近さから最大5件を選んでいる

 - 関連記事0件の240記事について、タグ欠落と表記揺れを調査する
 - 重要記事30件は、ハブまたは他の重要記事から最低3本の関連リンクを受ける状態にする
 - アンカーテキストは記事タイトルまたは内容を説明する短い文言にする
 - 関係の薄い記事を件数合わせで接続しない
 - 全ページ共通リンクだけに依存せず、ハブと記事本文の文脈リンクを優先する

### 4. 短文と重複を整理する

 - [短文記事とメタデータの統合監査](./content-consolidation.md)の本文500文字未満584件から、重要クラスタと重なる記事を先に確認する
 - 同一検索意図の記事は、内容が最も充実した記事への統合候補にする
 - 統合時は旧URLから新URLへの恒久リダイレクトと内部リンク更新を前提にする
 - 有用性を判断できない記事は自動削除または自動noindexにしない
 - 大量のnoindex、sitemap除外、記事削除を決定する場合は、新しいADRを作成してから実行する

### 5. sitemapと手動申請を扱う

 - 内容を変更していないsitemapを繰り返し送信しない
 - sitemap分割はインデックス促進策ではなく、クラスタ別の計測が必要になった場合だけ採用する
 - ハブ公開後、Search ConsoleのURL検査画面からハブと代表記事5件から10件を一度だけ申請する
 - 通常記事のインデックス登録申請はAPIから実行できないため、Search Console画面でユーザが操作する
 - 同じURLの反復申請は高速化につながらないため行わない

### 6. 再計測する

| 時点 | 予定日 | 確認内容 |
|---|---|---|
| T0 | 2026-07-16 | 現在の基準値 |
| T+7 | 2026-07-23 | sitemap状態、ハブ、重要記事30件の代表サンプル |
| T+21 | 2026-08-06 | クロール、canonical、インデックス状態の比較 |

各URLで次を記録する

 - verdict
 - coverageState
 - lastCrawlTime
 - pageFetchState
 - robotsTxtState
 - indexingState
 - googleCanonical
 - userCanonical

## 完了条件

 - 重要記事30件と5クラスタが確定している
 - 各クラスタにハブがあり、登録済みページから到達できる
 - 重要記事30件がハブまたは関連記事から最低3本の関連リンクを受ける
 - 関連記事0件の原因と対応方針が分類されている
 - ビルド、生成サイト検証、内部リンク検査が成功している
 - Search Consoleで優先URLの手動申請が完了している
 - T+7とT+21の結果が本書に追記されている
 - 結果に基づき、継続、内容統合、保留のいずれかを決定している

## 判断基準

 - URL unknownからクロール済みまたは登録済みへ変化したURL数を主要指標にする
 - 順位やクリック数はインデックス後の指標として分離する
 - T+21でもクロールが0件の場合は、技術施策の追加より内容統合を優先する
 - 内容統合後も変化がない場合は、[[0001-seo-technical-scope]]で保留した被リンクとクロスポスト方針を再検討する

## 対象外

 - 全1752記事のインデックス保証
 - 内容を変更していない記事の`lastmod`更新
 - 根拠のない大量リンク追加
 - 自動判定だけによる記事削除またはnoindex
 - 現段階での有料SEO施策

## 関連文書

 - [[0001-seo-technical-scope]]
 - [[0002-heading-structure-normalization]]
 - [短文記事とメタデータの統合監査](./content-consolidation.md)
 - [SEO改善案](../draft/seo-improvements.md)

## 参考

 - [Googleに再クロールを依頼する](https://developers.google.com/search/docs/crawling-indexing/ask-google-to-recrawl)
 - [Googleのリンクに関するベストプラクティス](https://developers.google.com/search/docs/crawling-indexing/links-crawlable)
 - [サイトマップの作成と送信](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
 - [クロールバジェットの管理](https://developers.google.com/search/docs/crawling-indexing/large-site-managing-crawl-budget)
 - [クロールとインデックス登録のFAQ](https://developers.google.com/search/help/crawling-index-faq)
