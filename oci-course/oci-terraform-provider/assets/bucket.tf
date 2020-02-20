resource "oci_objectstorage_bucket" "my_bucket" {
    #Required
    compartment_id = "${var.compartment_id}"
    name = "my_bucket_${var.LAB_ID}"
    namespace = "${var.namespace}"

    #Optional
    freeform_tags = {"CreatedThrough"= "Terraform"}
}