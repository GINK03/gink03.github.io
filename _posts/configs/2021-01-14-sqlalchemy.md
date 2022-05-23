---
layout: post
title:  "sqlalchemy"
date:   2021-01-14
excerpt: "sqlalchemy"
project: false
config: true
tag: ["sqlalchemy", "usage", "db"]
comments: false
sort_key: "2021-01-14"
update_dates: ["2021-01-14"]
---

# sqlalchemy

## install

```console
$ python3 -m pip install sqlalchemy
```
## ormモデルを作成
 - `Base`インスタンスを引数に定義する
  
```python3
Base = declarative_base()


class Profile(Base):
    __tablename__ = "profile"
    id = Column(Integer, primary_key=True)
    email = Column(String, nullable=False, unique=True)
    name = Column(String, nullable=False)
    sex = Column(String, nullable=False)
    birth_day = Column(DateTime, nullable=False)
    job = Column(String)
    divorce_history = Column(Integer)
    children = Column(Integer)

Profile.__table__.create(bind=engine, checkfirst=True)
```

## engineとは
 - sqlalchemyがdbに対する書き込み読み込みを行うインスタンス
 - sessionという最小のdbに対するオペレーション単位と別に存在する
 - sqlite, mysqlなどが使える

```python3
engine = sqlalchemy.create_engine(f"sqlite:///{TOP_DIR}/var/profile.db", echo=False)
```

## session
 - engineを引数に作れるdbに対するオペレーションを行うインスタンス

```python3
Session = sessionmaker()
Session.configure(bind=engine)
session = Session()
```

## e.g. ランダムなcsvのユーザデータをsqliteに書き込む

```python3
from sqlalchemy.sql import exists
from sqlalchemy.orm import sessionmaker, relationship, backref
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import (
    create_engine,
    Column,
    DateTime,
    Integer,
    String,
    Sequence,
    Float,
    PrimaryKeyConstraint,
    ForeignKey,
)
import sqlalchemy
import pandas as pd
from pathlib import Path

TOP_DIR = Path(__file__).resolve().parent.parent


engine = sqlalchemy.create_engine(f"sqlite:///{TOP_DIR}/var/profile.db", echo=False)

Base = declarative_base()


class Profile(Base):
    __tablename__ = "profile"
    id = Column(Integer, primary_key=True)
    email = Column(String, nullable=False, unique=True)
    name = Column(String, nullable=False)
    sex = Column(String, nullable=False)
    birth_day = Column(DateTime, nullable=False)
    job = Column(String)
    divorce_history = Column(Integer)
    children = Column(Integer)


Profile.__table__.create(bind=engine, checkfirst=True)


Session = sessionmaker()
Session.configure(bind=engine)

dummy_profile = pd.read_csv(TOP_DIR / "var/dummy_profile.csv")
dummy_profile.rename(columns={"アドレス": "email", "名前": "name", "性別": "sex", "誕生日": "birth_day"}, inplace=True)
dummy_profile.birth_day = pd.to_datetime(dummy_profile.birth_day)
dummy_profile = dummy_profile[["email", "name", "sex", "birth_day"]]

session = Session()
for i, itr in dummy_profile.iterrows():
    ret = session.query(exists().where(Profile.email == itr["email"])).scalar()
    if ret is False:
        print(itr)
        profile = Profile(**itr)
        session.add(profile)
        session.commit()

session.close()
```
