Resource Management and Stacks

`oci resource-manager stack create -c=$compartmentId --config-source="stack.zip" --description="Bucket and Object Stack" --terraform-version="0.12.x"  --variables="{\"namespace\":\"$ns\",\"compartment_id\":\"$compartmentId\"}"`{{execute}}

Console:

`echo "To inspect, create and edit Stacks open your browser at url https://console.$REGION.oraclecloud.com/resourcemanager/stacks"`{{execute}}