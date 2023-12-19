---
layout: post
title: "sqlalchemy+mysql" 
date: "2022-09-29"
excerpt: "sqlalchemy+mysqlの使い方"
config: true
tag: ["sqlalchemy", "orm", "python", "mysql"]
comments: false
sort_key: "2022-09-29"
update_dates: ["2022-09-29"]
---

# sqlalchemy+mysqlの使い方

## 概要
 - pythonのORM

## インストール

```console
$ pip install sqlalchemy mysqlclient
```
 - mysqlをバックエンドとして使う場合

## engineとbase modelの定義

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import os

dialect = "mysql"
driver = "mysqldb"
username = os.environ.get("USER")
password = os.environ.get("MYSQL_PASSWORD")
host = "localhost"
port = "3306"
database = "sample_db"
charset_type = "utf8"
db_url = f"{dialect}+{driver}://{username}:{password}@{host}:{port}/{database}?charset={charset_type}"

engine = create_engine(db_url, echo=False)
Base = declarative_base()
```

## モデルの定義

```python
""" モデルの定義 """
from sqlalchemy import Column, Integer, String, DateTime, Sequence, BLOB
import datetime

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, Sequence('user_id_seq'), primary_key=True)
    calculated_at = Column('calculated_at', DateTime, default=datetime.datetime.now, nullable=False)
    team_id = Column(Integer)
    values = Column(BLOB)
    created_at = Column('created_at', DateTime, default=datetime.datetime.now, nullable=True)
    updated_at = Column('updated_at', DateTime, default=datetime.datetime.now, nullable=True)
    def __str__(self):
        return f'id = {self.id}, team_id = {self.team_id}, calculated_at = {self.calculated_at}'

""" テーブルが存在しなかったら作成 """
Base.metadata.create_all(bind=engine)
```

## データを入れたり、検索したり

```python
from sqlalchemy.orm import sessionmaker
from tqdm.auto import tqdm
import numpy as np
from string import ascii_letters

SessionClass = sessionmaker(engine) # セッションを作るクラスを作成
with SessionClass() as session:
    calculated_at = datetime.datetime.now()
    for team_id in tqdm(range(1000)):
        data = np.random.choice(list(ascii_letters), 10000, replace=True)
        data = bytes("".join(data), "utf8")
        user = User(calculated_at=calculated_at, team_id=team_id, values=data)
        session.add(user)
        session.commit()

with SessionClass() as session:
    for user in session.query(User).filter(50 <= User.team_id).filter(User.team_id <= 100).all():
        print(user)
```
