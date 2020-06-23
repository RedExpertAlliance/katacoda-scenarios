Some of the steps in this scenario require the use of the OCI Command Line Interface. 

Execute the following command to install the OCI CLI:
```
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
sudo ./install-oci-cli.sh --accept-all-defaults

# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile

```{{execute}}

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please open the IDE tab and edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents that you prepared in the [OCI Tenancy preparation scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial). 

### Finalizing the Environment 

Set the environment variable LAB_ID to 1 - unless you are in a workshop with multiple participants and each uses their own number.

`export LAB_ID=1`{{execute}}

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

## Environment Preparation
Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

Configure and set remote context 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Create an appropriate Fn context for working with OCI as provider (see [OCI Docs on Functions](https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm)).

`fn create context lab-fn-context --provider oracle`{{execute}}

`fn use context lab-fn-context`{{execute}}

Prepare a number of environment variables. Note: the assumptions here are that you are working in a tenancy in the Ashburn region and a compartment called *lab-compartment* exists as well as an API Gateway *lab-apigw* in that same compartment as well as an API Deployment called MY_API_DEPL# on the API Gateway. We need to get references to these resources in order to create new resources in the right place.  

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
export TENANCY_OCID=$(oci iam user list --all | jq -r  '.data[0]."compartment-id"') 
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

apigws=$(oci api-gateway gateway list -c $compartmentId)
export apiGatewayId=$(echo $apigws | jq -r --arg display_name "lab-apigw" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
# get namespace
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')

```{{execute}}

Update the context with the settings relevant for this workshop.
```
fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.$REGION.oci.oraclecloud.com

fn update context registry ${REGION_KEY,,}.ocir.io/$ns/cloudlab-repo

fn update context oracle.profile FN
```{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}

### Login Docker to OCI Container Registry 

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


Prepare a number of environment variables. Note: the assumptions here is that a compartment called *lab-compartment* exists. We need to get a reference in order to create new resources in the right place.  

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
export TENANCY_OCID=$(oci iam user list --all | jq -r  '.data[0]."compartment-id"') 
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

echo "Compartment OCID: $compartmentId"
echo "Namespace: $ns"

```{{execute}}
