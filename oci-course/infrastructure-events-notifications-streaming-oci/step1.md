## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

**Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.**

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
export REGION_KEY_UPPER=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export REGION_KEY=$(echo $REGION_KEY_UPPER | tr '[:upper:]' '[:lower:]')
```{{execute}}


Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Now let's set the following environment variables.
Note: the assumptions here are a compartment called *lab-compartment*, a VCN called *vcn-lab* and a subnet in that VCN called *Public Subnet-vcn-lab*. We need 
to get references to these resources in order to create the Functions that we will use in step 3.  
```
export CS=$(oci iam compartment list)
export COMPARTMENT_OCID=$(echo $CS | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
export VCNS=$(oci network vcn list -c $COMPARTMENT_OCID)
export VCNID=$(echo $VCNS | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
export SUBNETS=$(oci network subnet list  -c $COMPARTMENT_OCID --vcn-id $VCNID)
export SUBNETID=$(echo $SUBNETS | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
export NSS=$(oci os ns get)
export NAMESPACE=$(echo $NSS | jq -r '.data')
export REGION=us-ashburn-1
export MY_BUCKET=$(echo myBucket$LAB_ID)
```{{execute}}

The following variables will be set using the information contained in the OCI config file ($HOME/.oci/config)
```
export TENANT_OCID=$(grep -i 'tenancy' $HOME/.oci/config  | cut -f2 -d'=' | head -1)
export USER_OCID=$(grep -i 'user' $HOME/.oci/config  | cut -f2 -d'=' | head -1)
export FINGERPRINT=$(grep -i 'fingerprint' $HOME/.oci/config  | cut -f2 -d'=' | head -1)
export PASSPHRASE=$(grep -i 'pass_phrase' $HOME/.oci/config  | cut -f2 -d'=' | head -1)
```{{execute}}
***(Note. If you do not have a passphrase, it is not necessary to set that environment variable)***

## Oracle Events Configuration

In the tenant that you are using, there are a set of policies already in place, but if you are curious or if you are using your own environment you need to
create a set of polices that will allow users to create and manage rules.

As we already mentioned, in the tenant you are using, those policies are already in place. If you want to learn
more about those policies take a look [here](https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsgetstarted.htm "Policies Concepts").
