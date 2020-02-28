## Destroy

Let's remove the resources that we had Terraform create in this scenario. Again, enter *yes* when prompted.

`terraform destroy`{{execute}}

Terraform will remove from the OCI tenancy all resources described in the configuration files - and it will do so in the right order (first the file object, then the bucket that contains the file). 
