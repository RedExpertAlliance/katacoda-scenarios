Download Terraform Installer from GitHub https://github.com/robertpeteuil/terraform-installer
`git clone https://github.com/robertpeteuil/terraform-installer`{{execute}}

Run the Terraform installer to install Terraform
`./terraform-installer/terraform-install.sh`{{execute}}

Test the currently installed version of Terraform. This should be at least version v0.10
`terraform version`{{execute}}

Edit the environment variable values in `environment.sh`{{open}}
Then execute the script to set those environment variables:
```
chmod +777 environment.sh
./environment.sh
export TF_VAR_compartment_id=$(oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
export TF_VAR_namespace=$(oci os ns get| jq -r '.data')
```{{execute}}

And now initialize the Terraform provider:

`terraform init`{{execute}}

Note: the file `variables.tf` contains the OCI Provider for Terraform. When no variables are defined for the provider, it will attempt to find the file ~/.oci/config and use the settings from the DEFAULT config. When that files exists and has the right entries, you do not need to define fingerprint, tenancy_ocid and other configuration variables in the provider.

Terraform will process all *.tf* files in the current directory (and possibly files in other directories to which references exist).

File `variables.tf`{{open}} contains the OCI provider definition and is also - by convention - the place for global variable definitions and constants that can be used throughout the other *.tf files*. The values of variables can be determined by Terraform in several ways (in this order):
* taken from values passed on the command line through the `-var '<variable-name>=<value>'` syntax 
* in a `.tfvars` file (specified on the command line or automatically loaded)
* read from an Environment Variable called TF_VAR_<name of variable>
* taken from the default value

File `main.tf`{{open}} contains the definitions of the OCI resources we want Terraform to make happen. If they exist, Terraform should only update them where properties differ in definition and actual state and if they do not exist, Terraform should create them.

In this file, a single bucket is defined. 


`terraform plan -out config.tfplan`{{execute}}

To make our plan real, use the following command:
`terraform apply`{{execute}}
Enter *yes* when prompted to confirm our desire.

`terraform show`{{execute}}

Let's remove the resources that we had Terraform create in this scenario
`terraform destroy`{{execute}}


## Resources

GitHub Repo with many sample Terraform configurations for OCI Resources https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples 

Example OCI Terraform Provider - Bucket - https://www.terraform.io/docs/providers/oci/r/objectstorage_bucket.html

Terraform Docs on Variables: https://www.terraform.io/docs/configuration/variables.html 