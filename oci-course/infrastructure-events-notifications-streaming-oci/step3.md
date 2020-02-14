# Oracle Function call after conditions are met within a Rule

In this step we will apply what we learned in our previous steps, regarding:
- Creating a Rule
- Defining conditions

But this time we are not going to use the email notification action, we will call an Oracle Function.

This is a very good integration between two OCI components: OCI based Events and Oracle Functions. This will open up a lot of alternatives and broaden your 
limits in terms of what to do after reacting to an event; at the end, within an Function you can pretty much do whatever you want with code.

The scenario is quite simple: 
- We are going to create a function that transform text to a PDF document. 
- We are going to create a couple of Buckets. One to upload a text document, and the second one to store the PDF resulted of the Function call
- We are going to create a rule with two conditions:
	- When an object is created
	- And the resource name is myBucket{LAB_ID}
- And the action will be: execute the function that translates the text document into a PDF
- The PDF will get uploaded to the second bucket

# Function creation

We are going to leverage from this code, which was originally developed by Abhishek Gupta.
https://github.com/rcarrascosps/fn-text2pdf-events

First let's clone the code:
`git clone https://github.com/rcarrascosps/fn-text2pdf-events.git`{{execute}}

Copy the private key to the folder where the repository was downloaded.

Once you have the code and the private key, execute this:

`fn create app text2pdfEvents$LAB_ID --annotation oracle.com/oci/subnetIds=<SUBNETS> --config TENANT_OCID=$TENANT_OCID --config USER_OCID=$USER_OCID --config FINGERPRINT=$FINGERPRINT --config PASSPHRASE=$PASSPHRASE --config REGION=$REGION --config PRIVATE_KEY_NAME=./.oci/oci_api_key.pem --config OUTPUT_BUCKET=out$LAB_ID`{{execute}}

You need to have all the following environment variables already set.

- SUBNETS
- TENANT_OCID
- USER_OCID
- FINGERPRINT
- PASSPHRASE
- REGION
- NAMESPACE
- OUTPUT_BUCKET (this is the bucket where the PDF will be stored)

Do not forget to identify your application (text2pdf{LAB_ID}) in order to differentiate it from others.

Once the application is created we need to deploy it executing this:

`cd fn-text2pdf`{{execute}}

`fn -v deploy --app text2pdfEvents{LAB_ID} --build-arg PRIVATE_KEY_NAME=./.oci/oci_api_key.pem`{{execute}}

Once the function is deployed, we need to obtain its OCID. To do that, execute the following:

`fn inspect fn text2pdfEvents{LAB_ID} convert | jq '.id' | sed -e 's/^"//' -e 's/"$//'`{{execute}}

Copy the OCID and edit the actions.json file to include it.

The action file looks like this

~~~~
{
  "actions": [
    {
      "actionType": "FAAS",
      "description": "Invoke PDF conversion when .txt file is uploaded to storage bucket",
      "isEnabled": true,
      "functionId": "ocid1.fnfunc.oc1.phx.fadfadfasd"
    }
  ]
}
~~~~

# Buckets creation

We are going to create two buckets:

- One to upload the text file
- A second one where the PDF document will be automatically uploaded by our function

`oci os bucket create -c ocid1.compartment.oc1..625m6yxz567qsecqxu5cqpc5ypyjum4gccynrmiqf2a --name in$LAB_ID`{{execute}}
(Replace the LAB_ID for your assigned LAB_ID)

`oci os bucket create -c ocid1.compartment.oc1..625m6yxz567qsecqxu5cqpc5ypyjum4gccynrmiqf2a --name out$LAB_ID`{{execute}}
(Replace the LAB_ID for your assigned LAB_ID)

# Rule creation using OCI CLI

For the rule creation, execute this:

`oci events rule create --display-name text2PDF$LAB_ID --is-enabled true --condition '{"eventType":"com.oraclecloud.objectstorage.object.create", "data": {"bucketName":"in$LAB_ID"}}' --compartment-id $compartment-ocid --actions file://actionsFunc.json `{{execute}}

Now we are ready to test it, we can use the lorem.txt file to upload it to the input bucket and after a few seconds in the output bucket you should see a 
PDF file. 

To validate it, list the contents of the out bucket executing the following:

`oci os object list -bn out$LAB_ID`{{execute}}
