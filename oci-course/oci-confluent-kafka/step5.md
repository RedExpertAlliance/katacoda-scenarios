# Let's remove all of the resources we've created

**(If you want to keep all resources, there is no need to destroy them. But if your are following this for testing purposes, then we suggest you to delete everything, in order to avoid charege in your OCI tenant)**

With Terraform is very simple to destroy what you have created so far. You just need to execute this:

`terraform destroy`{{execute}}

And it will prompt you if you want to proceed, type: yes

~~~~
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
~~~~

It will start to destroy everything:

![](assets/destroy1.jpg)


You can validate that the resources are deleted, go to the Compute Instances section at your OCI console and you will see something like this:

![](assets/destroy2.jpg)

And when the terraform destroy command finish, it will print this:

~~~~
Destroy complete! Resources: 24 destroyed.
~~~~

All resources have been deleted from your tenant.

