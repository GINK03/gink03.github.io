---
layout: post
title: "python streamlit webrtc"
date: 2023-09-09
excerpt: "streamlitのwebrtcの概要と使い方"
config: true
tag: ["streamlit", "python", "webrtc"]
comments: false
sort_key: "2023-09-09"
update_dates: ["2023-09-09"]
---

# streamlitのwebrtcの概要と使い方

## 概要
 - streamlit上で画像/音声をリアルタイム処理しその結果を確認できるライブラリ
 - 音声・画像をwebアプリで利用するにはSSLが必要になるが、localhostでは例外的に動作できる
 - また、SSLとSTUN/TURNサーバーを利用することで、インターネットでも動作可能
   - 安定して利用できるSTUN/TURNサーバーは限定されている
 - macOSであればiPhoneをカメラとして利用できるので、iPhoneアプリを制作した前提でテスト可能

## インストール

```console
$ pip install streamlit streamlit-webrtc
```

## 具体的なコード
 - 撮影している映像に特定のpng画像をオーバーレイして表示し、撮影ボタンで画像を保存できる例

```python
import streamlit as st
from streamlit_webrtc import webrtc_streamer
from streamlit_webrtc import VideoProcessorBase
import cv2
import av #strealing video library
from loguru import logger
import numpy as np

st.title('Streamlit App Test')
st.write('Gray Scale -> Color')

class VideoProcessor(VideoProcessorBase):
    def __init__(self) -> None:
        self.is_gray_state = None
        self.snapshot = False

        # image1の白色のピクセルを透明に変換する
        self.right_overray = cv2.imread('example_overray.png', cv2.IMREAD_UNCHANGED)
        white_pixels = np.all(self.right_overray[:, :, :3] == [255, 255, 255], axis=-1)
        self.right_overray[white_pixels, 3] = 0  # アルファチャンネルを0に設定

    def _add_overray(self, img):
        # 画像をoverrayする関数
        img_alpha = np.ones(img.shape[:2], dtype=img.dtype) * 255
        img = cv2.merge([img, img_alpha])
        height, width = img.shape[:2]

        rate = img.shape[:2][0] / self.right_overray.shape[:2][0]
        new_width = int(rate * self.right_overray.shape[1])
        right_overray = cv2.resize(self.right_overray, (new_width, height))

        # right_overrayの幅がimgの幅より大きい場合、imgの幅に合わせる
        if right_overray.shape[1] > width:
            right_overray = right_overray[:, :width]
        # right_overrayの幅がimgの幅より小さい場合、残りの部分を埋める
        elif right_overray.shape[1] < width:
            padding_left_width = (width - right_overray.shape[1]) // 2
            padding_right_width = width - right_overray.shape[1] - padding_left_width
            padding_left = np.zeros((height, padding_left_width, 4), dtype=img.dtype)
            padding_right = np.zeros((height, padding_right_width, 4), dtype=img.dtype)
            right_overray = np.hstack((padding_left, right_overray, padding_right))
        combined_image = np.where(right_overray[:, :, 3:4] != 0, right_overray, img)

        # アルファチャンネルを削除
        combined_image_rgb = combined_image[:, :, :3]
        vframe = av.VideoFrame.from_ndarray(combined_image_rgb, format='bgr24')

        return vframe

    def recv(self, frame: av.VideoFrame) -> av.VideoFrame:
        img = frame.to_ndarray(format = 'bgr24')
        
        if self.is_gray_state == True:
            img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
            vframe = av.VideoFrame.from_ndarray(img, format='gray')
        else:
            vframe = av.VideoFrame.from_ndarray(img, format='bgr24')

        # スナップショットボタンが押されたら画像を保存
        if self.snapshot:
            try:
                cv2.imwrite('output_image.png', img, [cv2.IMWRITE_PNG_COMPRESSION, 0])
            except Exception as exc:
                logger.exception(exc)
            self.snapshot = False

        try:
            vframe = self._add_overray(img)
        except Exception as exc:
            logger.exception(exc)

        return vframe

ctx = webrtc_streamer(key='example', video_processor_factory=VideoProcessor) # type: ignore

if ctx.video_processor:
    ctx.video_processor.is_gray_state = st.checkbox('Gray Scale -> Color ')
    if st.button("Snapshot"):
        ctx.video_processor.snapshot = True
```

## トラブルシューティング
 - インターネット環境下でカメラ機能が動作しない
   - 原因
      - STUN/TURNサーバーが利用できない・不安定である
   - 対応
      - [streamlit-webrtcの公式見解](https://github.com/whitphx/streamlit-webrtc#configure-the-turn-server-if-necessary)によると、twilioのSTUN/TURNサーバーを利用することを推奨している

## 参考
 - [Streamlit + Web Cam/Qiita](https://qiita.com/kotai2003/items/fe7dedd03ed049ac0265)
 - [ブラウザで動くリアルタイム画像/音声処理アプリをStreamlitでサクッと作る/zenn.dev](https://zenn.dev/whitphx/articles/streamlit-realtime-cv-app)
