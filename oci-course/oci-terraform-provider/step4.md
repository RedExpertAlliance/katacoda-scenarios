Let's check on what Terraform has done to our OCI resources.

With the next command, we ask Terraform to show in human-readable output the current state for the resources as Terraform sees it.
`terraform show`{{execute}}

Check in the console if the resource was created as intended:
https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets 

Or use

`oci os bucket list --compartment-id=$compartmentId`{{execute}}

to list all buckets and find the bucket created by Terraform: *tf-bucket*. 

The next command will generate an SVG visualization of the resources managed by Terraform, in a file called graph.svg.

`terraform graph | dot -Tsvg > graph.svg`{{execute}}

You can open the file `graph.svg`{{open}} and copy the contents to the clipboard. Then open an online SVG editor, for example at https://www.freecodeformat.com/svg-editor.php or https://thedevband.com/online-svg-viewer.html  . Copy the contents of the clipboard into the editor and press *Draw* to show the visual representation. 

## Discovery

Beginning with version 3.50, the terraform-oci-provider can be run as a command line tool to discover resources that have been created within Oracle Cloud Infrastructure compartments and generate Terraform configuration files for the discovered resources.

See https://www.terraform.io/docs/providers/oci/guides/resource_discovery.html for details on discovery.

The command to start discovery looks like this. Note: I have not been able to get it to work properly.

```
mkdir discovery_oci_tf

.terraform/plugins/linux_amd64/terraform-provider-oci_v3.63.0_x4  -command=export -compartment_id=$TF_VAR_compartment_id -service=core,tagging -output_path=discovery_oci_tf
```{{execute}}


## Resources

Resource Discovery: https://www.terraform.io/docs/providers/oci/guides/resource_discovery.html 