# Create Policies

Create policies to allow services to make use of resources in specific compartments 

## Functions (FaaS) Policies

Prepare some environment variables
```
FN_MANAGE_APP_POLICY=lab-app-management
FN_GROUP_USE_VCN_POLICY=lab-group-use-network-family
FN_FAAS_USE_VCN_POLICY=lab-faas-use-network-family
FN_FAAS_READ_REPOS_POLICY=lab-faas-read-repos

echo creating policy $FN_FAAS_USE_VCN_POLICY
oci iam policy create  --name $FN_FAAS_USE_VCN_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Network Resources"

echo creating policy $FN_FAAS_READ_REPOS_POLICY
oci iam policy create  --name $FN_FAAS_READ_REPOS_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to read repos in tenancy\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Repositories in Oracle Cloud Infrastructure Registry"

```{{execute}}


## Policies on API Gateway

Policy: to allow lab apigw dynamic group access to lab-compartment
https://console.us-ashburn-1.oraclecloud.com/a/identity/policies
dyn-group-gateway-access-lab-compartment

```
oci iam policy create  --name "dyn-group-gateway-access-lab-compartment" --compartment-id $compartmentId  --statements "[ \"allow dynamic-group lab-apigw-dynamic-group to use virtual-network-family in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to manage public-ips in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to use functions-family in compartment lab-compartment\"]" --description "to allow lab apigw dynamic group access to lab-compartment"
```{{execute}}


