variable "lab_bucket_name" {
default = "tf-bucket"
}

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

