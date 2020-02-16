Metrics are published by virtually all OCI services- about the health, capacity, and performance of your cloud resources. These metrics get published when functions are invoked, files are written, the API Gateway handles a request, events are published, a user is created and a network transfers a packet. By querying the Monitoring service for this data, you can understand how well the systems and processes are working to achieve the service levels you commit to your customers. For example, you can monitor the CPU utilization and disk reads of your Compute instances . You can then use this data to determine when to launch more instances to handle increased load, troubleshoot issues with your instance, or better understand system behavior.

You can publish your own metrics to Monitoring using the API. You can view charts of your published metrics using the Console , query metrics using the API, and set up alarms using the Console or API.You can access your published custom metrics the same way you access any other metrics stored by the Monitoring service. 

Metrics are retained for 14 days.

In this scenario, you will look at OCI Resource metrics as well as custom metrics. You will perform some activities that make sure some metrics are produced and then you will inspect these metrics through the OCI Monitoring facilities. Subsequently, you will look at Alarms and Notifications and cause these to be triggered.

# Resources
[OCI Documentation on Metrics and Monitoring](https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Concepts/monitoringoverview.htm)

OCI Documentation - Publishing Custom Metrics: https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Tasks/publishingcustommetrics.htm

CLI Reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.1/oci_cli_docs/cmdref/monitoring/metric-data/post.html

REST API reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/api/#/en/monitoring/latest/MetricData/PostMetricData 
