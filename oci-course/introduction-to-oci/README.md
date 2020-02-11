# Introducing Oracle Cloud Infrastructure 

This scenario introduces some of Oracle Cloud Infrastructure's core concepts. It will help you get an understanding of how to interact with and move around in OCI.

The scenario uses both the OCI Console (in your web browser) and the OCI CLI (the command line interface in the Katacoda scenario terminal) to interact with OCI.

Some of the concepts in this scenario:

* Tenancy, Region, Availability Domain
* Compartments
* Resources: OCID, Tags, Search
* OCI Command Line Interface tool
* OCI Browser Console
* Object Storage Service
* Users, Groups, Dynamic Groups, Policies

You will get an understanding for what the terms tenancy, region and availability domain mean and how they hang together. Initially, you will use the OCI Console - a browser based graphical user interface - for interacting with OCI. You will learn how to login and how move around in the Console. 

Virtually all OCI resources live in a *compartment*. You will learn more about these compartments, and create one yourself. In this new compartment, you will create a bucket - a container for objects in the Object Storage service. Then you will upload a file into this bucket.

It is easy to find resources, using the Search tool in the console. You can search by name, and by several other attributes. Or by user defined tags: any OCI resource can be further labeled using tags. These help with searching and grouping and also with billing, monitoring and security policies. You will create custom tags - and use them in searching. 

One attribute assigned to all OCI resources is OCID - the cloud wide identifier that uniquely designates any resource. You will learn about OCIDs.

In addition to the OCI console, you can interact with Oracle Cloud Infrastructure through the Command Line Interface or CLI. This CLI is stand alone application that you need to install on a computer, for example your laptop. You need to provide a configuration file to the CLI that define which cloud tenancy to interact with and which credentials to use for that. In this scenario, you will install the OCI CLI, provide a configuration file and then use the CLI to perform a number of look up operations and administrative actions.  

The CLI allows the same operations to be performed as the Console - using command line statements that lend themselves to being scripted. Automating management of OCI resources can be done using the OCI CLI - the term *infrastructure as code* is typically used for this type of automation. Infrastructure as Code on OCI can also be done using Terraform and the Terraform Provider for Oracle Cloud Infrastructure.

Note: the OCI CLI under the hood makes calls to the OCI REST APIs, the same that are used by the Console, the Terraform Provider for OCI and the SDKs that are available for several programming languages. These REST APIs can also be invoked directly by your own applications. Be aware that HTTP requests to these APIs need to be signed in a non trivial way.  

Access to OCI resources is arranged through common mechanisms: every actor interacting with OCI uses a user account with associated credentials (such as username and password for Console login and public/private key pair for CLI and REST API access). Users are member of groups and from these groups they inherit permissions to access OCI resources. These permissions are defined through policies. Policies contain statements that describe which permissions on which resources are granted to which actors. You will see some examples of policies and learn how to grant required access on OCI Resources to specific users.

A special type of group is a Dynamic Group. Dynamic groups allow you to group Oracle Cloud Infrastructure computer instances or other resources as "principal" actors (similar to user groups). Instead of a static collection of users, the composition of a Dynamic Group is dynamically determined based on conditions. Any resource that satisfies the condition is considered part of the group - for as long as the condition holds true. For example, a rule could specify that all compute instances in a particular compartment are members of the dynamic group. During the time that the condition holds true, the resource inherits the permissions granted to the Dynamic Group through policy statements. 

# Resource

Oracle Cloud Infrastructure - [Key Concepts and terminology](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)

OCI Docs - Managing Dynamic Groups - https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm