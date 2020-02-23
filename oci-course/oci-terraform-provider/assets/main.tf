
# this variable holds the name for the bucket that will be created; the default value is tf-bucket. This could be overridden through an Environment Variable called TF_VAR_lab_bucket_name
variable "lab_bucket_name" {
  default = "tf-bucket"
}

# the bucket to be managed by Terraform
resource "oci_objectstorage_bucket" "lab_bucket" {
    # variables compartment_id, namespace and tags are defined in variables.tf
    compartment_id = var.compartment_id
    name           = var.lab_bucket_name
    namespace      = var.namespace
    freeform_tags  = var.tags
}

# report on the managed bucket resource by printing its OCID
output "show-new-bucket" {
  value = "${oci_objectstorage_bucket.lab_bucket.id}"
}

