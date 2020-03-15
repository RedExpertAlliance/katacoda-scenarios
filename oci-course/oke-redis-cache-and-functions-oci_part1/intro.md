# Oracle Kubernetes Engine - Create an OKE Cluster.
INTRO

This scenario is the first part of two. In this scenario you will provision a Kubernetes Engine on Oracle Cloud Infrastructure and in the second part you will start using it.
The second part scenario is here: https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part2

Oracle Kubernetes Engine is the Oracle offering for a Kubernetes cluster. It is a pure Kubernetes offering with integration with the Oracle Cloud Infrastructure 
components, such as:

- Load Balancer
- OCI Compute
- OCI Storage
- OCI Network
- OCI Security

If you are an Oracle Cloud Infrastructure customer that is looking for a solution to deploy Kubernetes, OKE is a good option for that. You can use the 
Quick Create option, and in less than 20 minutes you will have a full Kubernetes cluster formed by:

- Three (3) nodes
- VCN
- Internet Gateway
- NAT Gateway

Plus the option to provision Kubernetes Administration Dashboard, as well as Tiller into the Kubernetes cluster.

# Scenario Pre-requisites

- For this scenario you need to have a 30 days Free Oracle Cloud Infrastructure Trial (or of course a paid account). If you have it, you are ready to go. If not, please follow this instruction
to provision your trial: https://docs.oracle.com/en/cloud/get-started/subscriptions-cloud/csgsg/request-trial-subscription.html

- Some understanding of *kubectl* and Kubernetes concepts are desirable in order to follow this scenario, but if you do not yet have those, you can follow it as well. 

- You need to execute the scenario https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation before trying this one.

- The user that you will use to manage the cluster using kubectl will be the tenant administrator that you will get after provisioning your 30 days free
trial instance - or at least a user in the Administrators group.

- The user that we are going to use to publish the docker image into OCIR (Oracle Container Registry) is the *lab-user* created in the OCI Lab Preparation scenario


# Scenario Description

In this scenario you will learn how to provision an Oracle Kubernetes Engine using the Quick Create Option.
We will use the Oracle OCI Web Console to provision our cluster. Most of the steps will be performed using the Web Console.
We will also configure our kube config file to connect to our cluster using the *kubectl* command line interface for managing a Kubernetes cluster. Once created the kube config file, we will extract the hostname of the
Kubernetes API server and will use that information to configure a reverse proxy in order to connect to it. 

Note: this reverse proxy is required in our case because of a current limitation in Katacoda environments: from these environments, we cannot connect to the port (6443) at which the Kubernetes cluster is accessible; the proxy server is a workaround for this limitation. The proxy server listens to our requests at port 443 - accessible from Katacoda - and forwards these requests to the Kubernetes cluster at port 6443.