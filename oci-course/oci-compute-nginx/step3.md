# Get the IP Address of our new created OCI compute instance

To get the IP address of our newly created OCI compute instance, let's execute the following.

```
export INSTANCE_DETAILS=$(oci compute instance list --compartment-id $COMPARTMENT_OCID --availability-domain $AVAILABILITY_DOM --display-name $DISPLAY_NAME)
export INSTANCE_ID=$(echo $INSTANCE_DETAILS | jq -r '.data | .[0] | .["id"]')
export instance_vnics=$(oci compute instance list-vnics --instance-id $INSTANCE_ID)
export public_ip=$(echo $instance_vnics | jq -r '.data | .[0] | .["public-ip"]')
```{{execute}}

Let's print the IP address:
`echo "The IP address is: $public_ip"`{{execute}}

Write that down, because you need it for changing the kube config file in the OKE Scenario.

***You can close this scenario and go directly to Part 2 
of the OKE scenario https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part2***.