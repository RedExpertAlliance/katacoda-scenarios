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

`terraform plan -out config.tfplan`{{execute}}

`terraform apply`{{execute}}

`terraform show`{{execute}}


##Resources

GitHub Repo with many sample Terraform configurations for OCI Resources https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples 

Example OCI Terraform Provider - Bucket - https://www.terraform.io/docs/providers/oci/r/objectstorage_bucket.html