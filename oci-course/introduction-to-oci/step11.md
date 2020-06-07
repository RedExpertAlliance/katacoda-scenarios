You might be interested in specific activities that happened in the tenancy or compartment and who was responsible for the activity. You will want to know the approximate time and date something happened and the compartment in which it happened. 

Check in the console: Governance and Administration | Governance | Audit or at https://console.us-ashburn-1.oraclecloud.com/audit/events to see the audit trail with all recent tracked OCI events in the *lab-compartment*:

![Audit Trail](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-audit-trail.png)

Note that all operations - whether they took place via the Console or through the Command Line Interface - are expressed in terms of REST API calls - GET, POST, PUT, DELETE - for Read, Create, Update and Delete.

Audit details can also be retrieved through the API and the CLI, like this:
`oci audit event list --compartment-id=$compartmentId --end-time=2020-06-09 --start-time=2020-06-11`{{execute}}
You need to update the dates in start-time and end-time.

Note that retrieving the audit trail itself is an event that is part of the audit trail.


## Resources
OCI Documentation on [Audit](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/usingaudit.htm) and [Viewing Log Events](https://docs.cloud.oracle.com/en-us/iaas/Content/Audit/Tasks/viewinglogevents.htm)