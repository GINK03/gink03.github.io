---
layout: post
title: "gcp client library"
date: 2021-04-28
excerpt: "gcp client libraryチートシート"
tags: ["python", "gcp"]
config: true
comments: false
---

# gcp client libraryチートシート
 - `google-api-python-client`というpackage
 - pythonでGCPのAPIを叩く際に必要
 - 様々なAPIがgoogleからも開発されているが、これが一番根幹のAPIになる
   - ドキュメントが網羅的である反面、複雑度が高い

## インストール

```console
$ python3 -m pip install google-api-python-client
$ python3 -m pip install google-auth
```

## ドキュメント
 - https://googleapis.github.io/google-api-python-client/docs/
   - [リファレンス](https://googleapis.github.io/google-api-python-client/docs/dyn/)
 

## gcloudコマンドとの対応

***compute instance***
```console
$ gcloud compute instances list
```

```python
from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
from googleapiclient import errors

project = "dena-ai-training-16-gcp"
project_id = 'projects/{}'.format(project)
zone = "us-central1-a"

compute = discovery.build('compute', 'v1')
ret = compute.instances().list(project=project, zone=zone).execute()
print(ret)
````

***ai platform***

```console
$ gcloud ai-platform jobs submit training job --master-image-uri=... --region=... --scale-tier=... ...
```
 - [参考](https://cloud.google.com/sdk/gcloud/reference/ai-platform/jobs/submit/training)

```python
from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
from googleapiclient import errors

project = "dena-ai-training-16-gcp"
project_id = 'projects/{}'.format(project)
zone = "us-central1-a"

training_inputs = {
            "masterConfig": {
                'imageUri': "gcr.io/dena-ai-training-16-gcp/hello-world",
            },
            "region": "us-central1",
            'scaleTier': 'BASIC',
            'packageUris': [],
            'args': [],
            'pythonVersion': '3.7',
            'scheduling': {
                'maxRunningTime': '3600s'
            },
        }

job_spec = {'jobId': 'my_job_name', 'trainingInput': training_inputs}

ml = discovery.build('ml','v1')
resource = ml.projects().jobs().create(parent='projects/dena-ai-training-16-gcp', body=job_spec)
print(resource.execute())
```
 - このように厳密に対応しないことも多い
 - [参考](https://stackoverflow.com/questions/56326145/submit-gcloud-ai-platform-training-job-programmatically-from-python-code)


