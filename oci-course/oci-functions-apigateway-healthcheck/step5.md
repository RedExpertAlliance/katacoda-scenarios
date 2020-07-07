 Create an Alarm for the Healthcheck Metrics

 In this final step, you will create an alarm that reports a notification when the average HTTP Processing time is longer than 3 seconds for the two healthchecks we have created. As stated before, we expect the healthcheck for function *hello2* (the cold function) to trigger the alarm.

 The steps we will go through:
* create notification topic *lab-notification-topic-$LAB_ID*
* create alarms for both healthchecks - associated with notification topic

This next command creates a Notification Topic called *lab-notification-topic-$LAB_ID*.
`oci ons topic create --compartment-id=$compartmentId --name=lab-notification-topic-$LAB_ID --description="notification topic gets notified for lab alarms"`{{execute}}

List all Notification Topics in compartment *lab-compartment* and verify that a new topic has been created:
`oci ons topic list --compartment-id=$compartmentId --output table`{{execute}}

Get hold of Topic OCID
```
export ONS_TOPIC_OCID=$(oci ons topic list --compartment-id=$compartmentId | jq -r --arg name "lab-notification-topic-$LAB_ID" '.data | map(select(."name" == $name)) | .[0] | ."topic-id"')
echo "OCID for the Notification Topic lab-notification-topic-$LAB_ID  = $ONS_TOPIC_OCID"
```{{execute}}

Create the two alarms:
```
oci monitoring alarm create --compartment-id=$compartmentId --display-name=lab-poor-function-hello1-response-$LAB_ID --destinations="[\"$ONS_TOPIC_OCID\"]"  --display-name="Function hello1 response takes a long time" --metric-compartment-id=$compartmentId --namespace="oci_faas"  --query-text="FunctionExecutionDuration[5m]{resourceDisplayName = \"lab1:$function1\"}.mean() > 3000"  --severity="INFO" --body="The execution of function hello1 took quite long" --pending-duration="PT5M"  --resolution="1m" --is-enabled=true

oci monitoring alarm create --compartment-id=$compartmentId --display-name=lab-poor-function-hello2-response-$LAB_ID --destinations="[\"$ONS_TOPIC_OCID\"]"  --display-name="Function hello2 response takes a long time" --metric-compartment-id=$compartmentId --namespace="oci_faas"  --query-text="FunctionExecutionDuration[5m]{resourceDisplayName = \"lab1:$function2\"}.mean() > 3000"  --severity="INFO" --body="The execution of function hello2 took quite long" --pending-duration="PT5M"  --resolution="1m" --is-enabled=true
```{{execute}}