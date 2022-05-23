---
layout: post
title:  "pytorch dataset"
date:   2021-01-05
excerpt: "pytorchのdataset classの使い方"
project: false
tag: ["python", "pytorch"]
comments: false
sort_key: "2022-03-22"
update_dates: ["2022-03-22"]
---

# pytorchのdataset classの使い方

## 概要
 - `Dataset Class`を継承して使う
 - index要素アクセスでデータを引き出せる
   - `__getitem__`にindexで要素アクセスする 
 - `Dataset Class`を継承して作成したインスタンスを`DataLoader`クラスで読み出す

---

## 最小構成テンプレート(minimal template)

**ダミー情報の作成**  
```python
import pandas as pd
import numpy as np
df = pd.DataFrame()
df["param"] = np.random.random((100,))
```

**Datasetクラスの作成**  
```python
from pandas.core.frame import DataFrame
from torch.utils.data import Dataset, DataLoader

class UserDataset(Dataset):
    def __init__(self, df):
        self.df = df
    def __len__(self):
        return self.df.shape[0]
    def __getitem__(self, index):
        row = self.df.iloc[index]
        return row["param"]

udataset = UserDataset(df)
display(udataset[1]) # 0.8289795102510317
```

**DataLoaderクラスで読み出す**  
```python
train_loader = DataLoader(udataset, 
                          batch_size=32, 
                          shuffle=True, 
                          num_workers=4,
                          pin_memory=False, 
                          drop_last=True)
for data in train_loader:
    print(data) # tensor([0.9034, 0.5378, 0.9615, 0.2905, 0.5310, 0.3499, 0.3936, 0.3074, 0.6413,
```

### Google Colab
 - [pytorch-dataset-example](https://colab.research.google.com/drive/1trvfkEPnUUeRP9yje6iEMnWfeq_aYXyT?usp=sharing)

---

## 具体例

### e.g. 画像をロードするdataset class

```python
class FaceLandmarksDataset(Dataset):
    """Face Landmarks dataset."""

    def __init__(self, csv_file, root_dir, transform=None):
        """
        Args:
            csv_file (string): Path to the csv file with annotations.
            root_dir (string): Directory with all the images.
            transform (callable, optional): Optional transform to be applied
                on a sample.
        """
        self.landmarks_frame = pd.read_csv(csv_file)
        self.root_dir = root_dir
        self.transform = transform

    def __len__(self):
        return len(self.landmarks_frame)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()

        img_name = os.path.join(self.root_dir,
                                self.landmarks_frame.iloc[idx, 0])
        image = io.imread(img_name)
        landmarks = self.landmarks_frame.iloc[idx, 1:]
        landmarks = np.array([landmarks])
        landmarks = landmarks.astype('float').reshape(-1, 2)
        sample = {'image': image, 'landmarks': landmarks}

        if self.transform:
            sample = self.transform(sample)

        return sample
```

*使用例*
```python
face_dataset = FaceLandmarksDataset(csv_file='data/faces/face_landmarks.csv',
                                    root_dir='data/faces/')
fig = plt.figure()

for i in range(len(face_dataset)):
    sample = face_dataset[i]
    print(i, sample['image'].shape, sample['landmarks'].shape)
    ax = plt.subplot(1, 4, i + 1)
    plt.tight_layout()
    ax.set_title('Sample #{}'.format(i))
    ax.axis('off')
    show_landmarks(**sample)
    if i == 3:
        plt.show()
        break
```

## 参考
 - [Writing Custom Datasets, DataLoaders and Transforms](https://pytorch.org/tutorials/beginner/data_loading_tutorial.html)
