Tagging and Searching Resources

It is easy to find resources, using the Search tool in the console. You can search by name, and by several other attributes. Or by user defined tags: any OCI resource can be further labeled using tags. These help with searching and grouping and also with billing, monitoring and security policies. You will create custom tags - and use them in searching. 


Tagging

- defined tags: tag key is predefined; value can be free format string or selected from list
- predefined values (list of values to choose from)
- cost tracking tag (max 10 per tenancy); use to group and filter in Cost Analysis and Budgets
- tag namespace
- tag variables - resolve to actual value when a resource is created and the tag is attached (principal name, principal type and date time)
- tag defaults (for all resources created in a compartment)
- free form tags are key value pairs, freely added to a resource; they cannot be used in policies, they do not support predefined list of values or tag variables; they can be used to search on. They cannot be used for cost tracking.  

## Resources
Docs on Tagging OCI Resources - https://docs.cloud.oracle.com/en-us/iaas/Content/Tagging/Concepts/taggingoverview.htm 