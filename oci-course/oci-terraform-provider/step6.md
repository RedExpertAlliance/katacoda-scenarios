Managing a Function (including invoking the function)

In this step you will use a second Terraform configuration file to create a function and invoke that function. There are two prerequisites for this scenario - that are both met when you have gone through the scenario  *Functions on OCI* (https://katacoda.com/redexpertalliance/courses/oci-course/functions-on-oci)"
* there should be an *application* that is called *lab$LAB_ID* 
* the application *lab$LAB-ID* should contain a function *hello$LAB_ID*

Execute the next command to work with Terraform in directory *terraform_details*:
```
cp variables.tf terraform_details
cd terraform_details
terraform init
```{{execute}}

In this directory, the file `function.tf` defines a function resource as well as a function execution resource. The function is called *my-hello-function-tf* and is created based on the same function (container) image as function *hello$LAB_ID*.  

`terraform_details/function.tf`{{open}}

This file contains several data sources that are used to retrieve the OCID of the application *lab_$LAB_ID* and the function *hello$LAB_ID* as well as the image on which that function is based. 

Execute this command, to find out what Terraform thinks of the configuration. 

`terraform plan -out config.tfplan -var lab_id=$LAB_ID  -var application_name=lab$LAB_ID  -var function_name=hello$LAB_ID`{{execute}}

Terraform reports the resources it needs to manipulate to take the existing state on OCI to the state described in the configuration file.

To turn our plan into reality, use the following command. Terraform will apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated in the terraform execution plan created through the *terraform plan* command.

`terraform apply -var lab_id=$LAB_ID  -var application_name=lab$LAB_ID  -var function_name=hello$LAB_ID`{{execute}}

Enter *yes* when prompted to confirm your desire.

The output lists details on the application, the function managed by Terraform and the response from the invoked function. You can check the results and output again using:

`terraform show`{{execute}}

You can of course check in the Console if the function *my-hello-function-tf* has been created in the application *lab$LAB_ID*. 

Let's now remove the function that we had Terraform create in this scenario.

`terraform destroy -var lab_id=$LAB_ID  -var application_name=lab$LAB_ID  -var function_name=hello$LAB_ID`{{execute}}

Again, enter *yes* when prompted. Note: the OCI Terraform provider struggles a bit with deleting functions. The *destroy* command can take quite a long time to complete. You do not need to wait for completion of the command in order to finish this scenario.
