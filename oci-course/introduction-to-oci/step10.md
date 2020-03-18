Access to OCI resources is arranged through common mechanisms: every actor interacting with OCI uses a user account with associated credentials (such as username and password for Console login and public/private key pair for CLI and REST API access). Users are member of groups and from these groups they inherit permissions to access OCI resources. These permissions are defined through policies. Policies contain statements that describe which permissions on which resources are granted to which actors. You will see some examples of policies.

![Users, Groups and Policies](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-users-groups-policies.png)

Policies can grant access on specific resources or on a type of resource - for example buckets or objects. In the latter case, the policy will usually grant a permission in the context of a specific compartment - and all its nested compartments. Some policies are defined to have an effect throughout the tenancy, for example the policy to manage users.  A basic feature of policies is the concept of inheritance: Compartments inherit any policies from their parent compartment. The simplest example is the Administrators group, which automatically comes with an OCI tenancy (see The Administrators Group and Policy). There's a built-in policy that enables the Administrators group to do anything in the tenancy:
`Allow group Administrators to manage all-resources in tenancy`. 

To check the details for user *lab-user* in the console, click on the person icon in the upper right hand corner. Open the drop down menu and click on *lab-user*. 
![Users, Groups and Policies](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-check-user-details.png)
You are taken to the page with user details.

![Users, Groups and Policies](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-lab-user-details.png)

Copy the OCI for user *lab-user* to the clipboard. Back in the Katacoda terminal, execute this command:
`USER_OCID=ocidFromClipboard`{{execute}}

Then you can retrieve the user details with:

`oci iam user get --user-id=$USER_OCID`{{execute}}

The user is member of a group called *lab-participants*. As user *lab-user* you cannot see this - as it is the administrator's turf. The user *lab-user* can perform different types of operations - such as creating buckets and uploading files - because of policies that were set up to grant permissions to group *lab-participants*. Some of these policies are listed here:

```
Allow group lab-participants to manage compartments in compartment lab-compartment
Allow group lab-participants to use object-family in compartment lab-compartment
Allow group lab-participants to manage buckets in compartment lab-compartment
Allow group lab-participants to manage objects in compartment lab-compartment
Allow group lab-participants to use tag-namespaces in tenancy
Allow group lab-participants to read audit-events in compartment lab-compartment
```

### Dynamic Group

A special type of group is a Dynamic Group. Dynamic groups allow you to group Oracle Cloud Infrastructure computer instances or other resources as "principal" actors (similar to user groups). Instead of a static collection of users, the composition of a Dynamic Group is dynamically determined based on conditions. Any resource that satisfies the condition is considered part of the group - for as long as the condition holds true. For example, a rule could specify that all compute instances in a particular compartment are members of the dynamic group. During the time that the condition holds true, the resource inherits the permissions granted to the Dynamic Group through policy statements. A dynamic group is also used to grant an API Gateway the right to invoke functions in a specific compartment. 

### Instance Principal

Dynamic groups allow you to group Oracle Cloud Infrastructure instances as principal actors. You can then create policies to permit instances in these groups to make API calls against Oracle Cloud Infrastructure services. Membership in the group is determined by a set of criteria you define, called matching rules. *Instance Principals* are compute instances (typically VMs) that are members of a dynamic group and inherit from that group membership permissions. Sometimes the term *jumpbox* is used instead to identify a VM from which cloud resources can be accessed. This allows any process or user on that VM to make calls to OCI REST APIs leveraging the inherited permissions. Any user who has access to the instance (who can SSH to the instance), automatically inherits the privileges granted to the instance. 

The OCI CLI as well as SDKs and the Terraform Provider understand the notion of Instance Principal. OCI CLI commands for example can be executed from within an instance principal without additional authentication. This mechanism is used in CloudShell.

For each API call made by an instance principal, the Audit service - discussed in the next step - logs the event, recording the OCID of the instance as the value of principalId in the event log.


## Resources

OCI Documentation [Getting Started with Policies](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/policygetstarted.htm)

OCI Documentation [Dynamic Groups](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)

OCI Documentation [Instance Principal](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm)