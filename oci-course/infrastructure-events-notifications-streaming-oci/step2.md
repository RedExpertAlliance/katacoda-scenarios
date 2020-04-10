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
export TOPIC_LIST=$(oci ons topic list -c $COMPARTMENT_OCID --all)
export TOPIC_NAME=Topic$LAB_ID
export TOPIC_ID=$(echo $TOPIC_LIST | jq -r --arg name $TOPIC_NAME '.data | map(select(."name" == $name)) | .[0] | .["topic-id"]')
echo "The TopicID is: $TOPIC_ID"
```{{execute}}


Now we need to create a subscription to the previous Topic, and there we will configure our own email address to receive the notifications after the Bucket 
is created.

First set the following variable with your email address where you want to receive the notifications
`export YOUR_EMAIL="myname@me.com"`{{execute}}

Execute this:

`oci ons subscription create -c $COMPARTMENT_OCID --protocol EMAIL --subscription-endpoint $YOUR_EMAIL --topic-id $TOPIC_ID`{{execute}}

After this you should receive an email to confirm the subscription. Once you receive it, click on the link to confirm it.

![Email Confirmation](/RedExpertAlliance/courses/oci-course/infrastructure-events-notifications-streaming-oci/assets/emailConfirmation.jpg)

You are all set, now in the next step we will create the Rule that will be triggered after the Bucket creation, and that will use the Topic and Subscription
previously created.