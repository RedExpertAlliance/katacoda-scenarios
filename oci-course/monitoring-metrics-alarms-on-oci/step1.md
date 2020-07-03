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


## Environment Preparation

Prepare a number of environment variables. Note: the assumptions here are that you are working in a tenancy in the Ashburn region and a compartment called *lab-compartment* exists as well as an API Gateway *lab-apigw* in that same compartment as well as an API Deployment called MY_API_DEPL# on the API Gateway. We need to get references to these resources in order to create new resources in the right place.  

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
export TENANCY_OCID=$(oci iam user list --all | jq -r  '.data[0]."compartment-id"') 
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
```{{execute}}





