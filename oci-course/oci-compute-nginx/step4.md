# Validate your NGINX installation

To get the IP address of our newly created OCI compute instance, let's execute the following.

```
export INSTANCE_DETAILS=$(oci compute instance list --compartment-id $COMPARTMENT_OCID --availability-domain $AVAILABILITY_DOM --display-name $DISPLAY_NAME)
export INSTANCE_ID=$(echo $INSTANCE_DETAILS | jq -r '.data | .[0] | .["id"]')
export instance_vnics=$(oci compute instance list-vnics --instance-id $INSTANCE_ID)
export public_ip=$(echo $instance_vnics | jq -r '.data | .[0] | .["public-ip"]')
```{{execute}}

Let's print the IP address:
`echo "The IP address is: $public_ip"`{{execute}}
 
Open a browser and go to: http://$public:ip:80 and you will get the html that we used in the config while creating the compute instance.
** It may take two minutes to respond. Please wait**


## Extra step

You can use the private key (/root/keys/lab) to create an ssh session to your server, you already have the IP address. **Try it!** And see how the nginx 
was installed.