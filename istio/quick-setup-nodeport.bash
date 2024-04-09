#!/usr/bin/env bash

INGRESS_NS=istio-ingress
INGRESS_NAME=istio-ingressgateway

export INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export TCP_INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')

echo "INGRESS_PORT=${INGRESS_PORT}"
echo "SECURE_INGRESS_PORT=${SECURE_INGRESS_PORT}"
echo "TCP_INGRESS_PORT=${TCP_INGRESS_PORT}"