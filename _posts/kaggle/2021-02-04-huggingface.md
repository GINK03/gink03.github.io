---
layout: post
title: "huggingface"
date: 2021-02-04
excerpt: "huggingfaceの使い方"
kaggle: true
hide_from_post: true
tag: ["huggingface", "nlp", "python"]
comments: false
---

# huggingfaceの使い方

## 概要
 - transformerなどを主に扱った機械学習モデルのシェアサイト
   - モデルをアップロードしたり、一部の機能にはユーザ登録とログインが必要
 - pytorch, tensorflowを便利にラップしたライブラリを提供する

---

## 使用例で参考になるノートブック
 - [🤗 Transformers Course - Chapter 2 - TF & Torch 🤗/Kaggle](https://www.kaggle.com/code/dschettler8845/transformers-course-chapter-2-tf-torch/notebook)

---

## sentiment推論

*install*
```python
%pip install -qq transformers
%pip install torch torchvision
%pip install "fugashi[unidic-lite]" 
%pip install ipadic
```

*推論*
```python
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from transformers import pipeline
import torch

tokenizer = AutoTokenizer.from_pretrained('daigo/bert-base-japanese-sentiment', use_fast=False)

# cudaが利用できれば利用する
if torch.cuda.is_available():
  classifier = pipeline('sentiment-analysis', model="daigo/bert-base-japanese-sentiment", tokenizer=tokenizer, device=0)
else:
  classifier = pipeline('sentiment-analysis', model="daigo/bert-base-japanese-sentiment", tokenizer=tokenizer)
  

classifier("うほほーい、大好き♡")
>>> [{'label': 'ポジティブ', 'score': 0.9749482870101929}]

classifier('ケーキ食べ過ぎた、もうだめ。死にたい')
>>> [{'label': 'ネガティブ', 'score': 0.6267750859260559}]
```

---

## BERTによる[MASK]の推論

### pretrained model
 - [rinna/japanese-gpt2-medium](https://huggingface.co/rinna/japanese-gpt2-medium)

### コード

```python
import torch
from transformers import T5Tokenizer, RobertaForMaskedLM

tokenizer = T5Tokenizer.from_pretrained("rinna/japanese-roberta-base")
tokenizer.do_lower_case = True  # due to some bug of tokenizer config loading

model = RobertaForMaskedLM.from_pretrained("rinna/japanese-roberta-base")
model = model.eval()

text = "4年に1度オリンピックは開かれる。"

# prepend [CLS]
text = "[CLS]" + text

# tokenize
tokens = tokenizer.tokenize(text)
print(tokens)  # output: ['[CLS]', '▁4', '年に', '1', '度', 'オリンピック', 'は', '開かれる', '。']']

# mask a token
masked_idx = 5
tokens[masked_idx] = tokenizer.mask_token
print(tokens)  # output: ['[CLS]', '▁4', '年に', '1', '度', '[MASK]', 'は', '開かれる', '。']

# convert to ids
token_ids = tokenizer.convert_tokens_to_ids(tokens)
print(token_ids)  # output: [4, 1602, 44, 24, 368, 6, 11, 21583, 8]

# convert to tensor
token_tensor = torch.LongTensor([token_ids])

# provide position ids explicitly
position_ids = list(range(0, token_tensor.size(1)))
print(position_ids)  # output: [0, 1, 2, 3, 4, 5, 6, 7, 8]
position_id_tensor = torch.LongTensor([position_ids])

# get the top 10 predictions of the masked token
with torch.no_grad():
    outputs = model(input_ids=token_tensor, position_ids=position_id_tensor)
    predictions = outputs[0][0, masked_idx].topk(10)

for i, index_t in enumerate(predictions.indices):
    index = index_t.item()
    token = tokenizer.convert_ids_to_tokens([index])[0]
    print(i, token)

"""
0 総会
1 サミット
2 ワールドカップ
3 フェスティバル
4 大会
5 オリンピック
6 全国大会
7 党大会
8 イベント
9 世界選手権
"""
```

---

## BERTによるテキスト生成

### 参考
 - [GPT-2をファインチューニングしてニュース記事のタイトルを条件付きで生成してみた。](https://qiita.com/m__k/items/36875fedf8ad1842b729)

### Google Colab
 - [huggingface-jp-rinna](https://colab.research.google.com/drive/1oKIk0i5W-Rlte85BKBEufxc7QGRT0W7D?usp=sharing)

### コード

```python
from transformers import T5Tokenizer, AutoModelForCausalLM
import torch

tokenizer = T5Tokenizer.from_pretrained("rinna/japanese-gpt2-medium", use_fast=False) # エラーが出る場合はランタイムを再起動
tokenizer.do_lower_case = True  # due to some bug of tokenizer config loading

# ref. https://qiita.com/m__k/items/36875fedf8ad1842b729
model = AutoModelForCausalLM.from_pretrained("rinna/japanese-gpt2-medium")
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

model.to(device)
model.eval()

def generate_news_title(category, body, num_gen=10):
    input_text = '[SEP]' + body 
    tokens = tokenizer.tokenize(input_text)
    print(tokens)
    token_ids = tokenizer.convert_tokens_to_ids(tokens)
    print(token_ids)
    input_ids = tokenizer.encode(input_text, return_tensors='pt').to(device)
    out = model.generate(input_ids, do_sample=True, top_p=0.95, top_k=40, 
                         num_return_sequences=num_gen, max_length=256, bad_words_ids=[[1], [5]])
    print('='*5,'本文', '='*5)
    print(body)
    print('-'*5, '生成タイトル', '-'*5)
    for sent in tokenizer.batch_decode(out):
        print(sent)

category = '*'
body = '''
防衛省関係者によりますと、北朝鮮が弾道ミサイルの可能性があるものを発射したということです。
'''
generate_news_title(category, body)

"""
----- 生成タイトル -----
[SEP] 防衛省関係者によりますと、北朝鮮が弾道ミサイルの可能性があるものを発射したということです。</s> 北朝鮮のミサイル発射を受けて、在韓米軍の在韓米軍司令部は、北朝鮮が有するミサイルを迎撃するミサイル防衛システムの運用状況を確認しました。 防衛省関係者によりますと、北朝鮮がミサイル発射の可能性があるものを発射したということです。 防衛省幹部によりますと、北朝鮮がミサイルを発射したということです。 在韓米軍司令部は、北朝鮮がミサイルを発射したということです。 在韓米軍司令部は、北朝鮮がミサイルを発射したということです。 在韓米軍司令部は、ミサイルの発射について、北朝鮮のミサイル発射について、北朝鮮のミサイル発射を受けて、在韓米軍司令部は、北朝鮮のミサイル発射について、北朝鮮のミサイル発射を受けて、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射を受けて、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射について、在韓米軍司令部は、北朝鮮のミサイル発射を受けて
[SEP] 防衛省関係者によりますと、北朝鮮が弾道ミサイルの可能性があるものを発射したということです。</s> 北朝鮮は現在北朝鮮の核・ミサイル実験を監視・追っていると聞いています。そして、もし北朝鮮がミサイルを発射した場合には、核・ミサイル実験を中止させるため、早急な対応が必要なと考えてます。北朝鮮の弾道ミサイルに対する日本の態度について確認し、今後、どうすべきか意見を聞きたいと思います。 防衛省関係者によりますと、北朝鮮は、ミサイルの発射実験を行いました。これにより、北朝鮮が弾道ミサイルの可能性があるものが発射されました。 ところで、政府は、今後、北朝鮮の弾道ミサイルに対する対応を検討してまいります。 北朝鮮が弾道ミサイルの発射実験を行いました。ミサイル発射実験は、本日、北朝鮮が午後3時に発射しました。北朝鮮と弾道ミサイル発射実験に関して、政府では、関係閣僚会議を開催し、今後の対応について協議しています。 ところで、北朝鮮は、弾道ミサイルの発射実験を行いました。ミサイルが発射された状況について、政府は、弾道ミサイルが発射された可能性については、現時点では確認できないということで、お答えできないということです。 菅官房長官によりますと、北朝鮮の弾道ミサイルは、午後3時20分ごろから発射されました。ミサイルの発射状況については、現時点では確認できません
"""
```
