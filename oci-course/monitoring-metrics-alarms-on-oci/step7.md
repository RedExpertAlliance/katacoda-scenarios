You can publish your own custom metrics to OCI Monitoring using the API. You can view charts of your published metrics using the Console, query metrics using the API, and set up alarms using the Console or API. You can access your published custom metrics the same way you access any other metrics stored by the Monitoring service. 

This picture gives an overview - using Product Orders as an example.
![Custom Metrics Overview](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-custom-metrics-alarm.png)

For example, to monitor business process health, one of the KPIs is number of orders, in addition to order volume. This KPI can be delivered from a reporting system that works on a data warehouse, looking back potentially quite far in time. It can also be monitored as it happens - using custom operational metrics and a framework for processing thus metrics

As a developer, you can capture this type of KPI from your applications using custom metrics on OCI. Simply record observations every time an application transaction takes place and then post that data to the Monitoring service. Custom metrics should be defined with aggregation in mind. While custom metrics can be posted as frequently as every second, the minimum aggregation interval is one minute. The datapoint timestamps must be between 2 hours ago and 10 minutes from now. The metrics are gathered in a big metrics lake inside OCI where they are retained for 14 days.

To see an example of the JSON data structure that should be sent as part of the command to publish custom metrics, make this call using the *generate-param-json-input metric-data* switch. This switch instructs the OCI CLI to write a dummy yet complete JSON command for the oci command:

`oci monitoring metric-data post --generate-param-json-input metric-data`{{execute}}

Open file *custom-metrics.json*. This file contains custom metrics that describe the number of orders placed per product and per Division. Orders are further described by dimension *country* and with meta data tags *category* and *note*. The metrics are published in the context of a predefined, custom metrics namespace *mymetricsnamespace*. The namespaces are collections of somewhat related metrics, separated from completely unrelated metrics. Note that the metrics namespace needs to be explicitly named in a policy statement through which a group is granted permissions regarding publishing custom metrics.

`custom-metrics.json`{{open}}

Replace two occurrences of `$compartmentId` in this file with the value of the compartment OCID:
`echo compartment OCID= $compartmentId`{{execute}}

Replace the timestamps with values that are less than two hours ago.

To post the metrics defined in this file to OCI, execute this statement:

`oci monitoring metric-data post --endpoint https://telemetry-ingestion.us-ashburn-1.oraclecloud.com --metric-data file://./custom-metrics.json`{{execute}}

If your tenancy is not associated with region Ashburn, you need to use a different endpoint for publishing the custom metrics to. Note: for this to work, a policy has to have been granted to a group your user is a member of defined like this:
`Allow group lab-participants to use metrics in tenancy where target.metrics.namespace='mymetricsnamespace'`

## Resources

Blog article [Use OCI Monitoring, Alarms and Notifications for Your Own Custom and Functional Metrics](https://technology.amis.nl/2020/02/10/use-oci-monitoring-alarms-and-notifications-for-your-own-custom-and-functional-metrics/)