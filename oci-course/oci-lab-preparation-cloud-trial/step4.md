# Create Policies to allow access on Lab Compartment 

Policies in OCI are used to define permissions - rules about accessing resources or capabilities. In this step, you will create a few policies that allow the Functions service to access repositories and to use the Virtual Cloud Network in the *lab-compartment*. An additional policy is created to provide necessary access privileges to dynamic group *lab-apigw-dynamic-group* (and indirectly to the API Gateway); this access is limited to *lab-compartment* (the functions and virtual network in the compartment)

## Policies to enable the Functions Services 

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


