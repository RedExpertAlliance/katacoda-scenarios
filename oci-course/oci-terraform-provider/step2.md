Download Terraform Installer from GitHub https://github.com/robertpeteuil/terraform-installer
`git clone https://github.com/robertpeteuil/terraform-installer`{{execute}}

Run the Terraform installer to install Terraform
`./terraform-installer/terraform-install.sh`{{execute}}

Test the currently installed version of Terraform. This should be at least version v0.12.

`terraform version`{{execute}}

And now initialize the Terraform provider:

`terraform init`{{execute}}

Note: the file `variables.tf` contains the OCI Provider for Terraform. When no variables are defined for the provider, it will attempt to find the file ~/.oci/config and use the settings from the DEFAULT config. When that files exists and has the right entries, you do not need to define fingerprint, tenancy_ocid and other configuration variables in the provider.

Terraform will process all *.tf* files in the current directory (and possibly files in other directories to which references exist).

File `variables.tf`{{open}} contains the OCI provider definition and is also - by convention - the place for global variable definitions and constants that can be used throughout the other *.tf files*. The values of variables can be determined by Terraform in several ways (in this order):
* taken from values passed on the command line through the `-var 'variable-name=value'` syntax 
* in a `.tfvars` file (specified on the command line or automatically loaded)
* read from an Environment Variable called *TF_VAR_name-of-variable*
* taken from the default value

