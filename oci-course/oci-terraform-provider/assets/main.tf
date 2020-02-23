# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

variable "lab_bucket_name" {
default = "tf-bucket"
}

# inherits values from Environment Variable TF_VAR_namespace
variable "namespace" {}

resource "oci_objectstorage_bucket" "lab_bucket" {
    #Required
    compartment_id = var.compartment_id
    name           = var.lab_bucket_name
    namespace      = var.namespace
    freeform_tags = var.tags
}

output "show-new-bucket" {
  value = "${oci_objectstorage_bucket.lab_bucket.compartment_id}"
}

