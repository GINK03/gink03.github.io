---
layout: post
title: "crash reports"
date: 2020-05-19
excerpt: ""
tags: [crash reports]
comments: false
---

# 2020-05-19 05:00:00

原因
```
ERROR: apport (pid 3615845) Tue May 12 02:40:39 2020: Unhandled exception:
Traceback (most recent call last):
  File "/usr/share/apport/apport", line 552, in <module>
    get_pid_info(pid)
  File "/usr/share/apport/apport", line 70, in get_pid_info
    proc_pid_fd = os.open('/proc/%s' % pid, os.O_RDONLY | os.O_PATH | os.O_DIRECTORY)
FileNotFoundError: [Errno 2] No such file or directory: '/proc/3611700'
ERROR: apport (pid 3615845) Tue May 12 02:40:39 2020: pid: 3615845, uid: 0, gid: 0, euid: 0, egid: 0
ERROR: apport (pid 3615845) Tue May 12 02:40:39 2020: environment: environ({'LC_CTYPE': 'C.UTF-8'})
```

### 考えられることと仮説
 - HDDが故障するなどしてFDの整合性が壊れた -> HDDを買い直すなど
 - メモリの故障 -> ECCメモリなので可能性は低い？



