import cv2
import numpy as np
from keras.models import model_from_json
# import matplotlib.pyplot as plt


emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}
num_emotions = 7

emotion_model_json_path = r'D:\coding\hackathon\Mindful-AI\backend\emotion_model_using_video\emotion_model.json'
emotion_model_path = r'D:\coding\hackathon\Mindful-AI\backend\emotion_model_using_video\emotion_model.h5'
haarcascade_frontalface_path = r'D:\coding\hackathon\Mindful-AI\backend\emotion_model_using_video\haarcascade_frontalface_default.xml'
# emotion_model_json_path = r'emotion_model.json'
# emotion_model_path = r'emotion_model.h5'
# haarcascade_frontalface_path = r'haarcascade_frontalface_default.xml'

def emotion_model_using_video(file_path,desired_fps=10):    

    json_file = open(emotion_model_json_path, 'r')
    loaded_model_json = json_file.read()
    json_file.close()
    emotion_model = model_from_json(loaded_model_json)


    emotion_model.load_weights(emotion_model_path)
    # print("Loaded model from disk")

    emotion_data = []
    cap = cv2.VideoCapture(file_path)  


    emotion_counts = {emotion: 0 for emotion in emotion_dict.values()}
    total_faces_detected = 0
    detect=[] 
    frame_count = 0   
    
    
    
    while True:
        
        ret, frame = cap.read()
        if not ret:
            break

        frame_count += 1
        if frame_count % (int(cap.get(cv2.CAP_PROP_FPS)) // desired_fps) != 0:
            continue
        
        face_detector = cv2.CascadeClassifier(haarcascade_frontalface_path)
        gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        
        num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)

        for (x, y, w, h) in num_faces:
            # cv2.rectangle(frame, (x, y-50), (x+w, y+h+10), (255, 0, 0), 2)
            roi_gray_frame = gray_frame[y:y + h, x:x + w]
            cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)

            
            emotion_prediction = emotion_model.predict(cropped_img)
            detect.append(emotion_prediction)
            maxindex = int(np.argmax(emotion_prediction))
            detected_emotion = emotion_dict[maxindex]         
            
            
            
            
            
            emotion_counts[detected_emotion] += 1  
            total_faces_detected += 1
            emotion_data.append(emotion_prediction[0])  

            # cv2.putText(frame, detected_emotion, (x+20, y-60), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 0), 2, cv2.LINE_AA)
        
        
        
        


    cap.release()
    cv2.destroyAllWindows()

    output = {'average_emotions': {}, 'all_emotions': []}


    if total_faces_detected > 0:
        
        average_emotions = {emotion: (count / total_faces_detected)  
                            for emotion, count in emotion_counts.items()}
        
        output['average_emotions'] = average_emotions   

        if emotion_data:
            
            # emotion_data = np.array(emotion_data)
            # print(emotion_data)
            # plt.plot(emotion_data)
            # plt.show()
            # all_emotions = []
            # for i in range(num_emotions):
            #     all_emotions.append(emotion_data[:,i])  
            # output['all_emotions'] = all_emotions
            output['all_emotions'] = emotion_data


        else:
            print("No emotion data was collected from the video.")
        return output
    else:
        
        return {}    
        
        
        
            
# res = emotion_model_using_video(r"D:\coding\hackathon\Mindful-AI\backend\downloads\video.mp4")            
# print(res)

# videoModel("video/dilshad2.mp4" )

