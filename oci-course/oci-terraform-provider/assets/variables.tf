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


# inherits values from value passed on command line -var tenancy_id=aa
variable "tenancy_id" {  
  type = string
  default = "ocid1.tenancy.oc1..aaaaaaaag7c7slwmlvsodyym662ixlsonnihko2igwpjwwe2egmlf3gg6okq"
}
