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

# Functions preparation

If  you have gone through [this](https://www.katacoda.com/redexpertalliance/courses/oci-course/functions-on-oci "Functions on OCI") you will be familiar
with the upcomming steps to connect the Fn CLI with the Oracle Cloud Infrastructure. If this is your first time, then you will learn how to do it.

Check the installed version of Fn CLI.  

`fn version`{{execute}} 

Configure & set remote context: 

List the currently available Fn contexts:

`fn list contexts`{{execute}}

Create an appropriate Fn context for working with OCI as provider (see [OCI Docs on Functions](https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm)).

`fn create context lab-fn-context --provider oracle`{{execute}}

`fn use context lab-fn-context`{{execute}}

Prepare the following environment variables. Again, the assumptions here are a compartment called *lab-compartment*, a VCN called *vcn-lab* and a subnet in that VCN called *Public Subnet-vcn-lab*. We need to get references to these three resources in order to create Functions and Applications in the right place.  
```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

vcns=$(oci network vcn list -c $compartmentId)
vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')
```{{execute}}

Update the *fn* context with the settings relevant for this workshop. Note: the compartment used here is the lab-compartment 
```
fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

r=$(fn update context registry iad.ocir.io/$ns/cloudlab-repo)

fn update context oracle.profile FN
```{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

`docker login iad.ocir.io`{{execute}}

The username you have to provide is composed of `<tenancy-namespace>/<username>`. The password is an Authentication Token generated for the specified user. Both these values are provided by your workshop instructor.

Now let's create our function that will convert text into PDF and will upload it to our output bucket.

# Function creation

We are going to leverage from this code, which was originally developed by Abhishek Gupta.
https://github.com/rcarrascosps/fn-text2pdf-events

First let's clone the code:
`git clone https://github.com/rcarrascosps/fn-text2pdf-events.git`{{execute}}

Copy the private key (oci_api_key.pem to the folder where the repository was downloaded.

`cd fn-text2pdf-events/`{{execute}}

`cp $HOME/.oci/oci_api_key.pem .`{{execute}}

You need to have all the following environment variables already set (you set them in Step 1).

- SUBNETS
- TENANT_OCID
- USER_OCID
- FINGERPRINT
- PASSPHRASE
- REGION
- NAMESPACE

Now let's set two more variables for the names of our buckets:

```
export IN_BUCKET=$(echo in$LAB_ID)
export OUT_BUCKET=$(echo out$LAB_ID)
```{{execute}}

- IN_BUCKET is the name of the bucket where you will upload the text file.
- OUT_BUCKET is the name of the bucket where the converted PDF will be uploaded.


`fn create app text2pdfEvents$LAB_ID --annotation oracle.com/oci/subnetIds='["'"$subnetId"'"]' --config TENANT_OCID=$TENANT_OCID --config USER_OCID=$USER_OCID --config FINGERPRINT=$FINGERPRINT --config PASSPHRASE=$PASSPHRASE --config REGION=$REGION --config PRIVATE_KEY_NAME=oci_api_key.pem --config OUTPUT_BUCKET=$OUT_BUCKET`{{execute}}

The function needs a set of config variables to work:

- OUT_BUCKET is the name of the bucket where the PDF will be stored
- PRIVATE_KEY_NAME, PASSPHRASE, USER_OCID, TENANT_OCID, FINGERPRINT are used because within the code we are going to upload the PDF into the bucket, and 
we need to be authenticated. The PASSPHRASE is optional, as we mentioned in Step 1.

Once the application is created we need to deploy it executing this:

`fn -v deploy --app text2pdfEvents$LAB_ID --build-arg PRIVATE_KEY_NAME=oci_api_key.pem`{{execute}}

Once the function is deployed, we need to obtain its OCID. To do that, execute the following:

`fn inspect fn text2pdfEvents$LAB_ID convert | jq '.id' | sed -e 's/^"//' -e 's/"$//'`{{execute}}

Copy the function OCID and edit the actionsFunc.json file to include as the value for element functionId.

The actionsFunc.json file looks like this

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

`oci os bucket create -c $COMPARTMENT_OCID --name $IN_BUCKET`{{execute}}

`oci os bucket create -c $COMPARTMENT_OCID --name $OUT_BUCKET`{{execute}}

# Rule creation using OCI CLI

For the rule creation, execute this:

`cp ../actionsFunc.json .`{{execute}}

`oci events rule create --display-name text2PDF$LAB_ID --is-enabled true --condition '{"eventType":["com.oraclecloud.objectstorage.createobject"], "data": {"bucketName":"'"$IN_BUCKET"'"}}' --compartment-id $COMPARTMENT_OCID --actions file://actionsFunc.json `{{execute}}

Now we are ready to test it, we can use the lorem.txt (it is located in the fn-text2pdf-events) file to upload it to the input bucket,and after a few seconds, in the output bucket you should see a 
PDF file with the same name (lorem.pdf). 

A sample event envelope is like this:
~~~~
{
  "eventType" : "com.oraclecloud.objectstorage.createobject",
  "cloudEventsVersion" : "0.1",
  "eventTypeVersion" : "2.0",
  "source" : "ObjectStorage",
  "eventTime" : "2020-02-21T04:04:53.733Z",
  "contentType" : "application/json",
  "data" : {
    "compartmentId" : "ocid1.compartment.oc1..aaaaaaaa4tjjg5nin3wslisvfygemkiem3f2azdapdrt5vhvunfg4a",
    "compartmentName" : "lab-compartment",
    "resourceName" : "lorem.txt",
    "resourceId" : "/n/idi66ekilhnr/b/in96/o/lorem.txt",
    "availabilityDomain" : "IAD-AD-2",
    "additionalDetails" : {
      "bucketName" : "in1",
      "archivalState" : "Available",
      "namespace" : "idadsfilhnr",
      "bucketId" : "ocid1.bucket.oc1.iad.aaaaaaaagasgtwuzlgg4zg5vemzi3tginlvvh2przavniuknq3gv7mxrc3moasma",
      "eTag" : "f5293af9-f123-4e9f-ac4a-438d81a0464c"
    }
  },
  "eventID" : "7b805085-83f4-9344-48b1-13b1a52bdfb4",
  "extensions" : {
    "compartmentId" : "ocid1.compartment.oc1..adfafg5viv3wsnisvfegemkkin3nwzem3f2azdapdrt5vhvunfg4a"
  }
}
~~~~


To validate it, list the contents of the out bucket executing the following:

`oci os object list -bn $OUT_BUCKET`{{execute}}

If you want to manually test the function, you can do it executing something like the following. If you want to do it, just replace the compartmentId, namespace
and bucketId to reflect your environment. If you have any doubt, ask the instructor, or if you are doing this on your own, all those values are already set 
in the environment variables that we have set until this point.

`export event= '{"eventType":"com.oraclecloud.objectstorage.createobject","cloudEventsVersion":"0.1","eventTypeVersion":"2.0","source":"ObjectStorage","eventTime":"2020-02-21T04:04:53.733Z","contentType":"application/json","data":{"compartmentId":"ocid1.compartment.oc1..aaaaaaaa4tjjg5nin3wslisvfygemkiem3f2azdapdrt5vhvunfg4a","compartmentName":"lab-compartment","resourceName":"lorem.txt","resourceId":"/n/idi66ekilhnr/b/in96/o/lorem.txt","availabilityDomain":"IAD-AD-2","additionalDetails":{"bucketName":"in1","archivalState":"Available","namespace":"idadsfilhnr","bucketId":"ocid1.bucket.oc1.iad.aaaaaaaagasgtwuzlgg4zg5vemzi3tginlvvh2przavniuknq3gv7mxrc3moasma","eTag":"f5293af9-f123-4e9f-ac4a-438d81a0464c"}},"eventID":"7b805085-83f4-9344-48b1-13b1a52bdfb4","extensions":{"compartmentId":"ocid1.compartment.oc1..adfafg5viv3wsnisvfegemkkin3nwzem3f2azdapdrt5vhvunfg4a"}}'`{{export}}

`echo $event | fn invoke text2pdfEvents$LAB_ID convert`{{execute}}

With this we have finalized this scenario.