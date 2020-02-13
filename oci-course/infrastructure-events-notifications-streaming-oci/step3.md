# Oracle Function call after conditions are met within a Rule

In this step we will apply what we learned in our previous steps, regarding:
- Creating a Rule
- Defining conditions

But this time we are not going to use the email notification action, we will call an Oracle Function.

This is a very good integration between two OCI components: OCI based Events and Oracle Functions. This will open up a lot of alternatives and broaden your limits
in terms of what to do after reacting to an event; at the end, within an Function you can pretty much do whatever you want with code.

The scenario is quite simple: 
- We are going to create a function that transform text to a PDF document. 
- We are going to create a couple of Buckets. One to upload a text document, and the second one to store the PDF resulted of the Function call
- We are going to create a rule with two conditions:
	- When an object is created
	- And the resource name is myBucket{LabID}
- And the action will be: execute the function that translates the text document into a PDF
- The PDF will get uploaded to the second bucket

# Function creation

We are going to leverage from this code, which was originally developed by Abhishek Gupta.
https://github.com/rcarrascosps/fn-text2pdf-events

First let's clone the code:
`git clone https://github.com/rcarrascosps/fn-text2pdf-events.git`{{execute}}

Copy the private key to the folder where the repository was downloaded.

Once you have the code and the private key, execute this:

`fn create app text2pdfEvents{LabID} --annotation oracle.com/oci/subnetIds=<SUBNETS> --config TENANT_OCID=<TENANT_OCID> --config USER_OCID=<USER_OCID> --config FINGERPRINT=<FINGERPRINT> --config PASSPHRASE=<PASSPHRASE> --config REGION=<REGION> --config PRIVATE_KEY_NAME=<PRIVATE_KEY_NAME> --config OUTPUT_BUCKET=<OUTPUT_BUCKET>`{{execute}}

You need to ask the instructor for the following elements:

- SUBNETS
- TENANT_OCID
- USER_OCID
- FINGERPRINT
- PASSPHRASE
- REGION
- NAMESPACE
- PRIVATE_KEY_NAME
- OUTPUT_BUCKET (this is the bucket where the PDF will be stored)

Do not forget to identity your application (text2pdf{LabID}) in order to differentiate it from others.

Once the application is created we need to deploy it executing this:

`cd fn-text2pdf`{{execute}}

`fn -v deploy --app text2pdfEvents{LabId} --build-arg PRIVATE_KEY_NAME=<private_key_name>`{{execute}}

Once the function is deployed, we need to obtain its OCID. To do that, execute the following:

`fn inspect fn text2pdfEvents{LabId} convert | jq '.id' | sed -e 's/^"//' -e 's/"$//'`{{execute}}

Copy the OCID and edit the actions.json file to include it.

# Buckets creation

We are going to create two buckets:

- One to upload the text file
- A second one where the PDF document will be automatically uploaded by our function

`oci os bucket create -c ocid1.compartment.oc1..625m6yxz567qsecqxu5cqpc5ypyjum4gccynrmiqf2a --name inLabID`{{execute}}
(Replace the LabID for your assigned LabID)

`oci os bucket create -c ocid1.compartment.oc1..625m6yxz567qsecqxu5cqpc5ypyjum4gccynrmiqf2a --name outLabID`{{execute}}
(Replace the LabID for your assigned LabID)

# Rule creation using OCI CLI




