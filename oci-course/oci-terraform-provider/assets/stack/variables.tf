# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html


# in stack, these variables are set by the OCI Resource Manager. I think. 

variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}

# inherits values from Environment Variable TF_VAR_namespace
variable "namespace" {}


variable "tags" {
  type = map(string)
  default = {
    "created-for" = "Stack-Sample-in-REAL-OCI-Katacoda-Lab-Scenario"
  }
}



