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
    parser.add_argument("--average_delay", required=True, type=float, help="average time [in seconds, floating-point] to wait before sending a request")
    return parser.parse_args()

def get_normalized_delays(args):
    delays = []
    with open(args.trace_file, 'r') as f:
        for line in f:
            delays.append(float(line.strip()))

    avg_trace_val = 0
    for d in delays:
        avg_trace_val = avg_trace_val + d
    avg_trace_val = avg_trace_val / len(delays)
    
    scale_by = args.average_delay / avg_trace_val
    for i in range(len(delays)):
        delays[i] = delays[i] * scale_by
        
    return delays

def gen_request(args):
    jpeg_rgb = Image.open("./0005.jpg")
    jpeg_rgb = np.expand_dims(np.array(jpeg_rgb) / 255.0, 0).tolist()

    predict_request = json.dumps({'instances': jpeg_rgb})
    headers = {"Host": f"{args.service_host}", "Content-Type": "application/json"}
    url = f"http://{args.ingress_host}:80/v1/models/{args.model_name}:predict"
    return url, headers, predict_request
    
def send_request(url, headers, data):
    requests.post(url, headers=headers, data=data)

def main():
    args = get_args()
    delays = get_normalized_delays(args)
    url, headers, data = gen_request(args)
    
    for delay in delays:
        time.sleep(delay) # in seconds
        send_request(url, headers, data)
    
if __name__ == '__main__':
    main()
