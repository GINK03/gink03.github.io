---
layout: post
title: "sqlalchemy+json" 
date: "2023-12-19"
excerpt: "sqlalchemy+jsonの使い方"
config: true
tag: ["sqlalchemy", "orm", "python", "json", "sqlite"]
comments: false
sort_key: "2023-12-19"
update_dates: ["2023-12-19"]
---

# sqlalchemy+jsonの使い方

## 概要
 - sqliteでサポートされているjson1拡張を使うことができる
 - sqlalchemyで使用する際には、型がstrになっているようである

## 具体例

```python
from sqlalchemy import create_engine, String, JSON, Column
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid

EntityBase = declarative_base()

class Item(EntityBase):
    __tablename__ = "items"
    # UUIDを文字列として保存
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()), nullable=False)
    data = Column(JSON, nullable=True)

# データベースのセットアップ
engine = create_engine("sqlite:///example.db", echo=True)
Session = sessionmaker(bind=engine)
session = Session()
EntityBase.metadata.create_all(engine)

# 複数アイテムの追加
items = [
    Item(data={'name': 'Alice', 'age': 30}),
    Item(data={'name': 'Bob', 'age': 25}),
    Item(data={'name': 'Carol', 'age': 27})
]
session.add_all(items)
session.commit()

# アイテムの検索
for item in session.query(Item).filter(Item.data["name"] == 'Alice'):
    print(item.id, item.data)

# アイテムの削除
session.query(Item).filter(Item.data["age"] == "25").delete()
session.commit()

# データベースのクローズ
session.close()
```

