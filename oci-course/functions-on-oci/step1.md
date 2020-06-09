## Wait for OCI CLI and Fn CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents that you prepared in the [OCI Tenancy preparation scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial).

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

You need to perform one more edit action on file *~/.oci/config*. Open this file in the editor. Copy the entire contents and paste it below the current contents. Now change `[DEFAULT]` to `[FN]` in the duplicate block. The file will now look something like:

```
[DEFAULT]
user=ocid1.user.oc1..aaaaaaaazr7eselv5q
fingerprint=fd:db:13:bd:31
tenancy=ocid1.tenancy.oc1..aaaaaaaaggg6okq
region=us-ashburn-1
key_file=/root/.oci/oci_api_key.pem
[FN]
user=ocid1.user.oc1..aaaaaaaazr7eselv5q
fingerprint=fd:db:13:bd:31
tenancy=ocid1.tenancy.oc1..aaaaaaaaggg6okq
region=us-ashburn-1
key_file=/root/.oci/oci_api_key.pem
```

Now please set the Region environment variable using this command:

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
```{{execute}}

## Fn Client and Context

Now Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

Configure and set remote context 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Create an appropriate Fn context for working with OCI as provider (see [OCI Docs on Functions](https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm)).

`fn create context lab-fn-context --provider oracle`{{execute}}

`fn use context lab-fn-context`{{execute}}

Prepare a number of environment variables. Note: the assumptions here are a compartment called *lab-compartment*, a VCN called *vcn-lab* and a subnet in that VCN called *Public Subnet-vcn-lab*. We need to get references to these three resources in order to create Functions and Applications in the right place.  
```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

vcns=$(oci network vcn list -c $compartmentId)
vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')
```{{execute}}

Update the *fn* context with the settings relevant for this workshop. Note: the compartment used here is the *lab-compartment* 
```
fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.$REGION.oci.oraclecloud.com

r=$(fn update context registry ${REGION_KEY,,}.ocir.io/$ns/cloudlab-repo)

fn update context oracle.profile FN
```{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

The username you have to provide is composed of `<tenancy-namespace>/<username>`. 
```
NAMESPACE=$(oci os ns get| jq -r  '.data')
USER_USERNAME=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."name"')
echo "Username for logging in into Container Registry is $NAMESPACE/$USER_USERNAME"
```{{execute}}

The password is an Authentication Token generated for the specified user, in the OCI Tenancy preparation scenario. If you do not remember the authentication token, you can generate another one in the OCI Console:  https://console.REGION.oraclecloud.com/identity/users/<user-ocid>/swift-credentials or using the instructions in the preparation scenario. 

`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/identity/users/$USER_OCID/swift-credentials"`{{execute}}

Now you can perform the login. Type the username and press enter, then type or paste the authentication token and press enter again. 

`docker login ${REGION_KEY,,}.ocir.io`{{execute}}

And now we are finally ready to create functions and deploy them to the Oracle Cloud Infrastructure instead of to the locally running Fn Server.