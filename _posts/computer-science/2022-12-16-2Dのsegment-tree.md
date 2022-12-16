---
layout: post
title: "2Dのsegment-tree"
date: 2022-12-16
excerpt: "2Dのsegment-treeについて"
computer_science: true
tag: ["アルゴリズム", "segment-tree", "2D"]
comments: false
sort_key: "2022-12-16"
update_dates: ["2022-12-16"]
---

# 2Dのsegment-treeについて

## 概要
 - 一次元のsegment-treeより、2次元のsegment-treeに拡張するとだいぶ複雑になる
 
## テンプレート

```python
import math
class SegmentTree2D():
    DEFAULT = {
        'min': 1 << 60,
        'max': -(1 << 60),
        'sum': 0,
        'prd': 1,
        'gcd': 0,
        'lmc': 1,
        '^': 0,
        '&': (1 << 60) - 1,
        '|': 0,
    }
    FUNC = {
        'min': min,
        'max': max,
        'sum': (lambda x, y: x + y),
        'prd': (lambda x, y: x * y),
        'gcd': math.gcd,
        'lmc': (lambda x, y: (x * y) // math.gcd(x, y)),
        '^': (lambda x, y: x ^ y),
        '&': (lambda x, y: x & y),
        '|': (lambda x, y: x | y),
    }
    def __init__(self, mat, mode='min', func=None, default=None):
        """
        要素mat, 関数mode (min,max,sum,prd(product),gcd,lmc,^,&,|)
        func,defaultを指定すれば任意の関数、単位元での計算が可能
        """
        N = len(mat)
        M = len(mat[0])
        if default == None:
            self.default = self.DEFAULT[mode]
        else:
            self.default = default
        if func == None:
            self.func = self.FUNC[mode]
        else:
            self.func = func
        self.N = N
        self.M = M
        self.KN = (N - 1).bit_length()
        self.KM = (M - 1).bit_length()
        self.N2 = 1 << self.KN
        self.M2 = 1 << self.KM
        self.dat = [[self.default] * (2**(self.KM + 1)) for i in range(2**(self.KN + 1))]
        for i in range(self.N):
            for j in range(self.M):
                self.dat[self.N2 + i][self.M2 + j] = mat[i][j]
        self.build()
    def build(self):
        for j in range(self.M):
            for i in range(self.N2 - 1, 0, -1):
                self.dat[i][self.M2 + j] = self.func(self.dat[i << 1][self.M2 + j], self.dat[i << 1 | 1][self.M2 + j])
        for i in range(2**(self.KN + 1)):
            for j in range(self.M2 - 1, 0, -1):
                self.dat[i][j] = self.func(self.dat[i][j << 1], self.dat[i][j << 1 | 1])
    def leafvalue(self, x,y):  # (x,y)番目の値の取得
        return self.dat[x + self.N2][y + self.M2]
    def update(self, x, y, value):  # (x,y)の値をvalueに変える
        i = x + self.N2
        j = y + self.M2
        self.dat[i][j] = value
        while j > 1:
            j >>= 1
            self.dat[i][j] = self.func(self.dat[i][j << 1], self.dat[i][j << 1 | 1])
        j = y + self.M2
        while i > 1:
            i >>= 1
            self.dat[i][j] = self.func(self.dat[i << 1][j], self.dat[i << 1 | 1][j])
            while j > 1:
                j >>= 1
                self.dat[i][j] = self.func(self.dat[i][j << 1], self.dat[i][j << 1 | 1])
            j = y + self.M2
        return
    def query(self, Lx, Rx, Ly, Ry):  # [Lx,Rx)×[Ly,Ry)の区間取得
        Lx += self.N2
        Rx += self.N2
        Ly += self.M2
        Ry += self.M2
        vLx = self.default
        vRx = self.default
        while Lx < Rx:
            if Lx & 1:
                vLy = self.default
                vRy = self.default
                Ly1 = Ly
                Ry1 = Ry
                while Ly1 < Ry1:
                    if Ly1 & 1:
                        vLy = self.func(vLy, self.dat[Lx][Ly1])
                        Ly1 += 1
                    if Ry1 & 1:
                        Ry1 -= 1
                        vRy = self.func(self.dat[Lx][Ry1], vRy)
                    Ly1 >>= 1
                    Ry1 >>= 1
                vy = self.func(vLy, vRy)
                vLx = self.func(vLx,vy)
                Lx += 1
            if Rx & 1:
                Rx -= 1
                vLy = self.default
                vRy = self.default
                Ly1 = Ly
                Ry1 = Ry
                while Ly1 < Ry1:
                    if Ly1 & 1:
                        vLy = self.func(vLy, self.dat[Rx][Ly1])
                        Ly1 += 1
                    if Ry1 & 1:
                        Ry1 -= 1
                        vRy = self.func(self.dat[Rx][Ry1], vRy)
                    Ly1 >>= 1
                    Ry1 >>= 1
                vy = self.func(vLy, vRy)
                vRx = self.func(vy, vRx)
            Lx >>= 1
            Rx >>= 1
        return self.func(vLx, vRx)
```

---

## 参考
 - [pythonで2Dセグメント木実装/Qiita](https://qiita.com/tomato1997/items/83ccdfe0ce1f5548a42a)
