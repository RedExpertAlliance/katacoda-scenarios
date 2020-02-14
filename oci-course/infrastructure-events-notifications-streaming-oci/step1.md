## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

The lab-compartment should be in place.

## Oracle Events Configuration

In the tenant that you are using, there are a set of policies already in place, but if you are curious or if you are using your own environment you need to
create a set of polices that will allow users to create and manage rules

As we already mentioned, in the tenant you are using, those policies are already in place. If you want to learn
more about those policies take a look [here](https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsgetstarted.htm "Policies Concepts").

To validate if your tenant has the policy with the previous statements execute the following:
`oci iam policy get --policy-id $POLICY_OCID`{{execute}}

(If you are using your own tenant go to the policy page and get the OCID.)

With the policy and statements in place, we are ready to create our first Rule that will be triggered after a Object Store Bucket is created.


## Rule and Bucket creation using Oracle CLI

This is the list of things that we are going to create:

- Create a Topic
- Create a Suscription
- Create a Rule
- Create a Bucket that will trigger that Rule

For the Topic, execute this:

`oci ons topic create -c $COMPARTMENT_OCID --name TopicCLITest$LAB_ID`{{execute}}

Now we need to create a subscription to the previous Topic, and there we will configure our own email address to receive the notifications after the Bucket 
is created.

Execute this:

`oci ons subscription -c $COMPARTMENT_OCID --protocol EMAIL --subscription-endpoint $YOUR_EMAIL --topic-id $TOPIC_ID`{{execute}}

After this you should receive an email to confirm the subscription. Once you receive it click on the link to confirm it.

![Email Confirmation](/RedExpertAlliance/courses/oci-course/infrastructure-events-notifications-streaming-oci/assets/emailConfirmation.jpg)


You are all set, now in the next step we will create the Rule that will be triggered after the Bucket creation, and that will use the Topic and Subscription
previously created.



