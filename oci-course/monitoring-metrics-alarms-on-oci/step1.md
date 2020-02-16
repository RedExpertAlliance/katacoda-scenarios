Some of the steps in this scenario require the use of the OCI Command Line Interface. This tool is installed for you at this moment. 

In order to be able to use the CLI, you need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Replace `1` with the number you have been assigned.

Note: Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Prepare a number of environment variables. Note: the assumptions here are that you are working in a tenancy in the Ashburn region and a compartment called *lab-compartment* exists. We need to get a reference in order to create new resources in the right place.  

```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
echo "Compartment lab-compartment OCID=$compartmentId"
```{{execute}}
