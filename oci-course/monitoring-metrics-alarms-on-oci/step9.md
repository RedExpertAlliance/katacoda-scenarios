Just as you can do with the standard OCI metrics, you can also create an alarm on custom metrics, that is used to trigger notification of special business circumstances.

You will now create an Alarm for the custom metric *productOrder* that will be triggered if and when the number of productOrders in a 5 minute time period is higher than 100.

The alarm is associated with the *lab-notification-topic-$LAB_ID* notification topic that was used in step 4 of this scenario - and that has a subscription for your email address.
```
oci monitoring alarm create --compartment-id=$compartmentId --display-name=TooManyProductOrders --destinations="[\"$ONS_TOPIC_OCID\"]"  --display-name="An extremely high number or product orders were received" --metric-compartment-id=$compartmentId --namespace="mymetricsnamespace"  --query-text="GetRequests[1m].count() > 3"  --severity="INFO" --body="The number of recent file download operations in compartment lab-compartment was excessive" --pending-duration="PT1M"  --resolution="1m" --is-enabled=true
```{{execute}}

Check out the alarm definition - and its current state - in the console (https://console.us-ashburn-1.oraclecloud.com/monitoring/alarms ) or through the CLI:

`oci monitoring alarm list --compartment-id=$compartmentId --output table`{{execute}}

![Alarm definition on Custom Metric](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-alarm-on-custom-metric.png)

To trigger the alarm, publish an additional set of productOrder metrics. 
First edit file *custom-metrics.json* again.

`custom-metrics.json`{{open}}

Replace the timestamps with somewhat more recent values. You could change some of the other details - such as the values (just not to very low numbers) and the product names.

Then execute this statement to publish these metrics:

`oci monitoring metric-data post --endpoint https://telemetry-ingestion.us-ashburn-1.oraclecloud.com --metric-data file://./custom-metrics.json`{{execute}}

This should set off the alarm - but remember that this takes about 90 seconds.