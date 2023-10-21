audio_file=r"D:\coding\hackathon\Mindful-AI\backend\downloads\video.wav"
# audio_file=r"downloads/video.wav"

import speech_recognition as sr
from transformers import pipeline
import torch
import sys
model_name = "sanskar/DepressionAnalysis"
classifier = pipeline("text-classification", model=model_name)

def transcribe_audio(audio_file):
    # Initialize the recognizer
    recognizer = sr.Recognizer()

    # Open and read the audio file
    with sr.AudioFile(audio_file) as source:
        audio_data = recognizer.record(source)

    try:
        # Recognize the audio using the Google Web Speech API
        transcribed_text = recognizer.recognize_google(audio_data)
        return transcribed_text
    except sr.UnknownValueError:
        print("Speech API could not understand the audio.")
        return ""
    except sr.RequestError as e:
        print("Could not request results from Google Web Speech API; {0}".format(e))
        return ""
    
    
    



def predict_depression(audio_file):
    """
    Function to make a prediction on the provided transcript.
    """
    transcript= transcribe_audio(audio_file)
    if(transcript == ""):
        return "Depressed",0
    # Make a prediction
    results = classifier(transcript)

    # Extract the label and score from the results
    label = results[0]['label']
    score = results[0]['score']

    # Return the results
    return label, score




# Predict the depression level based on the transcript
label, score = predict_depression(audio_file)






