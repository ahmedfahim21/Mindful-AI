res = {'disgust': 7.323752e-24, 'happy': 2.1832814e-07, 'sad': 4.685986e-05,
       'neutral': 1.6110341e-10, 'fear': 0.000120439596, 'angry': 0.99983245}
# convert float to int

res_as_int = {key: int(value*100) for key, value in res.items()}


#make an array of the values
res_as_int = list(res_as_int.values())

print(res_as_int)
