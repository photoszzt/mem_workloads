import requests
import base64
import argparse
import json
import numpy as np
from PIL import Image
import time

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--ingress_host", required=True)
    parser.add_argument("--service_host", required=True)
    parser.add_argument("--model_name", required=True)
    parser.add_argument("--trace_file", required=True)
    parser.add_argument("--image_file", required=True)
    return parser.parse_args()

def get_delays():
    delays = []
    with open(args.trace_file, 'r') as f:
        for line in f:
            delays.append(float(line.strip()))
    return delays

def make_request(args):
    # Compose a JOSN Predict request (send the image tensor).
    jpeg_rgb = Image.open("./0005.jpg")
    # Normalize and batchify the image
    jpeg_rgb = np.expand_dims(np.array(jpeg_rgb) / 255.0, 0).tolist()

    predict_request = json.dumps({'instances': jpeg_rgb})
    headers = {"Host": f"{args.service_host}", "Content-Type": "application/json"}
    url = f"http://{args.ingress_host}:80/v1/models/{args.model_name}:predict"
    r = requests.post(url, headers=headers, data=predict_request)
    # prediction = r.json()['predictions'][0]
    # print(f'Prediction class: {np.argmax(prediction)}')

def main():
    SCALE_FACTOR = 100
    
    args = get_args()
    delays = get_delays(args)
    for delay in delays:
        # print(f'sleeping for {SCALE_FACTOR * delay}s')
        time.sleep(SCALE_FACTOR * delay) # in seconds
        make_request()
    
if __name__ == '__main__':
    main()
