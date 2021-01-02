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


The expected output for the terraform init command execution is this:

~~~~
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/oci...
- Installing hashicorp/oci v4.7.0...
- Installed hashicorp/oci v4.7.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
~~~~

Now let's move on to the plan execution.

# Terraform Plan Execution

Now let's validate the plan:

`terraform plan`{{execute}}

Something like this will appear:

~~~~
Plan: 24 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + broker_public_ips          = (known after apply)
  + connect_public_ips         = (known after apply)
  + connect_url                = (known after apply)
  + ksql_public_ips            = (known after apply)
  + rest_proxy_public_ips      = (known after apply)
  + rest_proxy_url             = (known after apply)
  + schema_registry_public_ips = (known after apply)
  + schema_registry_url        = (known after apply)
  + zookeeper_public_ips       = (known after apply)

Warning: "subnet_id": [DEPRECATED] The 'subnet_id' field has been deprecated. Please use 'subnet_id under create_vnic_details' instead.

  on broker.tf line 1, in resource "oci_core_instance" "broker":
   1: resource "oci_core_instance" "broker" {

(and 4 more similar warnings elsewhere)


Warning: "compartment_id": [DEPRECATED] The 'compartment_id' field has been deprecated and may be removed in a future version. Do not use this field.

  on broker.tf line 53, in resource "oci_core_volume_attachment" "broker":
  53: resource "oci_core_volume_attachment" "broker" {



------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
~~~~

The Plan will add 24 resources, as it mentioned in the output of of the terrafom plan command.

Now we are ready to apply terraform plan to our OCI tenant. It will:

- Create the compute instances
- Install Confluent Community Edition software
- Deploy all the Community Edition components and configure them

To apply the terraform plan, execute this:

`terraform apply`{{execute}}

You will be prompted with something this:

~~~~
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve
~~~~

**Just type the word: yes.**

Terraform will provision and install everything for you. You will see something like this during the process:

![Intro](/RedExpertAlliance/courses/oci-course/oci-confluent-kafka/assets/apply3.jpg)

Now let's wait for some minutes while the components are getting configured and prepared.

You can open a browser to point to the compute instances that are being created:

`echo "Open the console at https://console.us-ashburn-1.oraclecloud.com/identity/compartments/${compartmentId}"`{{execute}}

You will see something similar to this (IP adresses will be different):

![Intro](/RedExpertAlliance/courses/oci-course/oci-confluent-kafka/assets/instances2.jpg)

Wait for five minutes before getting into the next step.