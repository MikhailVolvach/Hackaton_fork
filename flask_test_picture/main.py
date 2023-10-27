from flask import Flask, request, send_file
from io import BytesIO
from minio import Minio
from minio.error import MinioException

app = Flask(__name__)

# Minio configuration
MINIO_ENDPOINT = '84.201.134.49:9000'
MINIO_ACCESS_KEY = 'minio'
MINIO_SECRET_KEY = 'minio124'
MINIO_BUCKET_NAME = 'test'

# Create a Minio client
minio_client = Minio(MINIO_ENDPOINT,
                     access_key=MINIO_ACCESS_KEY,
                     secret_key=MINIO_SECRET_KEY,
                     secure=False)  # Set secure to True if your Minio server uses HTTPS

def upload_image_to_minio(image_data, object_name, content_type):
    try:
        minio_client.put_object(bucket_name=MINIO_BUCKET_NAME,
                                object_name=object_name,
                                data=BytesIO(image_data),
                                length=len(image_data),
                                content_type=content_type)
        return True
    except MinioException as err:
        print(err)
        return False

def get_image_from_minio(object_name):
    try:
        image_data = minio_client.get_object(bucket_name=MINIO_BUCKET_NAME,
                                             object_name=object_name).read()
        return image_data
    except MinioException as err:
        print(err)
        return None

@app.route('/upload', methods=['POST'])
def upload_image():
    file = request.files['file']
    object_name = file.filename
    content_type = file.content_type
    image_data = file.read()

    if upload_image_to_minio(image_data, object_name, content_type):
        return "Image uploaded successfully to Minio."
    else:
        return "Failed to upload image to Minio."

@app.route('/view/<object_name>', methods=['GET'])
def get_image(object_name):
    image_data = get_image_from_minio(object_name)
    if image_data:
        return send_file(BytesIO(image_data), mimetype='image/jpeg')
    else:
        return "Image not found."
    

@app.route('/download/<object_name>', methods=['GET'])
def download_image(object_name):
    image_data = get_image_from_minio(object_name)
    if image_data:
        return send_file(BytesIO(image_data), mimetype='image/jpeg', as_attachment=True, download_name=f"{object_name}")
    else:
        return "Image not found."

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9988)
