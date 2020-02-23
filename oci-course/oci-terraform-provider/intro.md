Infrastructure as code is a term used to describe the automation of infrastructure resource management in a similar way as is done with CI/CD deployment pipelines for application components. By describing infrastructure resources in scripts - human readable and machine interpretable - the actual creation and modification of software defined infrastructure resources (such as the resources on Oracle Cloud Infrastructure) can be handled by automated facilities.  

Terraform is a tool that allows you to programmatically manage, version, and persist your IT infrastructure as "infrastructure as code." Terraform uses declarative syntax to describe your infrastructure and then persist it in configuration files that can be shared, reviewed, edited, versioned, preserved, and reused.

The Oracle Cloud Infrastructure Terraform provider is a component that connects Terraform to the service infrastructure that you wish to manage.

In this scenario, you will make your first steps with OCI Provider for Terraform as tool for automating OCI Resource management. You will see how Terraform configuration files are used to describe the desired state of OCI resources and how Terraform through the OCI Provider knows how to turn that desired state into the real state. The provider will work through the OCI REST APIs to inspect the current state of resources, create new resources, update existing resources and even delete resources. 

# Resources
[OCI Documentation on Terraform Provider](https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm)