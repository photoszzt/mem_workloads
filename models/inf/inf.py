import requests
import base64
import argparse
import json
import numpy as np
from PIL import Image

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--ingress_host", required=True)
    parser.add_argument("--service_host", required=True)
    parser.add_argument("--model_name", required=True)
    args = parser.parse_args()
    # Compose a JOSN Predict request (send the image tensor).
    jpeg_rgb = Image.open("./0005.jpg")
    # Normalize and batchify the image
    jpeg_rgb = np.expand_dims(np.array(jpeg_rgb) / 255.0, 0).tolist()
    predict_request = json.dumps({'instances': jpeg_rgb})

    # with open("./0005.jpg", "rb") as image_file:
    #     encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
    # payload={"instances": [{"image_bytes": {"b64": encoded_string}}]}
    # request_body = json.dumps(payload)
    # print(request_body)
    headers = {"Host": f"{args.service_host}", "Content-Type": "application/json"}
    url = f"http://{args.ingress_host}:80/v1/models/{args.model_name}:predict"
    r = requests.post(url, headers=headers, data=predict_request)
    prediction = r.json()['predictions'][0]
    print(f'Prediction class: {np.argmax(prediction)}')


if __name__ == '__main__':
    main()
