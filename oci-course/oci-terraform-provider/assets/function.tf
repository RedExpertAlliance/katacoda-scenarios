    # NOTE: if we assume the user has first done the scenario functions-on-oci, then we can assume:
    # - an application called lab${LAB_ID}
    # - a function hello$LAB_ID in that application
    # - we can retrieve both application and function details using a data source in terraform    

data "oci_functions_applications" "lab_application" {
    #Required
    compartment_id = "var.compartment_id"

    #Optional
    display_name = "lab1"
}

output "show-applications" {
  value = "${data.oci_functions_applications.lab_application.applications}"
}

data "oci_functions_functions" "hello_function" {
    #Required
    application_id = "${data.oci_functions_applications.lab_application[0].id}"

    #Optional
    display_name = "hello1"
}

output "show-functions" {
  value = "${data.oci_functions_functions.hello_function.functions}"
}

data "oci_functions_function" "hello_func" {
    #Required
    function_id = "${data.oci_functions_functions.hello_function.functions[0].id}"

}

output "show-function" {
  value = "${data.oci_functions_function.hello_func.image}"
}


resource "oci_functions_function" "hello_function" {
    # see: https://www.terraform.io/docs/providers/oci/r/functions_function.html
    #Required

    # the OCID of a functions application that the current user can make use of
    application_id = "ocid1.fnapp.oc1.iad.aaaaaaaaaggy6vypllumrzugdpgcdi4fd5aauv475ikfos46nlcualwiq26q"
    display_name = "my-hello-func"
    # prepared fully qualified name of a container image (suitable for use for a function) the current user has access to 
    image = "iad.ocir.io/idtwlqf2hanz/cloudlab-repo/hello:0.0.10"
    memory_in_mbs = "256"

    #Optional
    ##config = "${var.function_config}"
    ##defined_tags = {"Operations.CostCenter"= "42"}
    freeform_tags = {"Department"= "Finance"}
}

resource "oci_functions_invoke_function" "invoke_hello_function" {\
    # see: https://www.terraform.io/docs/providers/oci/r/functions_invoke_function.html 

    #Required
    # get the function_id from the hello_function resource - defined overhead 
    function_id = "${oci_functions_function.hello_function.id}"

    #Optional
    # send a JSON object with the input to the function
    invoke_function_body = "{\"name\":\"Henk\"}"
    fn_intent = "httprequest"
    fn_invoke_type = "sync"
    base64_encode_content = false
}

# report the response from the function call - by retrieving the content attribute from the resource
output "show-function-result" {
  value = "${oci_functions_invoke_function.invoke_hello_function.content}"
}
