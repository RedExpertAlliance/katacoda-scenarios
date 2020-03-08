# Oracle Kubernetes Engine. Using the cluster
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

- Three (03) nodes
- VCN
- Internet Gateway
- NAT Gateway

Plus the option to provision Kubernetes Administration Dashboard, as well as Tiller.

# Scenario Pre-requisites

- For this scenario you need to finalize the scenario: https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1

- You need to execute the scenario https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation before trying this one. Because there
you will create the OCI compute instance that will server as a reverse proxy for your API Server. That scenario will give you an IP address that you will
use in this one.

- Kubectl and Kubernetes concepts are desirable to follow this scenario, but if you do not have it, you can follow it as well. 

- The user that you will use to manage the cluster using kubectl will be the tenant administration that you will get after provisioning your 30 days free
trial instance

- The user that we are going to use to publish the docker image into OCIR (Oracle Container Registry) is the lab-user created in the OCI Lab Preparation scenario


# Scenario Description

Once you have your cluster (Part 1 https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1) we will 
deploy an application based on Redis and Go. 

You will also learn:
- How to configure your Oracle Cloud Infrastructure Command Line Interface (OCI CLI) to create the Kubernetes config file in order to manage your cluster 
using kubectl
- How to register a Docker image within OCIR (Oracle Cloud Infrastructure Registry).
- How to configure a Load Balancer 
- How to deploy an application to the Cluster
- How to configure replicas for your application
- How to dinamically scale your replicas, based on CPU consumption
