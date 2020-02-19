## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Now let'´s set the following enviornment variables.
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
export MY_BUCKET=
```{{execute}}
$(echo myBucket$LAB_ID)
The following variables needs to be set using the information contained in the config ~/.oci/config file
```
export TENANT_OCID=tenantID
export USER_OCID=userID
export FINGERPRINT=fingerPrint
export PASSPHRASE=passphrase
```{{execute}}
***(Note. If you do not have a passphrase, it is not necessary to set that environment variable)***

## Oracle Events Configuration

In the tenant that you are using, there are a set of policies already in place, but if you are curious or if you are using your own environment you need to
create a set of polices that will allow users to create and manage rules

As we already mentioned, in the tenant you are using, those policies are already in place. If you want to learn
more about those policies take a look [here](https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsgetstarted.htm "Policies Concepts").

## Rule and Bucket creation using Oracle CLI

This is the list of things that we are going to create:

- Create a Topic
- Create a Suscription
- Create a Rule
- Create a Bucket that will trigger that Rule

For the Topic, execute this:

`oci ons topic create -c $COMPARTMENT_OCID --name Topic$LAB_ID`{{execute}}

Now let's get the Topic OCID:

```
export TOPIC_NAME=Topic$LAB_ID
export TOPIC_LIST=$(oci ons topic list -c $COMPARTMENT_OCID)
export TOPIC_ID=$(echo $TOPIC_LIST | jq -r --arg name $TOPIC_NAME '.data | map(select(."name" == $name)) | .[0] | .["topic-id"]')
```{{execute}}


Now we need to create a subscription to the previous Topic, and there we will configure our own email address to receive the notifications after the Bucket 
is created.

First set the following variable with your email address where you want to receive the notifications
`export YOUR_EMAIL="myname@me.com"`{{execute}}

Execute this:

`oci ons subscription create -c $COMPARTMENT_OCID --protocol EMAIL --subscription-endpoint $YOUR_EMAIL --topic-id $TOPIC_ID`{{execute}}

After this you should receive an email to confirm the subscription. Once you receive it click on the link to confirm it.

![Email Confirmation](/RedExpertAlliance/courses/oci-course/infrastructure-events-notifications-streaming-oci/assets/emailConfirmation.jpg)

You are all set, now in the next step we will create the Rule that will be triggered after the Bucket creation, and that will use the Topic and Subscription
previously created.
