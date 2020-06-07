In addition to the OCI console, you can interact with Oracle Cloud Infrastructure through the Command Line Interface or CLI. This CLI is stand alone Python application that you need to install on a computer, for example your laptop. You need to provide a configuration file to the CLI that defines which cloud tenancy to interact with and which credentials to use for that. In this scenario, the OCI CLI has been installed in your Katacoda environment. You need to copy and paste the contents into the configuration file and the private key  file and then you will use the CLI to perform a number of look up operations and administrative actions.  

The CLI allows the same operations to be performed as the Console - using command line statements that lend themselves to being scripted. Automating management of OCI resources can be done using the OCI CLI - the term *infrastructure as code* is typically used for this type of automation. NOte that *Infrastructure as Code* on OCI can also be done using Terraform and the Terraform Provider for Oracle Cloud Infrastructure.

Note: the OCI CLI under the hood makes calls to the OCI REST APIs, the same that are used by the Console, the Terraform Provider for OCI and the SDKs that are available for several programming languages. These REST APIs can also be invoked directly by your own applications using signed HTTP requests.  

Please proceed now by providing details on the OCI tenancy you are working in and for the OCI user you will work as. Please edit these two files:

* ~/.oci/config - the configuration file for OCI CLI to connect to correct tenancy
* ~/.oci/oci_api_key.pem - the private key for the OCI user as whom you will connect to the OCI tenancy

Paste the respective snippets of contents that you record in the preparation scenario that you went through earlier.

The file *config* should look like this (with your specific environment details filled in):
```
[DEFAULT]
user=ocid1.user.oc1..aaaaaa
fingerprint=69:7f:92
key_file=/root/.oci/oci_api_key.pem
tenancy=ocid1.tenancy.oc1..aaaaa
region=us-ashburn-1
```
The file oci_api_key.pem contains the private key half of a key pair that has been generated for the user and for which the public key half has been uploaded to OCI. This files looks like this:
```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA3xviQyh+0ufLy1W9qb3WdMTmX1+fFxWjamFJqehjWYdWQ5VH
xAvgAWOPXDtNPhY/8oI2qc6XFCnTpljJJ2JmvRdS+6rt7hFOhKk6MWdR4aFrsVg5
quEsUUF58N2fju7PBcQXxGtrDYr8QuAixOAEZs4d9YKP5WZVfsM=
-----END RSA PRIVATE KEY-----
```

The OCI Command Line Interface was installed into the Katacoda scenario's Ubuntu environment when you started the scenario. You can now try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Now please set the Region environment variable using this command:

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
```{{execute}}

### Exploring Compartments

To get a list of all compartments in the tenancy (that you can see), use the next command:

`oci iam compartment list`{{execute}}

To get details for the *lab-compartment*, we can use a little tool called *jq* to interpret the JSON response body:

`oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] '`{{execute}}

To store the OCID for compartment *lab-compartment* in environment variable *compartmentId* , execute this command:

```
export compartmentId=$(oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id ')
echo $compartmentId
```{{execute}}

We will need this compartment OCID in many of the OCI CLI calls we will be making. Virtually all actions in OCI - in the Console and through CLI - take place in the context of a compartment and we need to explicitly indicate that compartment in each CLI call.

### Search (by name and tag)
The search service that you used in step 6 in the console is also available on the command line. Here is a simple search on the text string *americas*. 

`oci search resource free-text-search --text "americas"`{{execute}}

### Find Bucket and File

Set the environment variable LAB_ID to the value 01. 

`export LAB_ID=01`{{execute}}

(note: you can replace the 01 with other values when in a workshop with multiple users in the same cloud tenancy)

To find the bucket *bucket-LAB_ID* (or *LAB-01*) that you created earlier on, use this command:

`oci os bucket list --compartment-id=$compartmentId`{{execute}}

And to get the details for your specific bucket:
`oci os bucket list --compartment-id=$compartmentId | jq -r --arg name "bucket-$LAB_ID" '.data | map(select(."name" == $name)) | .[0] '`{{execute}}
Actually, these are not all the details. It turns out there is a much better way to retrieve the bucket details, using this command:

`oci os bucket get --bucket-name="bucket-$LAB_ID"`{{execute}}

Let's list the files in the bucket - to see the file you have uploaded in step 5.

`oci os object list --bucket-name="bucket-$LAB_ID"`{{execute}}

To get the details for this file and download the contents, execute this statement. First it retrieves the name of the file from the list and then gets the file by name, saving it as *myfileDownloadedFromOCI*:
```
FILENAME=$(oci os object list --bucket-name="bucket-$LAB_ID" | jq -r  '.data | .[0] | .name')
echo "Your file is called $FILENAME"
oci os object get --bucket-name="bucket-$LAB_ID" --name $FILENAME --file myfileDownloadedFromOCI
ls -l
```{{execute}}

### Upload File
Of course you can also upload files through the OCI. Let's create a small file and then upload it to the bucket.
```
FILENAME=helloWorldFile$LAB_ID.txt
echo "Hello World in this Bright New File" > $FILENAME
oci os object put --bucket-name="bucket-$LAB_ID" --name $FILENAME --file ./$FILENAME --metadata '{"file_tag":"HelloWorld","additional_tag":"created from Katacoda scenario"}'
```{{execute}}

Check in OCI Console that a new file is created in your bucket *bucket-$LAB_ID*: Core Infrastructure | Object Storage | Object Storage or follow this link to the console for the list of buckets: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets

This command provides you in the terminal with a clickable link for the OCI console in your home region:
`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/object-storage/buckets"`{{execute}}

Inspect Object Details for the file; verify that the tags were associated with the file.
![Uploaded File Details](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-uploaded-file-details.png)

## Resources

OCI Docs [OCI Command Line Reference])(https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.2/oci_cli_docs/)

OCI Docs [OCI Command Line Reference on Object Storage])(https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.2/oci_cli_docs/cmdref/os/object.html)