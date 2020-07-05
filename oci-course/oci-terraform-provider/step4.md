Let's check on what Terraform has done to our OCI resources.

With the next command, we ask Terraform to show in human-readable output the current state for the resources as Terraform sees it.
`terraform show`{{execute}}

Check in the console if the resource was created as intended:
`echo "Open the console at https://console.$REGION.oraclecloud.com/object-storage/buckets"  `{{execute}}

Drill down into the new bucket to see its details and its contents; there should be a single file object.

Or use

`oci os bucket list --compartment-id=$compartmentId`{{execute}}

to list all buckets and find the bucket created by Terraform: *tf-bucket*. You can use 

`oci os object list --bucket-name=$TF_VAR_lab_bucket_name`{{execute}}

to list objects in the newly created bucket.

The next command will generate an SVG visualization of the resources managed by Terraform, in a file called graph.svg.

`terraform graph | dot -Tsvg > graph.svg`{{execute}}

You can open the file `graph.svg`{{open}} and copy the contents to the clipboard. Then open an online SVG editor, for example at https://www.freecodeformat.com/svg-editor.php or https://thedevband.com/online-svg-viewer.html  . Copy the contents of the clipboard into the editor and press *Draw* to show the visual representation. 
![](assets/svg-drawing-of-terraformactions.png)

## Discovery

Beginning with version 3.50, the terraform-oci-provider can be run as a command line tool to discover resources that have been created within Oracle Cloud Infrastructure compartments and generate Terraform configuration files for the discovered resources.

See https://www.terraform.io/docs/providers/oci/guides/resource_discovery.html for details on discovery.

The command to start discovery looks like this. Note: I have not been able to get it to work properly; perhaps this option requires special permissions.

```
mkdir discovery_oci_tf

.terraform/plugins/linux_amd64/terraform-provider-oci_v3.63.0_x4  -command=export -compartment_id=$TF_VAR_compartment_id -service=core,tagging -output_path=discovery_oci_tf
```{{execute}}


## Resources

Resource Discovery: https://www.terraform.io/docs/providers/oci/guides/resource_discovery.html 