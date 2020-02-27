# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

provider "oci" {
 
}

# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

# inherits values from Environment Variable TF_VAR_namespace
variable "namespace" {}

# this variable holds the name for the bucket that will be created; the default value is tf-bucket. This could be overridden through an Environment Variable called TF_VAR_lab_bucket_name
variable "lab_bucket_name" {
  default = "tf-bucket"
}

variable "tags" {
  type = map(string)
  default = {
    "created-for" = "KatacodaLab"
  }
}


# inherits values from value passed on command line -var tenancy_id=aa
variable "tenancy_id" {  
  type = string
  default_value = "ocid1.tenancy.oc1..aaaaaaaag7c7slwmlvsodyym662ixlsonnihko2igwpjwwe2egmlf3gg6okq"
}

data "oci_identity_compartments" "all_compartments" {
    #Required
    compartment_id = "${var.tenancy_id}"
}

# report the response from the function call - by retrieving the content attribute from the resource
output "all_compartments" {
  value = "${oci_functions_invoke_function.invoke_hello_function.content}"
}