# Get the IP Address of our new created OCI compute instance

To get the IP address of our newly created OCI compute instance, let's execute the following.

```
export instance_vnics=$(oci compute instance list-vnics --instance-id $INSTANCE_ID)
export public_ip = $(echo $instance_vnics | jq -r '.data | .[0] | .["public-ip"]')
```{{execute}}

`The IP address is: $public-ip`{{execute}}

Write that down, because you need it for changing the kube config file in the OKE Scenario.

With this, you are ready to get back for Step 3 for the OKE Scenario.