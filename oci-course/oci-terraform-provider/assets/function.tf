    # NOTE: if we assume the user has first done the scenario functions-on-oci, then we can assume:
    # - an application called lab${LAB_ID}
    # - a function hello$LAB_ID in that application
    # - we can retrieve both application and function details using a data source in terraform    

# inherits values from value passed on command line -var lab_id=$LAB_ID
variable "lab_id" {
}

# inherits values from value passed on command line -var application_name=lab$LAB_ID
variable "application_name" {  
  type = string
  
}



# inherits values from value passed on command line -var function_name=hello$LAB_ID
variable "function_name" {  
  type = string
}






data "oci_functions_applications" "lab_application" {
    #Required
    compartment_id = var.compartment_id
    #Optional
    display_name = var.application_name
    
    # note: the effect of using the display_name property is similar to applying the filter
    # the former is applied through  the OCI Provider inside the OCI REST API and the latter is applied by Terraform on the result returned from the REST API
    filter {
        name   = "display_name"
        values  = [ var.application_name]
    }
}


locals {
  # store the first (and only) application returned from the data source in the local variable
  lab_app = data.oci_functions_applications.lab_application.applications[0]
}

# purely debug info - to show the application has been retrieved
output "lab_app" {
  value       = local.lab_app
  description = "The App"
}

# purely debug info
output "show-application_id" {
  value = local.lab_app.id
}

# retrieve function hello$LAB-ID in the application indicated by the application identifier held in the local variable
data "oci_functions_functions" "hello_function" {
    #Required 
    application_id = local.lab_app.id

    #Optional
    display_name = var.function_name
}

locals {
  # store the first and only function returned from the data source in the local variable hello_func
  hello_func = data.oci_functions_functions.hello_function.functions[0]
}

# debug only
output "hello" {
  value       = local.hello_func
  description = "The Hello Function"
}

# retrieve the hello function into the data source using the local variable with the function OCID
data "oci_functions_function" "hello_func" {
    #Required
    function_id = local.hello_func.id
}

# purely debug: show the image associated with the existing hello function
output "show-function" {
  value = data.oci_functions_function.hello_func.image
}


# manage function resource
resource "oci_functions_function" "hello_function" {
    # see: https://www.terraform.io/docs/providers/oci/r/functions_function.html
    #Required

    # the OCID of a functions application that the current user can make use of
    application_id = local.lab_app.id
    display_name = "my-hello-function-tf"
    # image name is retrieved from the local variable
    image = data.oci_functions_function.hello_func.image
    memory_in_mbs = "256"
    freeform_tags = {"Department"= "Finance"}
}

resource "oci_functions_invoke_function" "invoke_hello_function" {
    # see: https://www.terraform.io/docs/providers/oci/r/functions_invoke_function.html 

    #Required
    # get the function_id from the hello_function resource - defined overhead 
    function_id = oci_functions_function.hello_function.id

    #Optional
    # send a JSON object with the input to the function
    invoke_function_body = "{\"name\":\"Henk\"}"
    fn_intent = "httprequest"
    fn_invoke_type = "sync"
    base64_encode_content = false
}

# report the response from the function call - by retrieving the content attribute from the resource
output "show-function-result" {
  value = oci_functions_invoke_function.invoke_hello_function.content
}
