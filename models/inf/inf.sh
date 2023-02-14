#!/bin/bash
MODEL_NAME="${1:-resnet50v2tf}"

# INPUT_PATH=@./input.json
INGRESS_HOST=$(kubectl get svc istio-ingressgateway --namespace istio-system -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
INGRESS_PORT=80
SERVICE_HOSTNAME=$(kubectl get inferenceservice ${MODEL_NAME} -o jsonpath='{.status.url}' | cut -d "/" -f 3)
python3 inf.py --ingress_host ${INGRESS_HOST} --service_host ${SERVICE_HOSTNAME} --model_name ${MODEL_NAME}
# curl -v -H "Host: ${SERVICE_HOSTNAME}" "http://${INGRESS_HOST}:${INGRESS_PORT}/v1/models/$MODEL_NAME:predict" -d $INPUT_PATH
