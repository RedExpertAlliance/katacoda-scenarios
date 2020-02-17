In this step, you will create an *alarm* to observe exceptional metrics conditions. The alarm is associated with a *Notification Topic*; every time the alarm condition is met, a notification is published to this topic. In the next step, you will create a subscription on the topic. As a result, OCI will automatically send an email to your email address whenever the alarm condition is met and the alarm is triggered.

An alarm in OCI is based on a rule expressed in OCI metrics, using aggregation operators over time windows. That may sound abstract. The examples are pretty straightforward. Some examples of rules used for alarms:
```
The number of requests per 5 minute period to a function is larger than X
The average response time for requests to a specific VM is larger than Y miliseconds
The number of file downloads per hour from a bucket on Object Storage is smaller than Z
The minimum CPU Utilization per hour on a specific set of VMs is larger than Q %
```
When you define an alarm, you specify a name and description for the alarm and also the rule condition. This condition is expressed using a metric for either a specific resource or type of resource in the context of a compartment. The metric is aggregated over a specified period. This period is not shorter than one minute and not longer than one hour. The aggregation operators include Count, Sum, Min, Max, Mean, Rate and also P50, P90, P95, P99. The last four indicate the high water mark for at least 50, 90, 95 or 99% of all registered metrics for the given time window. The aggregated value is compared to a hard coded value  

TODO rule using tags??