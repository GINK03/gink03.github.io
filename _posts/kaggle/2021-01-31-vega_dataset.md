---
layout: post
title: "vega_dataset"
date: 2021-01-31
excerpt: "vegaと呼ばれるopen datasetについて"
kaggle: true
hide_from_post: true
tag: ["vega", "dataset", "python"]
comments: false
---


# vegaと呼ばれるopen datasetについて
 - 概要
   - いろいろなデータが乱雑に入っているデータセット  
   - pip, condaで入るところが便利
 - link
   - https://github.com/altair-viz/vega_datasets

## install 

```python
pip install vega_dataset
```

## 使い方

使用できるデータの一覧の確認

```python
>> from vega_datasets import data

>> data.list_datasets() # datasetのリストが帰ってくる

['7zip', 'airports', 'annual-precip', 'anscombe', 'barley', 'birdstrikes', 'budget', 'budgets', 'burtin', 'cars', 'climate', 'co2-concentration', 'countries', 'crimea', 'disasters', 'driving', 'earthquakes', 'ffox', 'flare', 'flare-dependencies', 'flights-10k', 'flights-200k', 'flights-20k', 'flights-2k', 'flights-3m', 'flights-5k', 'flights-airport', 'gapminder', 'gapminder-health-income', 'gimp', 'github', 'graticule', 'income', 'iowa-electricity', 'iris', 'jobs', 'la-riots', 'londonBoroughs', 'londonCentroids', 'londonTubeLines', 'lookup_groups', 'lookup_people', 'miserables', 'monarchs', 'movies', 'normal-2d', 'obesity', 'ohlc', 'points', 'population', 'population_engineers_hurricanes', 'seattle-temps', 'seattle-weather', 'sf-temps', 'sp500', 'stoks', 'udistrict', 'unemployment', 'unemployment-across-industries', 'uniform-2d', 'us-10m', 'us-employment', 'us-state-capitals', 'volcano', 'weather', 'weball26', 'wheat', 'windvectors', 'world-110m', 'zipcodes']c
```

e.g. `airports`のデータの使い方  

```python
>> data.airports()
```
