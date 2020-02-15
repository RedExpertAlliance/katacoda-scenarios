In this and other scenarios as well as in many screens in the console you will find the acronym *OCID*. The OCID is an Oracle-assigned unique ID called an Oracle Cloud Identifier (OCID). (Almost) All OCI resources are identified by such an OCID and can be referred to with an OCID. 

This is an example of an OCID for an Autonomous Database instance:
`ocid1.autonomousdatabase.oc1.iad.abuwcljrkvawrij4hoeqf5f6ir4do4noafksiyfjxevi4pw3j7zuvtz6ycyq`

The OCID is a fairly long string. It is composed in a structured way:
`ocid1.<RESOURCE TYPE>.<REALM>.[REGION][.FUTURE USE].<UNIQUE ID>`

* ocid1: The literal string indicating the version of the OCID.
* resource type: The type of resource (for example, instance, volume, vcn, subnet, user, group, and so on).
* realm: The realm the resource is in. A realm is a set of regions that share entities. Possible values are oc1 for the commercial realm, oc2 for the Government Cloud realm, or oc3 for the Federal Government Cloud realm. The regions in the commercial realm (OC1) belong to the domain oraclecloud.com. The regions in the Government Cloud (OC2) belong to the domain oraclegovcloud.com.
* region: The region the resource is in (for example, phx, iad, eu-frankfurt-1). With the introduction of the Frankfurt region, the format switched from a three-character code to a longer string. This part is present in the OCID only for regional resources or those specific to a single availability domain. If the region is not applicable to the resource, this part might be blank (see the example tenancy ID below).
* future use: Reserved for future use. Currently blank.
* unique ID: The unique portion of the ID. The format may vary depending on the type of resource or service.

You do not really need to be able to interpret OCID values. It is useful however to know what they are and what they are used for. 

For most of the OCI resources you create, you can optionally assign a display name. It can be a friendly description or other information that helps you easily identify the resource. The display name does not have to be unique, and you can change it whenever you like. The Console shows the resource's display name along with its OCID.

## Resources

OCI Documentation on [Resource Identifiers such as OCID](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm)