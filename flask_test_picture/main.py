import io
from PIL import Image
from flask import Flask, request, send_file, jsonify
from minio import Minio
from minio.error import S3Error

app = Flask(__name__)

# MinIO server details
minio_endpoint = "84.201.134.49:9000"
minio_access_key = "minio"
minio_secret_key = "minio124"
minio_bucket_name = "test"

# Initialize MinIO client
minio_client = Minio(minio_endpoint,
                     access_key=minio_access_key,
                     secret_key=minio_secret_key,
                     secure=False)  # Set to True if MinIO server uses HTTPS

# API endpoint to upload a picture to MinIO
@app.route("/upload", methods=["POST"])
def upload_picture():
    try:
        # Get the uploaded file
        file = request.files["file"]
        
        # Check if the file is empty or corrupted
        if file.filename == '':
            return "No selected file", 400

        # Save the file to MinIO bucket
        print(file, len(file.read()))

        minio_client.put_object(minio_bucket_name, file.filename, file, length=100,
                                content_type=file.content_type)

        return "File uploaded successfully!"
    except S3Error as e:
        return str(e), 500

# API endpoint to download a picture from MinIO
@app.route("/download/<filename>", methods=["GET"])
def download_picture(filename):
    try:
        # Get the file from MinIO bucket
        file_data = minio_client.get_object(minio_bucket_name, filename)

        # Create a temporary file to store the downloaded file
        temp_file_path = f"/tmp/{filename}"
        with open(temp_file_path, "wb") as temp_file:
            for data in file_data.stream(32 * 1024):
                temp_file.write(data)

        # Return the downloaded file
        return send_file(temp_file_path, as_attachment=True)

    except S3Error as e:
        return str(e), 500
    
@app.route("/view/<filename>", methods=["GET"])
def view_picture(filename):
    try:
        # Get the file from MinIO bucket
        file_data = minio_client.get_object(minio_bucket_name, filename)

        # Create a temporary file to store the downloaded file
        temp_file_path = f"/tmp/{filename}"
        with open(temp_file_path, "wb") as temp_file:
            for data in file_data.stream(32 * 1024):
                temp_file.write(data)

        # Return the downloaded file
        return send_file(temp_file_path, as_attachment=False)

    except S3Error as e:
        return str(e), 500
    
@app.route("/return_ok", methods=["GET"])
def return_ok():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=9988)