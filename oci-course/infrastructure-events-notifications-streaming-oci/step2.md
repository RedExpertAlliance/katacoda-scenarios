# Rule creation

In the previous step we validated that the policies and statements were all set to create and manage rules.
We also configured our first Topic and Subscription (email based). 

Now, we are going to create our first rule, that will be triggered after a Object Storage Bucket creation.

To create the rule go the menu: Solutions and Platform group, go to Application Integration and click om Events Service.
Then, select the compartment that the Instructor has assigned to you, or if your are using your own tenant, go to the compartment that you defined.
Once in the compartment, click on the Create Rule button. In that page, define:

- The name for your rule. For example: BucketCreationRule{LabID}
- A short description for your rule

Then the interesting part has arrived, we are going to determine the conditions that needs to be met in order to trigger the rule that will notifies us 
after a bucket creation.

In the next section of the Create Rule page, we will find Rule Conditions. 
We will configure two chain conditions with the following definitions:

1. First Condition.
	- Condition Type combo, select: Event Type
	- Service Name combo, select: Object Storage
	- Event Type, select: Bucket Creation
2. Second Condition.
	- Condition Type combo, select: Attribute
	- Attribute name combo, select: resourceName
	- Attribute values combo, select: myBucket{LabID}
	
You should had noticed that the second condition contained different values, compared to the first condition. The reason is that the second combo is always 
going to be affected depending on what you chose in the first one. In this case, we used Object Storage as the Service Name, and therefore, in the second 
condition, the Attribute name combo contained the values: availabilityDomain, compartmentId, compartmentName, eTag, namespace, publicAccessType, resourceid,
resourceName. Which are values that will be contained in the event envelope. But if instead of chosing Object Storage, you chose Functions (for example), then
the list of attribute names will be different.

Then is the Actions section, here we will define which action take after the conditions are met. We have three options:

- Streaming
- Notifications
- Functions

(In this step we will use Notifications, but in the up coming steps you will test the Functions option).

After we have selected Notifications, select the compartment where you've created the Topic, and finally choose your Topic (topic{LabID}).

You should had noticed that you can incorporate more than one action, which is a pretty good functionality, since you can chain different actions, not
only notify someone, but maybe execute something via a Function.

Now just click on the Create Rule button.

We are all set with our first Rule, now let's create a Bucket and see if we receive the notification.

Let's use the CLI for creating the bucket (you need the OCID for your compartment, and the remember to include your LabID after the bucket name):

`oci os bucket create -c ocid1.compartment.oc1..625m6yxz567qsecqxu5cqpc5ypyjum4gccynrmiqf2a --name myBucketLabID`{{execute}}

You should had received the email notification, since the two conditions were met: Bucket creation and the name of the Bucket. The email body should look
something like this:

~~~~
{
  "eventType" : "com.oraclecloud.objectstorage.createbucket",
  "cloudEventsVersion" : "0.1",
  "eventTypeVersion" : "2.0",
  "source" : "ObjectStorage",
  "eventTime" : "2020-02-12T03:47:42.885Z",
  "contentType" : "application/json",
  "data" : {
    "compartmentId" : "ocid1.compartment.oc1..2432422342asddfsaf",
    "compartmentName" : "funcscompgb",
    "resourceName" : "myBucket",
    "resourceId" : "/n/idi66ekilhnr/b/",
    "availabilityDomain" : "IAD-AD-3",
    "additionalDetails" : {
      "bucketName" : "myBucket",
      "publicAccessType" : "NoPublicAccess",
      "namespace" : "idi66ekilhnr",
      "eTag" : "aac9e2c9-e907-40e6-8178-e7f951c57c4a"
    }
  },
  "eventID" : "208dc368-219a-477e-eac7-a665c00c2013",
  "extensions" : {
    "compartmentId" : "ocid1.compartment.oc1..23422asfsafsafsafdf"
  }
}
~~~~

Simple, right? Now let's use the Events but mixing them with Oracle Functions.

