Just as you can do with the standard OCI metrics, you can also create an alarm on custom metrics, that is used to trigger notification of special business circumstances.

You will now create an Alarm for the custom metric *productOrder* that will be triggered if and when the number of productOrders in a 5 minute time period is higher than 100.

The alarm is associated with the *lab-notification-topic-$LAB_ID* notification topic that was used in step 4 of this scenario - and that has a subscription for your email address.
```
oci monitoring alarm create --compartment-id=$compartmentId --display-name=TooManyProductOrders --destinations="[\"$ONS_TOPIC_OCID\"]"  --display-name="An extremely high number or product orders were received" --metric-compartment-id=$compartmentId --namespace="mymetricsnamespace"  --query-text="productOrder[5m].sum() > 100"  --severity="INFO" --body="High order volume alert: The number of products ordered over a 5 minute period exceeded 100." --pending-duration="PT1M"  --resolution="1m" --is-enabled=true  --resource-group="divisionX"
```{{execute}}

Check out the alarm definition - and its current state - in the console: 
`echo "Open the console at https://console.$REGION.oraclecloud.com/monitoring/alarms"`{{execute}}

or through the CLI:

`oci monitoring alarm list --compartment-id=$compartmentId --output table`{{execute}}

![Alarm definition on Custom Metric](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-alarm-on-custom-metric.png)

To trigger the alarm, publish an additional set of productOrder metrics. 
First edit file *custom-metrics.json* again.

`custom-metrics.json`{{open}}

Replace the timestamps with somewhat more recent values. You could change some of the other details - such as the values (just not to very low numbers) and the product names.

Then execute this statement to publish these metrics:

`oci monitoring metric-data post --endpoint https://telemetry-ingestion.$REGION.oraclecloud.com --metric-data file://./custom-metrics.json`{{execute}}

This should set off the alarm - but remember that it takes some time (several minutes) to be activated. You can check the alarm status in the console https://console.us-ashburn-1.oraclecloud.com/monitoring/alarms/status or through the CLI. You can also sit back and relax and wait for that email alert to arrive.