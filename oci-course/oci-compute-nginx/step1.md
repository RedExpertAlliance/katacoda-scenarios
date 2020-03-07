## Wait for OCI CLI (and Fn CLI) to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Prepare a number of environment variables. Note: the assumptions here is a compartment called *lab-compartment*. In that compartment we will create our
compute instance and we will use **ASHBURN-AD-1** as our availability domain. We will use shape **VM.Standard2** for our compute instance. If you are interested
on which other shapes exist, please take a look at [here](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm "VM Shapes").
The name of our compute instance is going to be ***nginxLAB+LAB_ID*** (e.g. **ngninxLAB1**).
When creating your keys, please use the path **/root/keys/lab**.

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
export DISPLAY_NAME=nginxLAB$LAB_ID
export ADOMAINS=$(oci iam availability-domain list --compartment-id $COMPARTMENT_OCID)
export AVAILABILITY_DOM=$(echo $ADOMAINS | jq -r '.data | .[0] | .name')
export IMG_ID=ocid1.image.oc1.iad.aaaaaaaavzjw65d6pngbghgrujb76r7zgh2s64bdl4afombrdocn4wdfrwdq
export SHAPE=VM.Standard2.1
export KEY_PUB=/root/keys/lab.pub
export CONFIG=/root/computeInstanceConfig.txt

echo "Compartment OCID: $COMPARTMENT_OCID"
echo "Namespace: $NAMESPACE"
echo "SUBNETID: $SUBNETID"
echo "AVAILABILITY DOMAIN to be used: $AVAILABILITY_DOM"
```{{execute}}

## Create Public and Private Key

For generating the public and private key that will be used to ssh to the compute instance, execute (remember to use ***/root/keys/lab***):

`ssh-keygen -t rsa`{{execute}}

This will prompt you for the location where the keys will be stored. Enter ***/root/keys/lab***

After that you will be prompted for a passphrase, you can leave it blank if you do not want to set one.

A similar output like the following one, will appear:

~~~~
Generating public/private rsa key pair.
Enter file in which to save the key (/root/keys):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
The key fingerprint is:
11:3a:f8:f4:9o:d9:c7:dg:09:3b:e3:3f:c4:3f:44:95
~~~~

Now you have everything you need to create your compute instance within your lab-compartment. Let's go to the next step.