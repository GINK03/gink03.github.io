---
layout: post
title: "deep learning vm"
date: 2021-02-28
excerpt: "ai platform deep learning vmについて"
kaggle: true
hide_from_post: true
tag: ["deep-learning", "gcp"]
comments: false
sort_key: "2021-03-21"
update_dates: ["2021-03-21"]
---

# ai platform deep learning vmについて

## 概要
 - gcpのai platformで利用できるvmイメージ

## 作成方法 

**cui**
```console
export IMAGE_FAMILY="tf-latest-cu92"
export ZONE="us-west1-b"
export INSTANCE_NAME="my-new-instance"
export INSTANCE_TYPE="n1-standard-8"
gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator="type=nvidia-tesla-v100,count=8" \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=120GB \
        --metadata="install-nvidia-driver=True"
```

**cloud marketplace**
 - [Deep Learning VM Cloud Marketplace](https://console.cloud.google.com/marketplace/product/click-to-deploy-images/deeplearning?_ga=2.181608551.1967779532.1616220113-1541639094.1605359690&project=starry-lattice-256603&folder=&organizationId=)

