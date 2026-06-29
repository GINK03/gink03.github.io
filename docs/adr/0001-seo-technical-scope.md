# 0001. SEO はテクニカル対応に限定し、権威向上（被リンク/クロスポスト）は当面保留する

> **Status**: Accepted（2026-06-26 決定）

## Context（背景）
 - 「記事が検索で上位に来ない」という相談から、Search Console の URL Inspection で実態を調査した
 - 判明したこと
   - トップ `/` と一部の一覧（`/configs/` `/kaggle/`）は index 済みだが、そこからリンクされた個別記事は `/git/` `/markdown/` `/sops/` `/dijkstra/` 等ことごとく "URL is unknown to Google"（5年前の記事すら未クロール）
   - 内部リンク自体は概ね健全（一覧は絶対URLで全記事にリンク、`/posts/` は1541記事のマスター一覧）
   - 原因は順位ではなく、典型的なクロールバジェット枯渇＝ドメイン権威の低さ（github.io・1700超の短い記事）
 - 権威向上（被リンク獲得、Zenn/Qiita へのクロスポスト）は効果はあるが、非テクニカルで運用コストが高く、ユーザは現時点でその熱意がない

## Decision（決定）
 - SEO はテクニカルに対応できる範囲に限定する
 - 実施したテクニカル施策
   - 構造化データ JSON-LD（BlogPosting、`dateModified` は `update_dates` 由来）を `_includes/head.html` に出力
   - 全レイアウトの `<html>` に `lang="ja"`
   - robots.txt に `Sitemap:` 行（`jekyll-sitemap` が約1770URL を生成）
   - H1 重複の解消＋見出しレベル正規化（詳細は [[0002-heading-structure-normalization]]）
   - 画像 LCP 最適化（ロゴ 737K→41K、背景を WebP 化 451K→216K）
   - トップから `/posts/` `/projects/` `/bookmarks/` `/tags/` への導線追加
   - Search Console にプロパティ登録＋sitemap 送信（ユーザ対応）
 - 権威向上（被リンク・クロスポスト）は保留とし、必要になったら別 ADR で再検討する

## Consequences（影響）
 - 技術的な減点・障害は解消され、クロール/インデックスされた際に正しく理解されCTRやリッチ表示が改善する
 - ただし真のボトルネックである権威には触れないため、検索流入が劇的に増えることは期待しない（インデックスされても低権威ゆえ未登録のまま残る記事は出る）
 - 流入を本気で増やすなら将来クロスポスト等の非テクニカル施策が必要、という前提を残す
 - 未着手のテクニカル施策としてトピッククラスタ化（関連記事の相互リンク自動付与）が有力候補として残る

## 参考
 - 詳細な改善案と実施ログ: `docs/draft/seo-improvements.md`
 - 引き継ぎサマリ: `AGENTS.md` の「SEO（2026-06-26 調査と対応の記録）」
