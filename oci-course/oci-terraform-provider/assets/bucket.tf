variable "namespace" {}
variable "bucket_name" {}
variable "compartment_id" {}

resource "oci_objectstorage_bucket" "my_bucket" {
    #Required
    compartment_id = "${var.compartment_id}"
    name = "${var.bucket_name}"
    namespace = "${var.namespace}"

    #Optional
    freeform_tags = {"CreatedThrough"= "Terraform"}
}