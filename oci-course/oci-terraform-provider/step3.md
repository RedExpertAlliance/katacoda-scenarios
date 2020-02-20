The OCI Console is the browser based GUI for managing Oracle Cloud Infrastructure. You probably have worked before with OCI Console, for example in the scenario Introduction to OCI. We will now use the Metrics Explorer, a tool in the OCI Console that allows exploring, analyzing and visualizing metrics collected in the OCI Metrics lake.

Open the OCI Console - for tenancies subscribed to the Ashburn region, the URL is:

https://console.us-ashburn-1.oraclecloud.com/

Login using the console credentials provided by the lab instructor.

Navigate to the Metrics Explorer: in the *hamburger menu*, select Solutions and Platform | Monitoring | Metrics Explorer, or go straight to: https://console.us-ashburn-1.oraclecloud.com/monitoring/explore.

Select *oci_objectstorage* as the Metrics Namespace and *PutRequests* as the metric. Set the *Interval* to *1m* and select *Count* as the *statistic*. Press *Update Chart* to get a chart of the most recent numbers of PutRequests (per one minute interval). Use the Quick Select *Last Hour*.

![Metrics Explorer](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-metrics-explorer.png)

Feel free to Adjust the X-axis (to zoom in) on an even shorter time window. Change the metric, to for example look at the number of file downloads (GetRequests) or the (Max) TotalRequestLatency.

Toggle to *Show Data Table* to get a list of metrics data points. 

If you click on *Advanced Mode*, you can edit the queries in MQL (Monitoring Query Language). This allows you for example to use custom aggregation time windows.

## Resources

OCI Documentation [To edit a query using MQL syntax](https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Tasks/buildingqueries.htm#MQLEdit)

