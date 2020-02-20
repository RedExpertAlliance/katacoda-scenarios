Download Terraform Installer from GitHub https://github.com/robertpeteuil/terraform-installer
`git clone https://github.com/robertpeteuil/terraform-installer`{{execute}}

Run the Terraform installer to install Terraform
`./terraform-installer/terraform-install.sh`{{execute}}

Test the currently installed version of Terraform. This should be at least version v0.10
`terraform version`{{execute}}

Edit the environment variable values in `environment.sh`{{open}}
Then execute the script to set those environment variables:
`./environment.sh`{{execute}}

And now initialize the Terraform provider:

`terraform init`{{execute}}




##Resources

GitHub Repo with many sample Terraform configurations for OCI Resources https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples 
