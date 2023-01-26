---
layout: post
title: "vtuber-post.com"
date: 2023-01-26
excerpt: "vtuber-post.comの概要と保有しているデータ"
learning: true
tag: ["vtuber"]
comments: false
sort_key: "2023-01-26"
update_dates: ["2023-01-26"]
---

# vtuber-post.comの概要と保有しているデータ

## 概要
 - いろんなvtuberの情報が掲載されているサイト
 - 大手から弱小のvtuberのデータが確認できる
 - シングルページアプリケーションになっているのでpostでデータをやり取りして描画している

## 役に立つ情報
 - 投稿者名
 - 登録日
 - 登録者数
 - 最近の動画投稿の日時とタイトル

## データの取得例
 - ライセンスの確認は行うこと
   - [一般的な著作権](https://vtuber-post.com/rule.html)が適応される
 - 1secのスリープは適宜入れること

### vtuberの一覧を取得(postの情報にどの範囲のデータかを指定)

```python
def fetch_index():
    for i in range(0, 15):
        with requests.post("https://vtuber-post.com/database/index.php", data={"pageFlg": "1", "page": i, "order": "1", "limit": "1000"}) as r:
            text = r.text
        with open(f"index_{i:02d}.html", "w") as fp:
            fp.write(text)
        time.sleep(1.0)

def parse_html():
    df = pd.DataFrame()
    data = []
    for filename in glob.glob("index_*.html"):
        soup = BeautifulSoup(open(filename).read())
        for blk in soup.find("div", {"class": "vtuber_list"}).find_all("div", {"class": "clearfix"}):
            name = blk.find("p", {"class": "name"}).text.strip()
            href = "https://vtuber-post.com/database/" + blk.find("a").get("href")
            regist = blk.find("p", {"class": "regist"}).text if blk.find("p", {"class": "regist"}) else None
            play = blk.find("p", {"class": "play"}).text if blk.find("p", {"class": "play"}) else None
            data.append((name, href, regist, play))
    df = pd.DataFrame(data)
    df.columns = ["name", "href", "regist", "play"]
    df["regist"] = df["regist"].str.replace("(,|回|人)", "", regex=True)
    df["play"] = df["play"].str.replace("(,|回|人)", "", regex=True)
    df.to_csv("vtuber_list.csv", index=False)
```

---

## 参考
 - [利用規約/vtuber-post.com](https://vtuber-post.com/rule.html)
