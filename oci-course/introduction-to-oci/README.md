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

<TODO>
Add CLI
Add users, groups, dynamic groups, Policies

# Resource

Oracle Cloud Infrastructure - [Key Concepts and terminology](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)
