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

We are going to leverage from this code:
https://github.com/rcarrascosps/fn-text2pdf

First let's clone the code:
`git clone https://github.com/rcarrascosps/fn-text2pdf.git`{{execute}}

Once you have the code, execute this:

`fn create app text2pdf{LabID} --annotation oracle.com/oci/subnetIds={SUBNETS} --config TENANT_OCID={TENANT_OCID} --config USER_OCID={USER_OCID} --config FINGERPRINT={FINGERPRINT} --config PASSPHRASE={PASSPHRASE>} --config REGION={REGION} --config PRIVATE_KEY_NAME={PRIVATE_KEY_NAME} --config NAMESPACE={NAMESPACE} --config BUCKET_NAME={BUCKET_NAME}`{{execute}}

You need to ask the instructor for the following elements:

- SUBNETS
- TENANT_OCID
- USER_OCID
- FINGERPRINT
- PASSPHRASE
- REGION
- NAMESPACE
- PRIVATE_KEY_NAME
- BUCKET_NAME (this is the bucket where you need to upload your file)

Do not forget to identity your application (text2pdf{LabID}) in order to differentiate it from others.

Once the application is created we need to deploy it executing this:

`cd fn-text2pdf`{{execute}}

`fn -v deploy --app text2{LabID} --build-arg PRIVATE_KEY_NAME={privateKeyName}`{{execute}}




