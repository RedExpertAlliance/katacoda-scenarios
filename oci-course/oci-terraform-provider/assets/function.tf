# inherits values from Environment Variable TF_VAR_compartment_id
variable "compartment_id" {}

# inherits values from Environment Variable TF_VAR_namespace
variable "namespace" {}

resource "oci_functions_function" "test_function" {
    #Required
    # application lab1
    application_id = "ocid1.fnapp.oc1.iad.aaaaaaaaaggy6vypllumrzugdpgcdi4fd5aauv475ikfos46nlcualwiq26q"
    display_name = "my-hello-func"
    # prepared container image 
    image = "iad.ocir.io/idtwlqf2hanz/cloudlab-repo/hello:0.0.10"
    memory_in_mbs = "256"

    #Optional
    ##config = "${var.function_config}"
    ##defined_tags = {"Operations.CostCenter"= "42"}
    freeform_tags = {"Department"= "Finance"}
    ##image_digest = "${var.function_image_digest}"
    ##timeout_in_seconds = "${var.function_timeout_in_seconds}"
}

resource "oci_functions_invoke_function" "test_invoke_function" {
    #Required
    function_id = "${oci_functions_function.test_function.id}"

    #Optional
    invoke_function_body = "{\"name\":\"Henk\"}"
    fn_intent = "httprequest"
    fn_invoke_type = "sync"
    base64_encode_content = false
}

output "show-function-result" {
  value = "${oci_functions_invoke_function.test_invoke_function.content}"
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.compartment_id}"
}


# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}
