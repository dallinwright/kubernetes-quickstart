# Knative

## Overview

Knative is a Kubernetes-based platform to build, deploy, and manage modern serverless workloads. It provides a set of middleware components that are essential to build modern, source-centric, and container-based applications that can run anywhere in an event-based architecture on kubernetes: on premises, in the cloud, or even in a third-party data center.

Unfortunately however it does not provide a helm chart for installation, so we will use the official installation guide and the production ready operator tool to install.

## Prerequisites

Current installation instructions are here on the office site: [Knative Installation](https://knative.dev/docs/install/)

Note that the installation forcefully sets the namespace to `default` thus ignoring user attempts to isolate/override it.


### Install Istio

### Install operator
kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.13.3/operator.yaml

### Install Knative Serving

```bash
kubectl apply -f knative/serving.yaml
```