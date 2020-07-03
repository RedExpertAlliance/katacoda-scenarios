An important aspect of Cloud Ops (Operations) is knowing what is happening in the platform and applications under scrutiny. Key metrics provide insight in current state of and trends in performance. Having access to the right metrics and being to trigger automated alarms in case of violations of specific conditions is a necessity for efficient and effective monitoring.

Metrics are published by virtually all OCI services- about the health, capacity, and performance of your cloud resources. These metrics get published when functions are invoked, files are written, the API Gateway handles a request, events are published, a user is created and a network transfers a packet. By querying the Monitoring service for this data, you can understand how well the systems and processes are working to achieve the service levels you commit to your customers. For example, you can monitor the CPU utilization and disk reads of your Compute instances . You can then use this data to determine when to launch more instances to handle increased load, troubleshoot issues with your instance, or better understand system behavior.

You can publish your own metrics to Monitoring using the API. You can view charts of your published metrics using the Console , query metrics using the API, and set up alarms using the Console or API.You can access your published custom metrics the same way you access any other metrics stored by the Monitoring service. 

Metrics are retained for 14 days.

In this scenario, you will look at standard *OCI Resource metrics* as well as custom metrics. You will perform some activities that make sure some metrics are produced and then you will inspect these metrics through the OCI Monitoring facilities. Subsequently, you will look at Alarms and Notifications and cause these to be triggered. Notification topics can be subscribed to - by email subscribers, Slack and PagerDuty, WebHooks and OCI Functions. All of these channels can be triggered by a message published to the Notification Topic.

You will also briefly look at the Audit service, that also provides insight in activity on the OCI tenancy from the perspective of Who did What at Which moment. And finally you will make a brief acquaintance with the Health Checks service that allows us to monitor the health of services anywhere in the world *from anywhere in the world*. 

# Resources
[OCI Documentation on Metrics and Monitoring](https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Concepts/monitoringoverview.htm)

OCI Documentation - Publishing Custom Metrics: https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Tasks/publishingcustommetrics.htm

CLI Reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.1/oci_cli_docs/cmdref/monitoring/metric-data/post.html

REST API reference for publishing custom metrics: https://docs.cloud.oracle.com/en-us/iaas/api/#/en/monitoring/latest/MetricData/PostMetricData 

[OCI Documentation on Audit Service](https://docs.cloud.oracle.com/en-us/iaas/Content/Audit/Concepts/auditoverview.htm)

[OCI Documentation on Health Checks](https://docs.cloud.oracle.com/en-us/iaas/Content/HealthChecks/Concepts/healthchecks.htm)
