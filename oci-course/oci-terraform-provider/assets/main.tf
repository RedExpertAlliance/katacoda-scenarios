
# this variable holds the name for the bucket that will be created; the default value is tf-bucket. This could be overridden through an Environment Variable called TF_VAR_lab_bucket_name
variable "lab_bucket_name" {
  default = "tf-bucket"
}

# the bucket to be managed by Terraform
resource "oci_objectstorage_bucket" "lab_bucket" {
    # variables namespace and tags and data source oci_identity_compartments.lab_compartments are defined in variables.tf
    compartment_id = data.oci_identity_compartments.lab_compartments.compartments[0].id
    name           = var.lab_bucket_name
    namespace      = var.namespace
    freeform_tags  = var.tags
}

resource "oci_objectstorage_object" "hello-world-object-in-bucket" {
    #Required
    bucket = oci_objectstorage_bucket.lab_bucket.name
    content = "Hello World"
    namespace = var.namespace
    object = "my-new-object"
    content_type = "text/text"
}

# report on the managed bucket resource by printing its OCID
output "show-new-bucket" {
  value = oci_objectstorage_bucket.lab_bucket.bucket_id
}

# report on the managed object resource by printing the full object
output "show-new-object" {
  value = oci_objectstorage_object.hello-world-object-in-bucket
}

data "oci_objectstorage_object" "read-hello-world-object" {
  bucket = oci_objectstorage_object.hello-world-object-in-bucket.bucket
  namespace = oci_objectstorage_object.hello-world-object-in-bucket.namespace
  object = oci_objectstorage_object.hello-world-object-in-bucket.object
}

# report on the managed object resource by printing the full object
output "show-hello-world-object" {
  value = data.oci_objectstorage_object.read-hello-world-object
}

