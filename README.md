# Kubernetes Cluster Setup Quick Start Guide

## Prerequisites

You need a Kubernetes cluster, either local or remote. You can use the default Docker Desktop Kubernetes cluster,
or a cloud provider like AWS, GCP, Azure, Scaleway, etc.

**Tools installed and available via your terminal**

- [docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [helm](https://helm.sh/docs/intro/install/)

**Optional for visual cluster interaction and information**

- [k9s](https://k9scli.io/)

All these tools will provide you the baseline required to interact with your cluster.

## Steps


For access into your cluster from outside, for example to call an API for your service, you need to set up an Ingress
Controller.
We will use [Ambassador](https://www.getambassador.io/) as it uniquely provides development capabilities not found in
other ingress controllers along with a generous open source feature offering.

[Cluster Ingress Setup](emissary-ingress/README.md)

For certificate management of various resources inside the cluster, for example to enable HTTPS for your service,
you need to set up a Certificate Manager. We use a free, open source, automated, and Kubernetes-native
certificate manager called [cert-manager](https://cert-manager.io/).

[Cluster Certificate Management](./cert-manager/README.md)

When developing it is critical to know what is actually happening in the cluster, from usage, logs, traces, and to
be able to replicate your deployment no matter the environment. We use grafana cloud which has also a generous free
tier and their baseline offering is open source. Another great option, especially for the enterprise, is DataDog.
Note that it is called Observability as it is more than just monitoring, it is a collection of telemetry configurations.

[Observability Setup](grafana/README.md)
