# Oracle Kubernetes Engine (OKE). Using the cluster
INTRO

Oracle Kubernetes Engine is the Oracle offering for a Kubernetes cluster. It is a pure Kubernetes offering with integration with the Oracle Cloud Infrastructure 
components, such as:

- Load Balancer
- OCI Compute
- OCI Storage
- OCI Network
- OCI Security

If you are an Oracle Cloud Infrastructure customer that is looking for an alternative to deploy Kubernetes, OKE is a good option for that. You can use the 
Quick Create option, and in less than 20 minutes you will have a full Kubernetes cluster formed by:

- Three (3) nodes
- VCN
- Internet Gateway
- NAT Gateway

Plus the option to provision Kubernetes Administration Dashboard, as well as Tiller.

# Scenario Pre-requisites

- For this scenario you need to finalize the scenario: https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1

- You need to execute the scenario https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-api-server-reverse-proxy before trying this one. Because there
you will create the OCI compute instance that will server as a reverse proxy to connect the Katacoda environment (through standard port 443) to the Kubernetes cluster (that listens at port 6443). That scenario will give you an IP address (for the NGINX server) that you will
use in this one to make kubectl connect to.

- Some understanding of *kubectl* and Kubernetes concepts are desirable in order to follow this scenario, but if you do not yet have those, you can follow it as well. 

- The user that you will use to manage the cluster using kubectl will be the tenant administrator that you will get after provisioning your 30 days free
trial instance

- The user that we are going to use to publish the docker image into OCIR (Oracle Container Registry) is your tenant administrator created in the OCI Lab Preparation scenario


# Scenario Description

Once you have your cluster (Part 1 https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1) we will 
deploy an application based on Redis and Go. It consists of two Pods - each with a single container. One based on the standard *Redis container image* and the other one on a custom container image with a Go application. 

You will also learn:
- How to configure your Oracle Cloud Infrastructure Command Line Interface (OCI CLI) to create the Kubernetes config file in order to manage your cluster 
using kubectl
- How to push a Docker image to OCIR (Oracle Cloud Infrastructure Registry).
- How to configure a Load Balancer on the Kubernetes Cluster for external services access
- How to deploy an application to the K8S Cluster
- How to publish the application through a K8S Service - to make it accessible outside the cluster 
- How to configure replicas for your application - to make it scale out to multiple pod-instances
- How to dynamically scale your replicas, based on CPU consumption
