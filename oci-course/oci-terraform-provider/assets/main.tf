# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/providers/oci/index.html

# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

variable "lab_bucket_name" {
default = "tf-bucket"
}
variable "namespace" {}

resource "oci_objectstorage_bucket" "lab_bucket" {
    #Required
  compartment_id = var.compartment_id
  name           = var.lab_bucket_name
  namespace      = var.namespace

    #Optional
    freeform_tags = {"Department"= "Finance"}
}

resource "oci_objectstorage_object" "test_object" {
    #Required
    bucket = "${oci_objectstorage_bucket.lab_bucket.name}"
    content = "Hello World in Terraformed file"
    namespace = "var.namespace"
    object = "my-new-object"

    freeform_tags = "${var.tags}"
}


output "show-new-bucket" {
  value = "${oci_objectstorage_bucket.lab_bucket.compartment_id}"
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.compartment_id}"
}


# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}
