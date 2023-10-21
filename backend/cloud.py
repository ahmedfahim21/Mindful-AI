from firebase_admin import credentials, initialize_app, storage

cred = credentials.Certificate(r"mindful-ai-e0364-firebase-adminsdk-n5dcw-db5ff0f508.json")
initialize_app(cred, {'storageBucket': 'mindful-ai-e0364.appspot.com'})
bucket_name = "mindful-ai-e0364.appspot.com"

def download_video(user_id):

    source_blob_name = user_id + "/video.mp4"
    #The path to which the file should be downloaded
    destination_file_name = r"downloads/video.mp4"
    bucket = storage.bucket()
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)

    print("Blob {} downloaded to {}.".format(source_blob_name, destination_file_name))


download_video('fjweljflsdkjfslkd')


# doc = {
#     'name': 'Los Angeles',
#     'state': 'CA',
#     'country': 'USA',
#     'more' : {
#         'population': 3976000,
#         'region': 'Southern California',
#         'list': [[12],2],
#     }
# }