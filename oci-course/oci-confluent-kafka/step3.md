# Let's get the terraform plans from github

Download Terraform plans from https://github.com/oracle-quickstart/oci-confluent.git
`git clone https://github.com/oracle-quickstart/oci-confluent.git`{{execute}}

**All credits on the authors of the terraform plans, we've made a fork to change the variables.tf file to convey with the instructions on this scenario**

The repository includes the terraform plans for both Confluent Community and Enterprise edition. In this scenario we will use Community edidtion. 
Let's go the the path where the terraform plan is located:

`cd ./oci-confluent/community`{{execute}}

And now initialize the Terraform provider:

`terraform init`{{execute}}

Note: the file `variables.tf` contains the OCI Provider for Terraform. When no variables are defined for the provider, it will attempt to find the file ~/.oci/config and use the settings from the DEFAULT config. When that files exists and has the right entries, you do not need to define fingerprint, tenancy_ocid and other configuration variables in the provider.
That is exactly what we did in the previous step: we setup the variables and we also created our oci config file.

File `variables.tf`{{open}} contains the OCI provider definition and is also - by convention - the place for global variable definitions and constants that can be used throughout the other *.tf files*. The values of variables can be determined by Terraform in several ways (in this order):
* taken from values passed on the command line through the `-var 'variable-name=value'` syntax 
* in a `.tfvars` file (specified on the command line or automatically loaded)
* read from an Environment Variable called *TF_VAR_name-of-variable*
* taken from the default value

In this case since all variables are already set for our terraform provider there is nothing extra to configure, but to execute the plan.


# Terraform Plan Execution

Now let's validate the plan:

`terraform plan`{{execute}}

Something like this will appear:

~~~~
Generating public/private rsa key pair.
Enter file in which to save the key (/root/keys):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
The key fingerprint is:
11:3a:f8:f4:9o:d9:c7:dg:09:3b:e3:3f:c4:3f:44:95
~~~~

Now we are ready to apply terraform plan to our OCI tenant. It will:

- Create the compute instances
- Install Confluent Community Edition software
- Deploy all the Community Edition components and configure them

To apply the terraform plan, execute this:

`terraform apply`{{execute}}

Now let's wait for some minutes while the components are getting configured and prepared.

You can open a browser to point to the compute instances that are being created:

`echo "Open the console at https://console.us-ashburn-1.oraclecloud.com/identity/compartments/${compartmentId}"`{{execute}}


