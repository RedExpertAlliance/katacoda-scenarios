

OCI Command Line Interface

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config - the configuration file for OCI CLI to connect to correct tenancy
* ~/.oci/oci_api_key.pem - the private key for the OCI user as whom you will connect to the OCI tenancy

Paste the respective snippets of contents provided by the workshop instructor into these two files.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.



Find Compartment

To get a list of all compartments in the tenancy (that you can see), use the next command:
`oci iam compartment list`{{execute}}

To get details for the *lab-compartment*, we can use a little tool called *jq* to interpret the JSON response body:
`oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] '`{{execute}}

To store the OCID for compartment *lab-compartment* in environment variable *compartmentId* , execute this command:

```export compartmentId=$(oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
echo $compartmentId
```{{execute}}

We will need this compartment OCID in many of the OCI CLI calls we will be making. Virtually all actions in OCI - in the Console and through CLI - take place in the context of a compartment and we need to explicitly indicate that compartment in each CLI call.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.
`export LAB_ID=1`{{execute}}
(replace the 1 with whatever identifier you have been given and using)

To find the bucket *bucket-LAB_ID* that you created earlier on, use this command:

Find Bucket
`oci os bucket list --compartment-id=$compartmentId`{{execute}}

And to get the details for your specific bucket:
`oci os bucket list --compartment-id=$compartmentId | jq -r --arg name "bucket-$LAB_ID" '.data | map(select(."name" == $name)) | .[0] '`{{execute}}
Actually, these are not all the details. It turns out there is a much better way to retrieve the bucket details, using this command:
`oci os bucket get --bucket-name="bucket-$LAB_ID"`{{execute}}.

##TODO:

Find File
Download File
Upload File

Search by tag?

## Resources
OCI Docs [OCI Command Line Reference])(https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.2/oci_cli_docs/)