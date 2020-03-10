# Validate your NGINX installation

To get the IP address of our newly created OCI compute instance, let's execute the following.

```
export instance_vnics=$(oci compute instance list-vnics --instance-id ocid1.instance.oc1.iad.abuwcljtmj4bnbw3cky4wzljjqb5jbrkjky2ozqvbx3wbfn22owfbkg5mv2q)
export public_ip = $(echo $instance_vnics | jq -r '.data | .[0] | .["public-ip"]')
```{{execute}}

`The IP address is: $public-ip`{{execute}}

Write that down and open a browser and go to: http://$public:ip:443  and you will get the html that we used in the config while to create the compute instance.

## Extra step

You can use the private key (/root/keys/lab) to create an ssh session to your server, you already have the IP address. Try it! And see how the nginx 
was installed.