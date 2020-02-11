# Monitoring Metrics and Triggering Alarms for Exceptions 

Oracle Cloud Infrastructure services publish vast volumes of metrics on what is going on and how things are happening. These metrics provide insight in the health, usage and actual behavior of OCI resources such as Networks, Functions, VMs, API Gateways.

These metrics get published when functions are invoked, files are written, the API Gateway handles a request, events are published, a user is created and a network transfers a packet. The metrics are gathered in a big metrics lake inside OCI where they are retained for 14 days. By querying the Monitoring service for this data, you can understand how well the systems and processes are working to achieve the required service levels. 

Metrics can be inspected in the console using predefined charts and using the metrics explorer. Metrics can also be retrieved through the CLI and the REST API. Alarms can be defined with query conditions on the metrics; when an Alarm condition is satisfied, the alarm is 'sounded': it will publish a notification that results in an email being sent or a web hook being invoked.

In this scenario, you will look at OCI Resource metrics as well as custom metrics. 

You will first make some noise: by taking several actions through the Object Storage service, you make sure that there are some metrics generated for us to inspect. Then you will first retrieve the metrics through the Command Line Interface.

Next, you switch to the console. In he browser, you will use the Metrics Explorer to take a look at the same metrics - in out of the box charts and with additional filters applied.

You will then define an Alarm - a condition defined in terms of the metrics that we want to use to detect special situations or behavior. Special is anything we deem special: too much or too little activity, too large or too small files, too slow or too fast function execution. Any condition we can define using the metrics reported by OCI can be used for the Alarm.

The Alarm is association with a Notification Topic. When the Alarm is triggered because its condition has been met by actual metrics, this will be visible in he console. In order to also generate an action from the Alarm, a message is published by a triggering alarm to the Notification Topic. You will create a subscriber to the Notification Topic that sends an email to alert the recipient - you in this scenario - of the fact that the alarm is triggered. A notification topic can also invoke a Web Hook (any HTTP endpoint) to deliver a notification message.

Of course you will at that point perform some additional activity that should set of the alarm and cause the email to be sent your way.

Finally, you will be working with custom metrics. It is a common desire to not only monitor the behavior of VMs, network resources and other technical resources, but to also - and even primarily - keep an eye on the functional behavior of the system. To learn about the [trends and fluctuations in time of the] number of orders per product category and country, the increase in the number of tweets on the Corona virus in a city or province and the unexpected absence of traffic on a web site or API. This functional or business activity monitoring is supported by the OCI Monitoring service: You can publish your own metrics to Monitoring using the API. You can view charts of your published metrics using the Console , query metrics using the API, and set up alarms using the Console or API.You can access your published custom metrics the same way you access any other metrics stored by the Monitoring service.

Using the CLI, you will publish some custom metrics. These are processed, stored and exposed in the same way as regular OCI metrics. You will retrieve the custom metrics through the CLI and inspect them in the OCI console. As a bonus, you could define an Alarm in terms of custom metrics - creating a detection mechanism for purely functional situations with real business meaning. Such alarms publish notifications that can result in an email or Web Hook call.


## Resources

OCI Documentation - Publishing Custom Metrics: https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Tasks/publishingcustommetrics.htm

CLI Reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.1/oci_cli_docs/cmdref/monitoring/metric-data/post.html

REST API reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/api/#/en/monitoring/latest/MetricData/PostMetricData 

Policies governing publication and viewing metrics: https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm#metrics-access

Blog Article: Oracle Cloud Infrastructure Resource Monitoring – Alarm triggers Notification when Metrics satisfy Condition - https://technology.amis.nl/2020/02/03/oracle-cloud-infrastructure-resource-monitoring-alarm-triggers-notification-when-metrics-satisfy-condition/
