Let's take a look at these custom metrics that were published just now. Open the Metrics Explorer in the console: Solutions and Platform | Monitoring | Metrics Explorer. 

This tool will open with a incomplete query that you need to complete. You need to set the compartment and the metrics namespace. In order to see metrics linked to a resource group, that resource group also has to be explicitly selected. Finally, the metric of interest – productOrder in this example – has to be set. The aggregation interval is set (the drop down list offers 1m, 5m and 1 hour; when you switch to Advanced Mode you can customize the interval in the MQL query definition). The Statistic (aggregation function) is to be selected – Sum is a common choice, although many options are available (min, max, mean, count, rate, P50, P90, P95, P99).

The next screenshot shows the graphical representation of the few custom data points that were just published through the CLI. Nothing impressive – but encouraging nevertheless. Custom business metrics in the OCI Monitoring framework.

![Custom Metrics in the Metrics Explorer](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-custom-metrics-explorer.png)

The Data Table view shows the *individual data points* for the selected resource group and the selected metric.

Alternatively, you can retrieve the metrics from the OCI CLI, using the next statement:

`oci monitoring metric-data summarize-metrics-data -c $compartmentId --namespace  mymetricsnamespace --resource-group  divisionX --query-text "productOrder[1m].count()"`{{execute}}

The result is a JSON response that in this example contains aggregated data points for the *productOrder* metric in namespace *mymetricsnamespace* and only for resource group *divisionX*. In this case, data points have been aggregated per 1 minute, resulting in three different timestamps. The values in the aggregated data points are the summation of the values reported for productOrders.

In the next step you will create an Alarm on the Custom Metric, to get notified when a specific business relevant situation occurs.

