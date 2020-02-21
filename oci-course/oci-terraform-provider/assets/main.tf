# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

variable "compartment_id" {}

variable "bucket_name" {
default = "tf-bucket"
}
variable "namespace" {}

resource "oci_objectstorage_bucket" "test_bucket" {
    #Required
    compartment_id = "${var.compartment_id}"
    name = "${var.bucket_name}"
    namespace = "${var.namespace}"

    #Optional
    freeform_tags = {"Department"= "Finance"}
}