#!/bin/bash

set -x # to test stderr output in /var/log/killercoda

ISTIO_VERSION="1.26.0"

echo "Starting Istio ${ISTIO_VERSION} installation..." # to test stdout output in /var/log/killercoda

cd /tmp
wget https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-amd64.tar.gz
tar xzf istio-${ISTIO_VERSION}-linux-amd64.tar.gz istio-${ISTIO_VERSION}/
mv istio-${ISTIO_VERSION}/bin/istioctl /usr/local/bin/

# Install minimal test setup
# See https://istio.io/latest/docs/setup/getting-started/#install
cd istio-${ISTIO_VERSION}/
istioctl install -f samples/bookinfo/demo-profile-no-gateways.yaml -y
echo "Istio installed."


echo "Creating demo resources..."
# Note: these are resources created in the mTLS migration example from Istio, without
# the Istio sidecar injection:
# https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/#set-up-the-cluster
kubectl create ns foo
kubectl apply -f samples/httpbin/httpbin.yaml -n foo
kubectl apply -f samples/curl/curl.yaml -n foo
kubectl create ns bar
kubectl apply -f samples/httpbin/httpbin.yaml -n bar
kubectl apply -f samples/curl/curl.yaml -n bar
echo "Created demo resources."

# TODO: step 1, inject istio sidecar in all deployments

touch /tmp/finished
