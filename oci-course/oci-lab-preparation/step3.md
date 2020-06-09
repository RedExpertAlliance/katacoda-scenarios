# Create Policies

Create policies to assign privileges to group *lab-participants*  


## Compartments

Policy `lab-participants-compartment-mgt-lab-compartment` to allow lab-participants to work with Compartments in compartment lab-compartment:

`Allow group lab-participants to manage compartments in compartment lab-compartment`


```
TODO
oci iam policy create  --name "lab-participants-object-storage-in-lab-compartment" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to use object-family in compartment lab-compartment\",\"Allow group lab-participants to manage buckets in compartment lab-compartment\",\"Allow group lab-participants to manage objects in compartment lab-compartment\" ]" --description "to allow lab-participants to work with Object Storage"
```{{execute}}

## TAGS
Allow group lab-participants to use tag-namespaces in tenancy


## OCI Events
allow group lab-participants to manage cloudevents-rules in tenancy

## Notifications
Allow group lab-participants to manage ons-topics in tenancy
Allow group lab-participants to manage ons-subscriptions in tenancy

## Alarms
Allow group lab-participants to manage alarms in tenancy
Allow group lab-participants to read metrics in tenancy

## NoSQL Database
allow group lab-participants to manage nosql-tables in compartment lab-compartment
allow group lab-participants to manage nosql-family in compartment lab-compartment


## Functions (FaaS) Policies

Prepare some environment variables
```
FN_DEVS_GROUP="lab-participants"
FN_MANAGE_APP_POLICY=lab-app-management
FN_GROUP_USE_VCN_POLICY=lab-group-use-network-family
FN_FAAS_USE_VCN_POLICY=lab-faas-use-network-family
FN_FAAS_READ_REPOS_POLICY=lab-faas-read-repos
```{{execute}}

Policies granting to *lab-participants* for Functions (FAAS) to access compartment, container repos, Network, compartment
```
oci iam policy create  --name lab-repos-management --compartment-id $TENANCY_OCID  --statements "[ \"Allow group $FN_DEVS_GROUP to manage repos in tenancy\"]"  --description "policy for granting rights to $FN_DEVS_GROUP to manage Repos in tenancy"

echo creating policy $FN_FAAS_USE_VCN_POLICY
oci iam policy create  --name $FN_FAAS_USE_VCN_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Network Resources"

echo creating policy $FN_FAAS_READ_REPOS_POLICY
oci iam policy create  --name $FN_FAAS_READ_REPOS_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to read repos in tenancy\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Repositories in Oracle Cloud Infrastructure Registry"


oci iam policy create  --name $FN_MANAGE_APP_POLICY --compartment-id $compartmentId  --statements "[ \"Allow group $FN_DEVS_GROUP to manage functions-family in compartment lab-compartment\",
\"Allow group $FN_DEVS_GROUP to read metrics in compartment lab-compartment\"]" --description "policy for granting rights to $FN_DEVS_GROUP to manage Function Apps in compartment lab-compartment"

echo creating policy $FN_GROUP_USE_VCN_POLICY
oci iam policy create  --name $FN_GROUP_USE_VCN_POLICY --compartment-id $compartmentId  --statements "[ \"Allow group $FN_DEVS_GROUP to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give Oracle Functions Users Access to Network Resources in compartment lab-compartment"
```{{execute}}


## Policies for using OKE - Kubernetes Container Engine
(see: https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#PolicyPrerequisitesService)


```
oci iam policy create  --name "lab-participants-oke-required-policy" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to manage instance-family in compartment lab-compartment\",\"Allow group lab-participants to use subnets in compartment lab-compartment\",\"Allow group lab-participants to read virtual-network-family in compartment lab-compartment\", \"Allow group lab-participants to use vnics in compartment lab-compartment\", \"Allow group lab-participants to inspect compartments in compartment lab-compartment\", \"Allow group lab-participants to manage cluster-family in compartment lab-compartment\"]" --description "to allow group lab-participants to perform operations required for OKE management in compartment lab-compartment"
```{{execute}}

## Policies on API Gateway

Policy: to allow lab apigw dynamic group access to lab-compartment
https://console.us-ashburn-1.oraclecloud.com/a/identity/policies
dyn-group-gateway-access-lab-compartment

```
allow dynamic-group lab-apigw-dynamic-group to use virtual-network-family in compartment lab-compartment
allow dynamic-group lab-apigw-dynamic-group to manage public-ips in compartment lab-compartment
allow dynamic-group lab-apigw-dynamic-group to use functions-family in compartment lab-compartment
```

```
oci iam policy create  --name "dyn-group-gateway-access-lab-compartment" --compartment-id $compartmentId  --statements "[ \"allow dynamic-group lab-apigw-dynamic-group to use virtual-network-family in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to manage public-ips in compartment lab-compartment\",\"allow dynamic-group lab-apigw-dynamic-group to use functions-family in compartment lab-compartment\"]" --description "to allow lab apigw dynamic group access to lab-compartment"
```{{execute}}


Policy `lab-participants-priv-on-api-gateway` to allow lab-participants to work with API Gateway:

`Allow group lab-participants to manage api-gateway-family in compartment lab-compartment`

```
oci iam policy create  --name "lab-participants-priv-on-api-gateway" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to manage api-gateway-family in compartment lab-compartment\"]" --description "to allow lab-participants to work with API Gateway"
```{{execute}}


## Object Storage

Policy `lab-participants-object-storage-in-lab-compartment` to allow lab-participants to work with Object Storage:

`Allow group lab-participants to use object-family in compartment lab-compartment`
`Allow group lab-participants to manage buckets in compartment lab-compartment`
`Allow group lab-participants to manage objects in compartment lab-compartment`

```
oci iam policy create  --name "lab-participants-object-storage-in-lab-compartment" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to use object-family in compartment lab-compartment\",\"Allow group lab-participants to manage buckets in compartment lab-compartment\",\"Allow group lab-participants to manage objects in compartment lab-compartment\" ]" --description "to allow lab-participants to work with Object Storage"
```{{execute}}



## Streaming

Policy `streaming-for-lab-participants` to allow lab-participants to work with Streaming:

```
Allow group lab-participants to use streams in compartment lab-compartment
Allow group lab-participants to use stream-pull in compartment lab-compartment
Allow group lab-participants to use stream-push in compartment lab-compartment
```

```
oci iam policy create  --name "streaming-for-lab-participants" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to use streams in compartment lab-compartment\",\"Allow group lab-participants to use stream-pull in compartment lab-compartment\",\"Allow group lab-participants to use stream-push in compartment lab-compartment\" ]" --description "to allow lab-participants to work with Streaming"
```{{execute}}

## Metrics and Monitoring

```
oci iam policy create  --name "monitoring-and-metrics-for-lab-participants" --compartment-id $compartmentId  --statements "[ \"Allow group lab-participants to use metrics in tenancy where target.metrics.namespace='mymetricsnamespace'\",\"Allow group lab-participants to inspect metrics in compartment  lab-compartment\",\"Allow group lab-participants to read metrics in compartment lab-compartment\",\"Allow group lab-participants to manage alarms in tenancy\",\"Allow group lab-participants to manage ons-topics in tenancy\" ]" --description "to allow lab-participants to work with Monitoring and Metrics and Alarms"
```{{execute}}

Audit:

Allow group lab-participants to read audit-events in compartment lab-compartment