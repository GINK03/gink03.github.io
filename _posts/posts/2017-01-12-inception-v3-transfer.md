---
layout: post
title: "TensorFlow Inceptionまとめ"
date: 2017-01-12
excerpt: "TensorFlow inception v3転移学習まとめ"
tags: [inception]
comments: false
---

# ボトルネックを利用した転移学習
```
p2 tensorflow/tensorflow/examples/image_retraining/retrain.py  --bottleneck_dir $HOME/sdb/food-classify-bottlenecks  --how_many_training_steps 10000  --model_dir $HOME/sdb/food-classify-train  --output_graph $HOME/sdb/food-classify-easytrain/retrained_graph.pb  --output_labels $HOME/sdb/food-classify-easytrain/retrained_labels.txt  --image_dir $HOME/sdb/food-classify-data/raw-data/train/
```
2017-01-12 21:07:33.861809: precision @ 1 = 0.7317 recall @ 5 = 0.9707 [50016 examples  

evalは基本的に学習の進捗を監視するウォッチドッグのような使い方をするものらしい  

**TensorFlowのバグ？modelが消える**

引数にホームディレクトリである、\~を混入するとファイルが消えることがあるようなので、基本的に\~は使わず、絶対パスで記述する  
eval
```
bazel-bin/inception/flowers_eval --checkpoint_dir $HOME/sdb/food-classify-train --eval_dir=$HOME/sdb/flowers-data --data_dir $HOME/sdb/food-classify-data
```
例2
```
bazel-bin/inception/flowers_eval2 --checkpoint_dir $HOME/sdb/food-classify-train --eval_dir=$HOME/sdb/flowers-data --data_dir $HOME/sdb/food-classify-data
```

### Optional : ワーニングを止める
```sh
tf.logging.set_verbosity(tf.logging.ERROR)
```

```sh 
bazel-bin/inception/flowers_train   --train_dir=~/sda/flowers-train/   --data_dir ~/sda/flowers-data/   --pretrained_model_checkpoint_path ~/sda/inception-v3/model.ckpt-157585   --fine_tune=True   --initial_learning_rate=0.001 --input_queue_memory_factor=1
```

1. tensorflow/modelからinceptionを含んだ学習モデルをダウンロードする
```sh
wget https://github.com/tensorflow/models/tree/master/inception
```

2. もとデータのダウンロードと、学習スクリプトのビルド
```
export DATA_DIR=$HOME/sdb/imagenet-data
cd ./models/inception/
```

## build and download
```sh
bazel build inception/download_and_preprocess_imagenet
bazel-bin/inception/download_and_preprocess_imagenet ${DATA_DIR}
```
## build flowers
```sh
bazel build inception/download_and_preprocess_flowers
bazel-bin/inception/download_and_preprocess_flowers ${DATA_DIR}
```
## build imagenet
```sh
bazel build inception/imagenet_train 
bazel-bin/inception/imagenet_train --num_gpus=1 --batch_size=32 --train_dir=$HOME/sdb/imagenet_data --data_dir=/tmp/imagenet_data
```
## train flowers
```sh
$ bazel build inception/flowers_train
$ bazel-bin/inception/flowers_train --num_gpus=1 --batch_size=32 --train_dir=$HOME
$ /sdb/flowers_data --data_dir=$HOME/sdb/tmp/flowers_data 
```

3. ダウンロードした画像データのシリアライズ
```sh
$ bazel-bin/inception/download_and_preprocess_flowers.runfiles/ 
$ python ~/sdb/models/inception/inception/data/build_image_data.py --train_directory=$HOME/sdb/flowers-data/raw-data/train/ $ validation_directory=$HOME/sdb/flowers-data/raw-data/validation/ --output_directory= --labels_file=$HOME/sdb/flowers-data/raw-data//labels.txt 
```

4. 実行
```sh
bazel-bin/inception/flowers_train --num_gpus=1 --batch_size=32 --train_dir ~/sdb/food-classify-out --data_dir ~/sdb/food-classify-data/
```

5. 評価
```sh
bazel-bin/inception/flowers_eval --eval_dir=$HOME/food-classify-data/raw-data/validation --data_dir=$HOME/food-classify-data --subset=validation --num_examples=500 --checkpoint_dir=$HOME/sdb/food-classify-out --input_queue_memory_factor=1 --run_once
```
6. resume 
```sh
bazel-bin/inception/flowers_train --num_gpus 1 --batch_size=32 --train_dir ~/sdb/food-classify-out --data_dir ~/sdb/food-classify-data/ --checkpoint_dir ~/sdb/food-classify-out/model.ckpt-25000 
```
