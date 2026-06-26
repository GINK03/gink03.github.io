# SEO改善案

このサイト（gink03.github.io / Jekyll + jekyll-theme-cayman）のSEO改善案をまとめる
調査日時点のビルド済みHTML（`_site`）と各テンプレートを確認した結果に基づく

## 前提（確認済みの現状）
 - プラグイン: `jekyll-sitemap`, `jekyll-feed`, `jekyll-mentions`, `jekyll-gist`
 - `head.html` で OG / Twitter Card / canonical / description を手書きで生成済み
 - `tag`（単数）でも `page.tags` に正しく載り、keywordsメタとタグリンクは機能している（問題なし）
 - Google Analytics (gtag, G-EZ99XHGDH8) 導入済み

---

## 優先度: 高（小さな差分で効果が出る低リスク改善）

### 1. 構造化データ（JSON-LD）の導入
 - 現状: ビルド済みHTMLに `application/ld+json` が0件
 - 問題: `BlogPosting` / `Article` スキーマ（見出し・著者・公開日・更新日）が無く、リッチリザルトや鮮度評価に乗りにくい
 - 対策: GitHub Pages公式サポートの `jekyll-seo-tag` を導入し、JSON-LD・canonical・OGを自動生成する
   - `_config.yml` の `plugins` に `jekyll-seo-tag` を追加
   - 各レイアウトの `<head>` 内に `{% seo %}` を配置
   - 手書きの canonical / OG / Twitter メタと重複する箇所は整理する
 - 補足: `update_dates` を持っているので `last_modified_at`（jekyll-last-modified-at 等）と組み合わせ `dateModified` を出すと鮮度シグナルになる

### 2. `<html>` に `lang` 属性を付与
 - 現状: 出力は `<html class="no-js">` のみで `lang` が無い
 - 対策: 各レイアウト（`post.html` ほか）の `<html>` タグに `lang="ja"` を付与する
   - `_config.yml` に `locale: ja_JP` は既にあるので、テンプレート側で `lang="{{ site.locale | replace:'_','-' }}"` としてもよい

### 3. robots.txt に Sitemap 行を追加
 - 現状: `jekyll-sitemap` で `/sitemap.xml` は生成されるが robots.txt が参照していない
 - 対策: robots.txt に1行追加する
   - `Sitemap: https://gink03.github.io/sitemap.xml`

---

## 優先度: 中

### 4. 更新日シグナルの明示
 - 各記事の `update_dates` を `article:modified_time` および JSON-LD の `dateModified` に反映する
 - jekyll-seo-tag 導入（項目1）と合わせて対応するのが効率的

### 5. H1 の重複解消
 - 現状: レイアウトが `<h1>{{ page.title }}</h1>` を出力し、本文Markdownも先頭で `# タイトル` を書くため1ページにh1が2個
 - 影響: 中程度（Googleは複数h1を許容寄りだが、構造としては非推奨）
 - 対策（いずれか）
   - 本文を `##` 始まりにする規約へ寄せる（全記事の `#` 修正が必要で規模大、要相談）
   - レイアウト側のタイトル表現を調整して本文h1を正とする
 - 規模が大きいため、新規記事から規約適用しつつ段階的に移行する案も可

---

## 優先度: 低（未計測の推測を含む）

### 6. LCP（Core Web Vitals）対策
 - 全ページ共通の背景画像 `assets/img/wp5384373.jpg` をCSS背景で読み込んでいる
 - サイズ次第でLCPを悪化させうるため、画像の圧縮・軽量化（WebP化等）を検討する

### 7. OG画像の記事別最適化
 - 現状: OG画像は常にサイトロゴ固定
 - 記事ごとの `feature` 画像運用はSNS流入のCTRに効くが、運用コストとのトレードオフ

---

## 着手順の推奨
 1. robots.txt（項目3）— 1行追加、即効・低リスク
 2. `lang` 属性（項目2）— テンプレート数行
 3. jekyll-seo-tag 導入（項目1・4）— 構造化データと更新日を一括対応
 4. 以降、H1・画像最適化を段階的に
