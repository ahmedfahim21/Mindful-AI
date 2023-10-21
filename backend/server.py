from moviepy.editor import VideoFileClip
from Text_analysis import predict_depression
import json
import os
from flask import Flask, flash, request, redirect, url_for
from werkzeug.utils import secure_filename
import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage
from firebase_admin import firestore
import datetime

import urllib.request as req
import cv2
from firebase_admin import credentials, initialize_app, storage
# some_file.py
import sys
# caution: path[0] is reserved for script path (or '' in REPL)
sys.path.insert(1, 'emotion_model_using_wav_audio/')
sys.path.insert(2, 'emotion_model_using_video/')

from emotion_model_using_wav_audio import emotion_model_using_wav_audio
from emotion_model_using_video import emotion_model_using_video


cred = credentials.Certificate(
    r"mindful-ai-e0364-firebase-adminsdk-n5dcw-db5ff0f508.json")
initialize_app(cred, {'storageBucket': 'mindful-ai-e0364.appspot.com'})
bucket_name = "mindful-ai-e0364.appspot.com"


def convert_video_to_audio_moviepy(video_file, output_ext="wav"):
    """Converts video to audio using MoviePy library
    that uses `ffmpeg` under the hood"""
    filename, ext = os.path.splitext(video_file)
    clip = VideoFileClip(video_file)
    clip.audio.write_audiofile(f"{filename}.{output_ext}")


# set secret key
app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 50 * 1024 * 1024
app.secret_key = b'askjfoiwejrflksd'


@app.route('/upload', methods=['POST'])
def download_video():
    user_id = request.json['user_id']
    print("user id : " + user_id)
    source_blob_name = user_id + "/video.mp4"
    # The path to which the file should be downloaded
    destination_file_name = r"downloads/video.mp4"
    bucket = storage.bucket()
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)
    print("Blob {} downloaded to {}.".format(
        source_blob_name, destination_file_name))
    # convert video to audio
    convert_video_to_audio_moviepy(destination_file_name)
    # pass the audio file through the model
    res = emotion_model_using_wav_audio(destination_file_name[:-4] + ".wav")
    print(res)
    # convert float to int
    audio_emotions = {key: int(value*100) for key, value in res.items()}

    # make an array of the values
    audio_emotions = list(audio_emotions.values())

    audio_weights = [5, 1, 7, 5, 6, 6]
    audio_weights = [x/sum(audio_weights) for x in audio_weights]
    # multiply the values by the weights
    audio_emotions = [a*b for a, b in zip(audio_emotions, audio_weights)]
    print(audio_emotions)

    res = emotion_model_using_video(destination_file_name)
    res = res["average_emotions"]
    print(res)

    video_emotions = {key: int(value*100) for key, value in res.items()}

    print(video_emotions)
    
    video_emotions = list(video_emotions.values())

    video_weights = [7, 6, 6, 1, 5, 2]

    video_weights = [x/sum(video_weights) for x in video_weights]
    video_emotions = [a*b for a, b in zip(video_emotions, video_weights)]

    # add the two arrays
    audio_emotions = [a+b for a, b in zip(audio_emotions, video_emotions)]

    #round to nearest integer
    audio_emotions = [round(x) for x in audio_emotions]

    print(audio_emotions)

    audio_score = sum(audio_emotions)
    video_score = sum(video_emotions)

    # upload the result to firebase
    db = firestore.client()
    # update the emotion field of the document
    doc_ref = db.collection(u'students').document(user_id)
    # update scores and emotions
    doc_ref.update({
        u'emotions': audio_emotions,
    })
    doc_ref.update({
        u'audio_score': audio_score,
    })

    doc_ref.update({
        u'video_score': video_score,
    })

    # predict depression
    audio_file = destination_file_name[:-4] + ".wav"
	# Predict the depression level based on the transcript
    label, score = predict_depression(audio_file)    
    if label == "Depressed":
        doc_ref.update({
            u'depression': round(score * 100),
        })
    else:
        doc_ref.update({
            u'depression': 100 - round(score * 100),
        })

    # Return the result
    return "success"

