# Create Policies to allow access on Lab Compartment 

Policies in OCI are used to define permissions - rules about accessing resources or capabilities. In this step, you will create a few policies that allow the Functions service to access repositories and to use the Virtual Cloud Network in the *lab-compartment*. An additional policy is created to provide necessary access privileges to dynamic group *lab-apigw-dynamic-group* (and indirectly to the API Gateway); this access is limited to *lab-compartment* (the functions and virtual network in the compartment)

## Policies to enable the Functions Services. Policies to manage OKE, Events, Notifications & Compute Instances 

Run this command to create two policies for the Functions service with regard to the Lab Compartments network and the Function Repos in the OCI container registry
```
echo creating policy lab-faas-use-network-family
oci iam policy create  --name lab-faas-use-network-family --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Network Resources"

echo creating policy lab-faas-read-repos
oci iam policy create  --name lab-faas-read-repos --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to read repos in tenancy\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Repositories in Oracle Cloud Infrastructure Registry"
```{{execute}}


## Policies to enable API Gateway

The next policy provides necessary access privileges to dynamic group *lab-apigw-dynamic-group* (and indirectly to the API Gateway dynamically included in that group). This access is limited to *lab-compartment* (the functions and virtual network in the compartment).

```
oci iam policy create  --name "dyn-group-gateway-access-lab-compartment" --compartment-id $compartmentId  --statements "[ \"allow dynamic-group lab-apigw-dynamic-group to use virtual-network-family in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to manage public-ips in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to use functions-family in compartment lab-compartment\"]" --description "to allow lab apigw dynamic group access to lab-compartment"
```{{execute}}


## Policies to manage Compute Instances 

Run this command to create two policies for managing Compute Instances
```
echo creating policy lab-faas-use-network-family
oci iam policy create  --name lab-compute-manage-instance-family --compartment-id $TENANCY_OCID  --statements "[ \"Allow group lab-participants to manage instance-family in compartment lab-compartment\"]"  --description "Create a Policy to manage instances"

echo creating policy lab-faas-read-repos
oci iam policy create  --name lab-compute-manage-virtual-network-family --compartment-id $TENANCY_OCID  --statements "[ \"Allow group lab-participants to manage virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to manage virtual network family"
```{{execute}}


## Policies to manage OKE 

Run this command to create a policy for managing OKE
```
echo creating policy lab-oke-manage-cluster-family
oci iam policy create  --name lab-compute-manage-instance-family --compartment-id $TENANCY_OCID  --statements "[ \"Allow group lab-participants to manage cluster-family in compartment lab-compartment\"]"  --description "Create a Policy to manage cluster family"
```{{execute}}


## Policies to manage Events and Notifications

Run this command to create a set of policies for managing ons-topics, cloudevents, streaming
```
echo creating policy lab-manage-ons-topics
oci iam policy create  --name lab-manage-ons-topics --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to manage ons-topics in compartment lab-compartment\"]"  --description "Create a Policy to manage ons-topics"

echo creating policy lab-inspect-compartments
oci iam policy create  --name lab-inspect-compartments --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to inspect compartments in compartment lab-compartment\"]"  --description "Create a Policy to inspect compartments"

echo creating policy lab-use-tag-namespaces
oci iam policy create  --name lab-use-tag-namespaces --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to use tag-namespaces in compartment lab-compartment\"]"  --description "Create a Policy to use tag-namespaces"

echo creating policy lab-inspect-streams
oci iam policy create  --name lab-inspect-streams --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to inspect streams in compartment lab-compartment\"]"  --description "Create a Policy to inspect streams"

echo creating policy lab-use-stream-push
oci iam policy create  --name lab-use-stream-push --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to use stream-push in compartment lab-compartment\"]"  --description "Create a Policy to use stream-push"

echo creating policy lab-use-stream-pull
oci iam policy create  --name lab-use-stream-pull --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to use stream-pull in compartment lab-compartment\"]"  --description "Create a Policy to use stream-pull"

echo creating policy lab-use-virtual-network-family
oci iam policy create  --name lab-use-virtual-network-family --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to use virtual-network-family"

echo creating policy lab-manage-functions
oci iam policy create  --name lab-manage-functions --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to manage function-family in compartment lab-compartment\"]"  --description "Create a Policy to manage function-family"

echo creating policy lab-use-ons-topic
oci iam policy create  --name lab-use-ons-topic --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to use ons-topic in compartment lab-compartment\"]"  --description "Create a Policy to use ons-topic"

echo creating policy lab-manage-cloudevents
oci iam policy create  --name lab-manage-cloudevents --compartment-id $TENANCY_OCID  --statements "[ \"allow group lab-participants to manage cloudevents-rules in compartment lab-compartment\"]"  --description "Create a Policy to manage cloudevents-rules"
```{{execute}}
