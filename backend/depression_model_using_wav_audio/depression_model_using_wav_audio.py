import pandas as pd
import numpy as np
import joblib
import librosa
from tensorflow.keras.models import load_model
from sklearn.preprocessing import StandardScaler
import keras
model_path_json = r'D:\coding\hackathon\Mindful-AI\backend\depression_model_using_wav_audio\depression_model_using_wav_audio.json'  
model_path = r'D:\coding\hackathon\Mindful-AI\backend\depression_model_using_wav_audio\depression_model_using_wav_audio.h5'  
path_of_wav_audio_file=r'D:\coding\hackathon\Mindful-AI\backend\downloads\video.wav'
path_of_scaler_filename=r'D:\coding\hackathon\Mindful-AI\backend\depression_model_using_wav_audio\scaler_filename_dep.pkl'


def depression_model_using_wav_audio(path):
  def noise(data):
    noise_amp = 0.035*np.random.uniform()*np.amax(data)
    data = data + noise_amp*np.random.normal(size=data.shape[0])
    return data

  def stretch(data, rate=0.8):
      return librosa.effects.time_stretch(y=data, rate=rate)


  def shift(data):
      shift_range = int(np.random.uniform(low=-5, high = 5)*1000)
      return np.roll(data, shift_range)

  def pitch(data, sampling_rate, n_steps=0.7):  # Changed pitch_factor to n_steps for clarity
      return librosa.effects.pitch_shift(y=data, sr=sampling_rate, n_steps=n_steps)


  def extract_features(data,sample_rate):
      # ZCR
      result = np.array([])
      zcr = np.mean(librosa.feature.zero_crossing_rate(y=data).T, axis=0)
      result=np.hstack((result, zcr)) # stacking horizontally

      # Chroma_stft
      stft = np.abs(librosa.stft(data))
      chroma_stft = np.mean(librosa.feature.chroma_stft(S=stft, sr=sample_rate).T, axis=0)
      result = np.hstack((result, chroma_stft)) # stacking horizontally

      # MFCC
      mfcc = np.mean(librosa.feature.mfcc(y=data, sr=sample_rate).T, axis=0)
      result = np.hstack((result, mfcc)) # stacking horizontally

      # Root Mean Square Value
      rms = np.mean(librosa.feature.rms(y=data).T, axis=0)
      result = np.hstack((result, rms)) # stacking horizontally

      # MelSpectogram
      mel = np.mean(librosa.feature.melspectrogram(y=data, sr=sample_rate).T, axis=0)
      result = np.hstack((result, mel)) # stacking horizontally
      
      return result

  def get_features(path):
      # duration and offset are used to take care of the no audio in start and the ending of each audio files as seen above.
      data, sample_rate = librosa.load(path, duration=2.5, offset=0.6)
      
      # without augmentation
      res1 = extract_features(data,sample_rate)
      result = np.array(res1)
      
      # data with noise
      noise_data = noise(data)
      res2 = extract_features(noise_data,sample_rate)
      result = np.vstack((result, res2)) # stacking vertically
      
      # data with stretching and pitching
      new_data= stretch(data)
      data_stretch_pitch = pitch(new_data, sample_rate)
      res3 = extract_features(data_stretch_pitch,sample_rate)
      result = np.vstack((result, res3)) # stacking vertically
      
      return result

  X= []
  features = get_features(path)

  for feature in features:
      X.append(feature)
  Features = pd.DataFrame(X)
  scaler = joblib.load(path_of_scaler_filename)
  x_test = scaler.transform(Features)
  x_test = np.expand_dims(x_test, axis=2) 

  from keras.models import model_from_json
  with open(model_path_json, "r") as json_file:
      model_json = json_file.read()
  model = model_from_json(model_json)
  model.load_weights(model_path)
  
  pred_test = model.predict(x_test)
  Threshold=0.29
  if(pred_test[0]>= Threshold):
      return 1
  else:
      return 0
      




res = depression_model_using_wav_audio(path_of_wav_audio_file)
print(res)
    




