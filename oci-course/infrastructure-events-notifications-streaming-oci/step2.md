# Rule creation

In the previous step we validated that the policies and statements were all set to create and manage rules.
We also configured our first Topic and Subscription (email based). 

Now, we are going to create our first rule, that will be triggered after a Object Storage Bucket creation.

Before that, open the file *actions.json* and edit the value for element topicId, with the one we got in Step 1.
`echo $TOPIC_ID`{{execute}}

Set the value of the variable $MY_BUCKET:

`export MY_BUCKET=myBucket$LAB_ID`{{execute}}

Then, to create the rule, execute the following:
`oci events rule create --display-name myBucketCreation$LAB_ID --is-enabled true --condition '{"eventType":["com.oraclecloud.objectstorage.createbucket"], "data": {"resourceName":"'"$MY_BUCKET"'"}}' --compartment-id $COMPARTMENT_OCID --actions file://actions.json`{{execute}}

With this single CLI command we have created:
- A rule with the name myBucketCreation$LAB_ID
- A condition associated with the rule that needs to be met to trigger an action. The condition is that the bucket created name needs to be named 
as myBucket$LAB_ID
- The action is defined in the actions.json file, whose contents are:

~~~~
{
  "actions": [
    {
      "actionType": "ONS",
      "description": "Send an email notification when a Bucket with name myBucketCreation$LAB_ID is created",
      "isEnabled": true,
      "topicId": "ocid1.onstopic.oc1.iadadfasfd"
    }
  ]
}
~~~~

The elements in the actions file, are:
- actionType. In this case ONS (Oracle Notification Services). Other options are FAAS (see Step 3), and OSS (Streaming).
- description. A brief description of what the actions is going to perform
- isEnabled. If you want to enable it as it is created, you can use true, if not, use false
- topicId. You need to get the topicId from the previous step (Step 2)

(In this step we will use Notifications, but in the up coming steps you will test the Functions option).

You should had noticed that you can incorporate more than one action (the json file contains an array), which is a pretty good functionality, since you can 
chain different actions, not only notify someone, but maybe execute something via a Function.

We are all set with our first Rule, now let's create a Bucket and see if we receive the notification.

Let's use the CLI for creating the bucket (the name of the bucket is in the MY_BUCKET variable):

`oci os bucket create -c $COMPARTMENT_OCID --name $MY_BUCKET`{{execute}}

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
    "compartmentName" : "lab-compartment",
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

![Email Event](/RedExpertAlliance/courses/oci-course/infrastructure-events-notifications-streaming-oci/assets/emailEvent2.jpg)


This is an standard based event envelope defined by the CNCF, for more details take a look at [here](https://github.com/cloudevents/spec "cloudevents envelope").


Simple, right? Now let's use the Events but mixing them with Oracle Functions.

