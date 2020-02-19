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

```
cd fn-text2pdf-events/
cp $HOME/.oci/oci_api_key.pem .
```{{execute}}

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
export OUT_BUCKET_BUCKET=$(echo out$LAB_ID)
```{{execute}}

- IN_BUCKET is the name of the bucket where you will upload the text file.
- OUT_BUCKET is the name of the bucket where the converted PDF will be uploaded.


`fn create app text2pdfEvents$LAB_ID --annotation oracle.com/oci/subnetIds='["'"$subnetId"'"]' --config TENANT_OCID=$TENANT_OCID --config USER_OCID=$USER_OCID --config FINGERPRINT=$FINGERPRINT --config PASSPHRASE=$PASSPHRASE --config REGION=$REGION --config PRIVATE_KEY_NAME=./.oci/oci_api_key.pem --config OUT_BUCKET=$OUT_BUCKET`{{execute}}

Once the application is created we need to deploy it executing this:

`fn -v deploy --app text2pdfEvents$LAB_ID --build-arg PRIVATE_KEY_NAME=./.oci/oci_api_key.pem`{{execute}}

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

`oci os bucket create -c $COMPARTMENT_ID --name $IN_BUCKET`{{execute}}

`oci os bucket create -c $COMPARTMENT_ID --name $OUT_BUCKET`{{execute}}

# Rule creation using OCI CLI

For the rule creation, execute this:

`cp ../actionsFunc.json .`{{execute}}
`oci events rule create --display-name text2PDF$LAB_ID --is-enabled true --condition '{"eventType":"com.oraclecloud.objectstorage.object.create", "data": {"bucketName":"$IN_BUCKET"}}' --compartment-id $COMPARTMENT_OCID --actions file://actionsFunc.json `{{execute}}

Now we are ready to test it, we can use the lorem.txt file to upload it to the input bucket and after a few seconds in the output bucket you should see a 
PDF file. 

To validate it, list the contents of the out bucket executing the following:

`oci os object list -bn $OUT_BUCKET`{{execute}}
