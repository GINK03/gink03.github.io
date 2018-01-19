---
layout: post
title:  "Aamzonなどのサイトをクローリングするさい注意する点"
date:   2016-03-15
excerpt: "abuse対策網のあなをつけ"
tag:
- crawling
- Amazon
comments: true
---
# Aamzonなどのサイトをクローリングするさい注意する点
　やり方は色々あるのだけど、一番問題なのは、機械学習アルゴリズムで不正アクセスと思われるアクセスはシャットアウトされてしまうことにある。  
　おそらくであるが、その機械学習で使われているアルゴリズムは、IPとUAとCookieをもとに決定しているようで、一度、IPがアク禁リストに入ってしまうと、５回に一回の程度のアクセスにしかレスを返さなくなってしまう。  
　
　まだアク禁リストに入ってないIPからだとアクセスできたりするので、IPの重要度が高いのだろう。   
 以下にPythonでの使用例を記す。  
 ```python
 html = None
 retrys = [i for i in range(1)]
 for _ in retrys :
   import cookielib
   jar = cookielib.CookieJar()
   jar.set_cookie(makeCookie("session-token", "mu26PbfgQT4xERN6gtu8SkSoPQ7kwdgVpR7LHWqDJep5QE34DERo6AkSa0hCEhblH9k/YZkyPjnI1OIAe1+dWkZAcWZSl7fdH6SilVpQlTiFWjlsrvrvxLvb3tx2oLReL+vmG1KVWqQngeJ0JzL1asxIc+ktBPwbu7J8DPkOq05vckf90UUTPYCi6EFG2KmCYj7Yy86T9lc/CiGp7ZOUswI4cLM6rt4mKUEqnhDmpSvWKqaPWsT9EWSHXtUyyugY"))
   headers = {"Accept-Language": "en-US,en;q=0.5","User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0","Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8","Referer": "http://thewebsite.com","Connection": "keep-alive" }
   request = urllib2.Request(url=url, headers=headers)
   opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(jar))
   _TIME_OUT = 5.
   try:
     html = opener.open(request, timeout = _TIME_OUT).read()
   except EOFError, e:
     print('[WARN] Cannot access url with EOFError, try number is...', e, _, url, mp.current_process() )
     continue
```
