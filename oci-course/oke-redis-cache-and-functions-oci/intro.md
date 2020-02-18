# Oracle Kubernetes Engine
INTRO

Oracle Kubernetes Engine is the Oracle offering for a Kubernetes cluster. It is a pure Kubernetes offering with integration with the Oracle Cloud Infrastructure 
components, such as:

- Load Balancer
- OCI compute
- OCI storage
- OCI Network
- OCI Security

If you are an Oracle Cloud Infrastructure customer that is looking for an alternative to deploy Kubernetes, OKE is a good option for that. You can use the 
Quick Create option, and in less than 10 minutes you will have a full Kubernetes cluster formed by:

- Three (03) nodes
- VCN
- Internet Gateway
- NAT Gateway

Plus the option to provision Kubernetes Administration Dashboard, as well as Tiller.

# Scenario Pre-requisites

For this scenario you need to have a 30 days Free Oracle Cloud Infrastructure Trial. If you have it, you are ready to go. If not, please follow this
to provision your trial: https://docs.oracle.com/en/cloud/get-started/subscriptions-cloud/csgsg/request-trial-subscription.html

Kubectl and Kubernetes concepts are desirable to follow this scenario, but if you do not have it, you can follow it as well. 

# Scenario Description

In this scenario you will learn how to provision an Oracle Kubernetes Engine using the Quick Create Option.
Once you have your cluster we will deploy an application based on Redis and Go.
You will also learn:

- How to configure your Oracle Cloud Infrastructure Command Line Interface (OCI CLI) to create the Kubernetes config file in order to manage your cluster 
using kubectl
- How to register a Docker image within OCIR (Oracle Cloud Infrastructure Registry).
- How to configure a Load Balancer 
- How to deploy an application to the Cluster
- How to configure replicas for your application
- How to dinamically scale your replicas, based on CPU consumption
