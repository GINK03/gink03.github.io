---
layout: post
title: "aws transcribe"
date: 2024-06-30
excerpt: "aws transcribeの概要と使い方"
project: false
config: true
tag: ["aws", "aws transcribe", "stt"]
comments: false
sort_key: "2024-06-30"
update_dates: ["2024-06-30"]
---

# aws transcribeの概要と使い方

## 概要
 - 音声をテキストに変換するサービス
 - ストリーミングAPIに対応している

## 使い方(streaming)

```python
import asyncio
import sounddevice
from amazon_transcribe.client import TranscribeStreamingClient
from amazon_transcribe.handlers import TranscriptResultStreamHandler
from amazon_transcribe.model import TranscriptEvent

class MyEventHandler(TranscriptResultStreamHandler):
    async def handle_transcript_event(self, transcript_event: TranscriptEvent):
        results = transcript_event.transcript.results
        for result in results:
            for alt in result.alternatives:
                print(alt.transcript)

async def mic_stream():
    loop = asyncio.get_event_loop()
    input_queue = asyncio.Queue()

    def callback(indata, frame_count, time_info, status):
        loop.call_soon_threadsafe(input_queue.put_nowait, (bytes(indata), status))

    stream = sounddevice.RawInputStream(
        channels=1,
        samplerate=16000,
        callback=callback,
        blocksize=1024 * 2,
        dtype="int16",
    )
    with stream:
        while True:
            indata, status = await input_queue.get()
            yield indata, status


async def write_chunks(stream):
    async for chunk, status in mic_stream():
        await stream.input_stream.send_audio_event(audio_chunk=chunk)
    await stream.input_stream.end_stream()


async def basic_transcribe():
    client = TranscribeStreamingClient(region="ap-northeast-1")

    stream = await client.start_stream_transcription(
        language_code="ja-JP",
        media_sample_rate_hz=16000,
        media_encoding="pcm",
    )

    handler = MyEventHandler(stream.output_stream)
    await asyncio.gather(write_chunks(stream), handler.handle_events())


loop = asyncio.get_event_loop()
loop.run_until_complete(basic_transcribe())
```

## 参考
 - [amazon-transcribe-streaming-sdk/examples/simple_mic.py](https://github.com/awslabs/amazon-transcribe-streaming-sdk/blob/develop/examples/simple_mic.py)

