It is easy to find resources, using the Search tool in the console. You can search by name, and by several other attributes. Or by user defined tags: any OCI resource can be further labeled using tags. These help with searching and grouping and also with billing, monitoring and security policies. You will create custom tags - and use them in searching. 

Type *innovation* in the search bar at the top of the console. Then press `enter`. The search is performed. The search tool looks at names and tags associated with resources as it performs the search. In this case, the bucket *bucket-LABID* that you created in the previous step with a *department* tag should be found.  
![Search](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-intro-search.png)

Click on the search result to be taken to the bucket details page. One of the details shown is the *OCID*, the identifier for the bucket. In the next step, you will learn more about OCIDs. Another element on this page is the button *Add Tags*. When you press this button, a popup page appears that allows you to add tags that further describe and categorize the bucket. 

## Tagging
OCI has two types of tags: 
* user defined for free format tags - a key value pair defined by the tagger
* defined tags - the tag key is predefined in a tag namespace by an administrator; the value can be a free format string or restricted and selected from a list

Tags are used - as you have seen -for searching. Other uses for tags:
* group and filter in Cost Analysis and Budgets - costs can be tracked, calculated and reported per group of resources, based on tags - if these tags are marked as cost tracking tags; only *defined tags* can be used for this (not free format tags) and up to 10 tags per  tenancy can be used for cost tracking; note that these ten tags can have an infinite number of different values. Examples of cost tracking tags: department, project, location, customer
* identify resources in policies - access permissions are defined in OCI through policies (more on this in step 9); policies can use tags to identify (groups of) resources for which a policy applies; only *defined tags* can be used in policies

To check out the tag namespaces that have currently been set up in the tenancy, go to Governance and Administration | Governance | Tag Namespaces in the menu or follow this link: https://console.us-ashburn-1.oraclecloud.com/identity/tag-namespaces.

![Tag Namespaces](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-tag-namespaces.png)

You should see the tags namespace *lab-tags*. Click on the name to drill down. You see the details for the namespace. Click on the button *Create Tag Definition*. A dialog appears for defining a tag. Create a tag called *region*. Check the box for *COST-TRACKING*. Select the option *A LIST OF VALUES* and define the *VALUES*: global, americas, emea and apac. This tag can be used to label resources with the imaginary region within our imaginary organization for which they are created and that should pay for them. This tag can be used to prepare cost statements grouped by region. It can also be used in security policies. Note: Defined tag keys are case insensitive.
Defined tag values are case sensitive. For example, "alpha" and "Alpha" are distinct values. 

![Create Defined Tag](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-created-defined-tag.png)

Click on button *Create Tag Definition*. The tag definition is created in the tag namespace.

Return to the bucket that you created in the previous step: navigate to Core Infrastructure | Object Storage | Object Storage, or use the direct URL for Ashburn: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets. Drill down to the bucket details page for *bucket-*LAB_ID*. Click on the button *Add Tags*. Now specify using the new defined tag *region* that this bucket is created specifically for region *americas*. 

![Add Tag to Bucket](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-add-tag-to-bucket.png)

After clicking *Add Tags*, the tag is added to the bucket. When you no inspect tab *Tags*, you will find three Defined Tags on the bucket and one free format tag. 

You can now search for *americas* and as expected, *bucket-LABID* would be returned. Through the Advanced Search facility, you can construct queries that search specifically for tags, for example:
```
query
  all resources
    where
      (definedTags.namespace = 'lab-tags' && definedTags.key = 'region' && definedTags.value = 'americas')
```
![Advanced Search](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-advanced-search.png)

The Cost Analysis page - https://console.us-ashburn-1.oraclecloud.com/account-management/cost-analysis - allows you to drill down to costs specially incurred on for resources with a specific value for a cost tracking tag. 
![Cost Analysis](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-cost-analysis-by-tag.png)


### Tag Defaults

Two of the defined tags from the namespace *Oracle-Tags* were added automatically when the bucket was created, because they have been defined as *Tag Defaults*. Tag defaults are tags that have been defined to be applied automatically to all resources, at the time of creation, in a specific compartment. This feature allows you to ensure that appropriate tags are applied at resource creation without requiring the user who is creating the resource to have access to the tag namespaces.Tag defaults are defined for a specific compartment, and in the Console you manage them on the Compartment Details page.  Tag defauls are inherited in nested compartments. For example, the two tags that were applied by default to the bucket created in *lab-compartment* were the result of default tags defined at root compartment level:  
![Tag Defaults](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-add-tag-defaults.png)

In the definition of Tag Defaults, you can use tag variables that resolve to actual value when a resource is created and the tag is attached. At the present, the available variables are ${oci.datetime}, ${iam.principal.name} and ${iam.principal.type}. 



## Resources
OCI Docs on [Tagging OCI Resources](https://docs.cloud.oracle.com/en-us/iaas/Content/Tagging/Concepts/taggingoverview.htm)
OCI Docs on [Tag Defaults](https://docs.cloud.oracle.com/en-us/iaas/Content/Tagging/Tasks/managingtagdefaults.htm)
OCI Docs on [Cost Tracking Tags](https://docs.cloud.oracle.com/en-us/iaas/Content/Tagging/Tasks/usingcosttrackingtags.htm)

