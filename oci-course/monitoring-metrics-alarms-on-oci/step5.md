The messages published to a notification topic by an alarm - or from any other type of source - need to be delivered to subscribers in order to be meaningful. Notification Topics can have one of three types of delivery subscriptions:
* email address 
* PagerDuty
* WebHook / HTTP endpoint (such as a Function behind an API Gateway)
* Slack
* Function

You will now create a subscription to notification topic *lab-notification-topic-$LAB_ID* to deliver messages to your email address. Set an email address where you want to receive subscriptions in environment variable YOUR_EMAIL_ADDRESS: 
`YOUR_EMAIL_ADDRESS=your.mail@a.com`{{execute}}

Using the next command, create a subscription for your email address on the notification topic:
`oci ons subscription create --compartment-id=$compartmentId --protocol EMAIL  --subscription-endpoint $YOUR_EMAIL_ADDRESS --topic-id $ONS_TOPIC_OCID`{{execute}} 

You will now receive an email at the email address. You are requested to confirm that indeed you have signed up your email address for delivery of notification messages. This is to prevent anyone from abusing OCI Notifications for spamming your innocent email address.

![Confirmation Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-subscription-confirmation.png)

Until you confirm the subscription, no additional emails are sent your way. Note that this request for confirmation may have arrived in your spam or junk folder.

If you now check in the console for the Notification Topic, you will find a subscription created under it:
https://console.us-ashburn-1.oraclecloud.com/notification/topics

![Confirmation Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-email-subscription.png)

Publish a message to the notification topic using the next command. Feel free to change the body or title of this message.

`oci ons message publish --body "Hello through Notification Topic" --topic-id $ONS_TOPIC_OCID  --title "Notification for you "`{{execute}}

You should now find that an email is sent as a result to the email address in the topic subscription, proving that the configuration is correct and confirmed:
![Notification Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-notification-email.png)

In the next step, you will trigger the alarm and cause an informational email to be sent.

## Resources
OCI Docs [CLI - Publish message to notification topic](https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.2/oci_cli_docs/cmdref/ons/message/publish.html)