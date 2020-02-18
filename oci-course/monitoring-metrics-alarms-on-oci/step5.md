The messages published to a subscription  by an alarm - or from any other type of source - need to be delivered to subscribers in order to be meaningful. Notification Topics can have one of three types of delivery:
* email address 
* PagerDuty
* WebHook / HTTP endpoint (such as a Function behind an API Gateway)
* Slack

YOUR_EMAIL_ADDRESS=your.mail@a.com

oci ons subscription create --compartment-id=$compartmentId --protocol EMAIL  --subscription-endpoint $YOUR_EMAIL_ADDRESS --topic-id $ONS_TOPIC_OCID 

Create email subscription on notification topic

You will receive an email

![Confirmation Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-subscription-confirmation.png)

If you now check in the console for the Notification Topic, you will find a subscription created under it:
https://console.us-ashburn-1.oraclecloud.com/notification/topics

![Confirmation Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-email-subscription.png)

Now publish a message to the notification topic - and find that an email is sent as a result to the email address in the topic subscription:

`oci ons message publish --body "Hello through Notification Topic" --topic-id $ONS_TOPIC_OCID  --title "Notification for you "`{{execute}}

![Notification Email](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-notification-email.png)



