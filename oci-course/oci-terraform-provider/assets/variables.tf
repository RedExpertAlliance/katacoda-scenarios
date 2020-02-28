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

data "oci_identity_compartments" "all_compartments" {
    #Required
    compartment_id = var.tenancy_id
}

output "all_compartments" {
  value = data.oci_identity_compartments.all_compartments
}

data "oci_identity_compartments" "lab_compartments" {
    compartment_id = var.tenancy_id
    # only retain the compartment called lab-compartment
    filter {
        name   = "name"
        values  = [ "lab-compartment"]
    }
}

output "lab_compartment" {
  value = data.oci_identity_compartments.lab_compartments
}

locals {
  # store the first (and only) compartment returned from the data source in the local variable
  lab_compartment = data.oci_identity_compartments.lab_compartments.compartments[0]
}

output "lab_compartment_id" {
  value = local.lab_compartment.id
}

# this is also allowed (an expression referencing an element in a list) - in output and data, but not in resouce properties
output "lab_compartment_id2" {
  value = data.oci_identity_compartments.lab_compartments.compartments[0].id
}

data "oci_identity_compartment" "lab_compartment" {
  id = data.oci_identity_compartments.lab_compartments.compartments[0].id
}

output "lab_compartment_id3" {
  value = data.oci_identity_compartment.lab_compartment
}


resource "oci_objectstorage_bucket" "lab_bucket2" {
    # variables compartment_id, namespace and tags are defined in variables.tf
    compartment_id = local.lab_compartment.id
    name           = "other-bucket"
    namespace      = var.namespace
    freeform_tags  = var.tags
}