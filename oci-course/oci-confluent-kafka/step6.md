# Try Confluent Enterprise Edition on top of OCI

This step is a DIY (Do it Yourself).

If you move into the ~/confluent/oci-confluent/enterprise folder, you will see that there is terraform plan that will deploy Confluent EE into OCI:

`cd ~/oci-confluent/enterprise`{{execute}}

You just need to execute:

~~~~
1. terraform init
2. terraform plan
3. terraform apply
~~~~

And you will be able to deploy it. 
Execute those three steps in another compartment of your OCI tenant, just create a new one.

Create a compartment with the name confluent_ee (confluent enterprise edition)

`export confluent_compartment=confluent_ee`{{execute}}

```
compartment=$(oci iam compartment create --compartment-id "$TENANCY_OCID"  --name "$confluent_compartment" --description "Compartment for resources for Confluent Enterprise Edition")
echo "JSON response from the command to create the compartment:"
echo $compartment
compartmentId=$(echo $compartment | jq --raw-output .data.id)
echo The OCID for the compartment is:  $compartmentId
```{{execute}}

To set an environment variable $compartmentId fetch the OCID from the compartment with this command (this also works when the compartment already existed prior to running this scenario):
```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "$confluent_compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
```{{execute}}

And set the terraform variable:

`export TF_VAR_compartment_ocid=$compartmentId`{{execute}}

And you are ready to go.

Have some fun!!