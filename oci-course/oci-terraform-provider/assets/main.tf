# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

variable "bucket_name" {
default = "tf-bucket"
}
variable "namespace" {}

resource "oci_objectstorage_bucket" "test_bucket" {
    #Required
  compartment_id = var.compartment_id
  name           = var.bucket_name
  namespace      = var.namespace

    #Optional
    freeform_tags = {"Department"= "Finance"}
}

data "oci_objectstorage_bucket" "inspect_bucket" {
    #Required
    name = "${var.bucket_name}"
    namespace = "${var.namespace}"
}

# Output the result
output "show-bucket" {
  value = "${data.oci_objectstorage_bucket.inspect_bucket.compartment_id}"
}
