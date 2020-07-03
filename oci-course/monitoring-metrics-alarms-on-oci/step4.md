In this step, you will create an *alarm* to observe exceptional metrics conditions. The alarm is associated with a *Notification Topic*; every time the alarm condition is met, a notification is published to this topic. In the next step, you will create a subscription on the topic. As a result, OCI will automatically send an email to your email address whenever the alarm condition is met and the alarm is triggered.

An alarm in OCI is based on a rule expressed in OCI metrics, using aggregation operators over time windows. That may sound abstract. The examples are pretty straightforward. Some examples of rules used for alarms:
```
The number of requests per 5 minute period to a function is larger than X
The average response time for requests to a specific VM is larger than Y miliseconds
The number of file downloads per hour from a bucket on Object Storage is smaller than Z
The minimum CPU Utilization per hour on a specific set of VMs is larger than Q %
```
When you define an alarm, you specify a name and description for the alarm and also the rule condition. This condition is expressed using a metric for either a specific resource or type of resource in the context of a compartment. The metric is aggregated over a specified period. This period is not shorter than one minute and not longer than one hour. The aggregation operators include Count, Sum, Min, Max, Mean, Rate and also P50, P90, P95, P99. The last four indicate the high water mark for at least 50, 90, 95 or 99% of all registered metrics for the given time window. The aggregated value is compared to a hard coded value  

The steps we will go through:
* create notification topic *lab-notification-topic-$LAB_ID*
* create alarm  *lab-alarm-rapid-file-download-$LAB_ID* - associated with notification topic

This next command creates a Notification Topic called *lab-notification-topic-$LAB_ID*.
`oci ons topic create --compartment-id=$compartmentId --name=lab-notification-topic-$LAB_ID --description="notification topic gets notified for lab alarms"`{{execute}}

List all Notification Topics in compartment *lab-compartment* and verify that a new topic has been created:
`oci ons topic list --compartment-id=$compartmentId --output table

Get hold of Topic OCID
```
export ONS_TOPIC_OCID=$(oci ons topic list --compartment-id=$compartmentId | jq -r --arg name "lab-notification-topic-$LAB_ID" '.data | map(select(."name" == $name)) | .[0] | ."topic-id"')
echo "OCID for the Notification Topic lab-notification-topic-$LAB_ID  = $ONS_TOPIC_OCID"
```{{execute}}

We need to pass the list of destinations for an alarm (one ore more notification topics) in a JSON document. To learn the format for this document, we can use the OCI CLI feature *--generate-param-json-input*. When we pass this switch and indicate the name of the parameter for which we want to learn the required format, we can make a call like the following one for *destinations*:
`oci monitoring alarm create  --generate-param-json-input destinations > destinations-param-sample.txt`{{execute}}

Inspect file
`destinations-param-sample.txt`{{open}}
to see the structure we need to provide for the *destinations* parameter. The expected JSON structure is simple enough: just an array of strings. So we can pass an array with as its only element a string containing the Topic's OCID. 

Create an alarm, associated with the *lab-notification-topic-$LAB_ID* notification topic and triggered by a fairly high (> 3) number of file downloads within one minute:
```
oci monitoring alarm create --compartment-id=$compartmentId --display-name=lab-alarm-rapid-file-download-$LAB_ID --destinations="[\"$ONS_TOPIC_OCID\"]"  --display-name="High rate of file downloads" --metric-compartment-id=$compartmentId --namespace="oci_objectstorage"  --query-text="GetRequests[1m].count() > 3"  --severity="INFO" --body="The number of recent file download operations in compartment lab-compartment was excessive" --pending-duration="PT1M"  --resolution="1m" --is-enabled=true
```{{execute}}

Check out the alarm definition - and its current state - in the console :
`echo "Open the Console at URL https://console.$REGION.oraclecloud.com/monitoring/alarms"`{{execute}}

or through the CLI

`oci monitoring alarm list --compartment-id=$compartmentId --output table`{{execute}}

![Alarm Definition](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-alarm-definition.png)


