---
layout: post
title: "pigeonhole principle"
date: 2021-05-08
excerpt: "pigeonhole principle(鳩の巣原理)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "鳩の巣原理", "pigeonhole principle"]
comments: false
---

# pigeonhole principle(鳩の巣原理)について
`m > n`のとき、nの箱にm個の要素を当てはめると必ず一つは2個以上になる  
当たり前のことであると思うが、実際に適応例がすぐ出てこなかったりする  

## 参考
[鳩の巣原理](https://ja.wikipedia.org/wiki/%E9%B3%A9%E3%81%AE%E5%B7%A3%E5%8E%9F%E7%90%86)


## 例; 鳩の巣の原理を使うことで計算量を大幅に限定できる例

**問題**  
[京セラプログラミングコンテスト2021（AtCoder Beginner Contest 200); D - Happy Birthday! 2](https://atcoder.jp/contests/abc200/tasks/abc200_d)  

**解説**  
200で割ったあまりが等しいということなので、`0 < n <= 200`までで示される組み合わせが２つ以上存在するか、と読み替えられる  
読み替えることができると、bit全探索に持ち込むことができる  

**回答**  
```python
N=int(input())
A=list(map(int,input().split()))

cnt = min(8, len(A))

bk=[[] for i in range(200)]

for i in range(1, 1<<cnt): # 最大8bit表現から
    sig = 0
    s = []
    for j in range(0, cnt):
        if i&(1<<j) != 0: # つまりbitが共起したら
            s.append(j+1)
            sig+=A[j]
            sig%=200

    if len(bk[sig]) != 0:
        print("Yes")
        print(len(bk[sig]), *bk[sig])
        print(len(s), *s)
        exit()
    else:
        bk[sig] = s

print("No")
```

