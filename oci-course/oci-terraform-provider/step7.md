Resource Management and Stacks

`oci resource-manager stack create -c=$compartmentId --config-source="stack.zip" --description="Bucket and Object Stack" --terraform-version="0.12.x"  --variables="{\"namespace\":\"$ns\",\"compartment_id\":\"$compartmentId\"}"`{{execute}}