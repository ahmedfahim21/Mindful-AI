
import sys
from moviepy.editor import VideoFileClip
from Text_analysis import predict_depression
import os
import statistics
sys.path.insert(1, 'emotion_model_using_wav_audio/')
sys.path.insert(2, 'emotion_model_using_video/')
sys.path.insert(3, 'emotion_model_using_wave_audio/')
from emotion_model_using_wav_audio import emotion_model_using_wav_audio
from emotion_model_using_video import emotion_model_using_video
from depression_model_using_wav_audio import depression_model_using_wav_audio
from flask import Flask, flash, request
from firebase_admin import credentials
from firebase_admin import storage
from firebase_admin import firestore
from firebase_admin import credentials, initialize_app, storage
# some_file.py
# caution: path[0] is reserved for script path (or '' in REPL)



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
    audio_emotions = {key: (value) for key, value in res.items()}

    # {'disgust': 0.91542405, 'happy': 0.05960697, 'sad': 7.4444124e-08,
    #     'neutral': 0.024968872, 'fear': 1.7846921e-09, 'angry': 1.2755274e-13}

    audio_emotions = [audio_emotions['angry'], audio_emotions['disgust'], audio_emotions['fear'],
                      audio_emotions['happy'], audio_emotions['neutral'], audio_emotions['sad'],0]

    # audio_weights = [5, 1, 7, 5, 6, 6, 0]
    audio_weights = [6, 5, 7, 1, 3, 7, 0]
    audio_sum = sum(audio_weights)
    audio_weights = [x/audio_sum for x in audio_weights]
    # multiply the values by the weights
    audio_emotions = [a*b for a, b in zip(audio_emotions, audio_weights)]
    print(audio_emotions)

    res = emotion_model_using_video(destination_file_name)
    res = res["average_emotions"]
    print(res)

    video_res = {key: (value) for key, value in res.items()}

    print(video_res)

    # {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}

    video_emotions = [video_res['Angry'], video_res['Disgusted'], video_res['Fearful'],
                      video_res['Happy'], video_res['Neutral'], video_res['Sad'], video_res['Surprised']]

    print(video_emotions)

    video_weights = [0.205, 0.176, 0.176, 0.029, 0.147, 0.205, 0.058]
    
    print(video_weights)

    video_emotions_final = []
    for i in range(7):
        video_emotions_final.append(video_emotions[i]*video_weights[i])

    print(video_emotions_final)

    # # add the two arrays
    audio_emotions = [(a * 0.6)+(b * 0.4) for a, b in zip(audio_emotions, video_emotions)]


    print(audio_emotions)

    audio_score = statistics.mean(audio_emotions) * 100
    video_score = statistics.mean(video_emotions) * 100


    # round to nearest integer
    audio_emotions = [round(x * 100) for x in audio_emotions]

    #audio wave prediction
    wavPrediction = depression_model_using_wav_audio.depression_model_using_wav_audio(destination_file_name[:-4] + ".wav")
    print("wavPrediction : ",wavPrediction)
    emo_score = audio_score * 0.6 + video_score * 0.4


    # # upload the result to firebase
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

    doc_ref.update({
        u'wave_score': wavPrediction,
    })

    # predict depression
    audio_file = destination_file_name[:-4] + ".wav"
    # Predict the depression level based on the transcript
    label, score = predict_depression(audio_file)
    if label == "Depressed":
        doc_ref.update({
            u'transcript_score': round(score * 100),
        })
    else:
        doc_ref.update({
            u'transcript_score': 100 - round(score * 100),
        })

    if label == "Depressed" and score > 0.5:
        doc_ref.update({
            u'status': 'Risky',
        })
    else:
        doc_ref.update({
            u'status': 'Healthy',
        })


    depression = emo_score * 0.4 + score * 0.6
    print("depression : ",depression)

    doc_ref.update({
        u'depression': depression,
    })

    # Return the result
    return "success"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
