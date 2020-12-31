---
layout: post
title:  "google calendar"
date:   2020-12-31
excerpt: "google calendar"
project: false
config: true
tag: ["google calendar", "cloud", "software"]
comments: false
---

# google calendar

## python api
 
*official docs*  
 - [https://developers.google.com/calendar/quickstart/python](https://developers.google.com/calendar/quickstart/python)

*requires* 
```console
$ python3 -m pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
```

## get recent calendar data example

client_secret_fileとは、`APIとサービス` > `認証情報` > `OAuth 2.0 クライアント ID`から`デスクトップ`の種類で認証情報を作成すれば良い  
`OAuthの認証`に対応しており、`サービスアカウント`等は対応していなかった  

```python
import datetime
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/calendar']


def base():
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('client_secret_1061473190594-fkm2feaplgmcfk2ppl4pfmtbk58npgri.apps.googleusercontent.com.json', SCOPES)
            creds = flow.run_console()
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    service = build('calendar', 'v3', credentials=creds)
    timeMin = datetime.datetime.utcnow() - datetime.timedelta(hours=24 * 7)
    timeMin = timeMin.isoformat() + 'Z'

    events_result = service.events().list(calendarId='primary', timeMin=timeMin, maxResults=30, singleEvents=True, orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        print('No upcoming events found.')
        return None
    return events


if __name__ == '__main__':
    events = base()
    for event in events:
        print(event)
```

output example
```json
{'kind': 'calendar#event', 'etag': '"3217795042688000"', 'id': '0s2qehcqbbcs4rl0uvglug4ib5_20210219T120000Z', 'status': 'confirmed', 'htmlLink': 'https://www.google.com/calendar/event?eid=MHMycWVoY3FiYmNzNHJsMHV2Z2x1ZzRpYjVfMjAyMTAyMTlUMTIwMDAwWiBhbmdlbGR1c3QwM0Bt', 'created': '2020-12-09T14:05:36.000Z', 'updated': '2020-12-25T11:58:41.344Z', 'summary': '松田くん', 'creator': {'email': 'angeldust03@gmail.com', 'self': True}, 'organizer': {'email': 'angeldust03@gmail.com', 'self': True}, 'start': {'dateTime': '2021-02-19T21:00:00+09:00', 'timeZone': 'Asia/Tokyo'}, 'end': {'dateTime': '2021-02-19T23:00:00+09:00', 'timeZone': 'Asia/Tokyo'}, 'recurringEventId': '0s2qehcqbbcs4rl0uvglug4ib5', 'originalStartTime': {'dateTime': '2021-02-19T21:00:00+09:00', 'timeZone': 'Asia/Tokyo'}, 'iCalUID': '0s2qehcqbbcs4rl0uvglug4ib5@google.com', 'sequence': 0, 'reminders': {'useDefault': True}}...
```
