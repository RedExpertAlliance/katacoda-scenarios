## Wait for OCI CLI to be installed

**IMPORTANT NOTE: Do not proceed if you have not perfomed steps of these both scenarios:**
- OKE Part 1 https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1
- OKE API Reverse Proxy https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-api-server-reverse-proxy

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

If you do not have the OCI config file, nor the oci API key yet, you can go through these steps: https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial

Once you have the config file and the api key, copy their contents in ~/.oci/config and ~/.oci/oci_api_key.pem respectively. 
**Remember that in this scenario you will be working with a newly created 30 day free trial OCI instance, and you will be using the administrator of your
tenant, which is the user you created when the tenant was provisioned**


`export PATH=/root/bin:$PATH`{{execute}}

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and is connected to your tenant.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Let's also test that kubectl install and working properly, execute the following:
`kubectl version`{{execute}}

You should receive something like this:

~~~~
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.5", GitCommit:"e6503f8d8f769ace2f338794c914a96fc335df0f", GitTreeState:"clean", BuildDate:"2020-06-26T03:47:41Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
~~~~

Let´s also create the following environment variables, that we will use in the next steps:

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
export TENANT_OCID=$(grep -i 'tenancy' $HOME/.oci/config  | cut -f2 -d'=' | head -1)
```{{execute}}

`export LAB_ID=1`{{execute}}

`cs=$(oci iam compartment list)`{{execute}}

Let's get the compartment ID first:
`export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')`{{execute}}

Let's just echo it:
`echo "Compartment lab-compartment OCID=$compartmentId"`{{execute}}

In Part 1 of the OKE Scenario you wrote down the name of your cluster, if you've followed the instructions your cluster name is MyFirstOKE. Let's set that
as an environment variable:

`export MY_CLUSTER_NAME=MyFirstOKE`{{execute}}

If you've set a different name, please set the variable accordingly.