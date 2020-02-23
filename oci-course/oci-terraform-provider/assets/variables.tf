# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

provider "oci" {
 
}

# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

# inherits values from Environment Variable TF_VAR_namespace
variable "namespace" {}



variable "tags" {
  type = map(string)
  default = {
    "created-for" = "KatacodaLab"
  }
}