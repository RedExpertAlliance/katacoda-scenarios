Users, Groups and Policies

Access to OCI resources is arranged through common mechanisms: every actor interacting with OCI uses a user account with associated credentials (such as username and password for Console login and public/private key pair for CLI and REST API access). Users are member of groups and from these groups they inherit permissions to access OCI resources. These permissions are defined through policies. Policies contain statements that describe which permissions on which resources are granted to which actors. You will see some examples of policies and learn how to grant required access on OCI Resources to specific users.

A special type of group is a Dynamic Group. Dynamic groups allow you to group Oracle Cloud Infrastructure computer instances or other resources as "principal" actors (similar to user groups). Instead of a static collection of users, the composition of a Dynamic Group is dynamically determined based on conditions. Any resource that satisfies the condition is considered part of the group - for as long as the condition holds true. For example, a rule could specify that all compute instances in a particular compartment are members of the dynamic group. During the time that the condition holds true, the resource inherits the permissions granted to the Dynamic Group through policy statements. 

### Instance Principal

Dynamic groups allow you to group Oracle Cloud Infrastructure instances as principal actors. You can then create policies to permit instances in these groups to make API calls against Oracle Cloud Infrastructure services. Membership in the group is determined by a set of criteria you define, called matching rules. *Instance Principals* are compute instances (typically VMs) that are members of a dynamic group and inherit from that group membership permissions. This allows any process or user on that VM to make calls to OCI REST APIs leveraging the inherited permissions. Any user who has access to the instance (who can SSH to the instance), automatically inherits the privileges granted to the instance. 

The OCI CLI as well as SDKs and the Terraform Provider understand the notion of Instance Principal. OCI CLI commands for example can be executed from within an instance principal without additional authentication. This mechanism is used in CloudShell.

For each API call made by an instance principal, the Audit service - discussed in the next step - logs the event, recording the OCID of the instance as the value of principalId in the event log.


## Resources

OCI Documentation [Getting Started with Policies](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/policygetstarted.htm)

OCI Documentation [Dynamic Groups](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)

OCI Documentation [Instance Principal](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm)