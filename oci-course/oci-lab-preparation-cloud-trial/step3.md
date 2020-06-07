# Create OCI Resources

The Lab environment uses a compartment called *lab-compartment* to hold all new OCI resources. When you are done with this scenario, the tenancy will have this compartment, set up like this:

![](assets/lab-compartment-layout.png)

The resources are created in the OCI tenancy - in the *lab-compartment* from the OCI CLI environment set up in the Katacoda scenario VM:
![](assets/creating-lab-resources-with-oci-cli.png)

Create this compartment with the following commands:

```
compartment=$(oci iam compartment create --compartment-id "$TENANCY_OCID"  --name "lab-compartment" --description "Compartment for resources for REAL Cloud Native workshop")
echo "JSON response from the command to create the compartment:"
echo $compartment
compartmentId=$(echo $compartment | jq --raw-output .data.id)
echo The OCID for the lab compartment:  $compartmentId
```{{execute}}

To set an environment variable $compartmentId fetch the OCID from the compartment with this command (this also works when the compartment already existed prior to running this scenario):
```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
```{{execute}}


## Create Tag Namespace

Tags can be associated with OCI resources, to provide meta data for easier interpreting, finding, managing and operating on and for reporting and billing. Custom tags are in custom tag namespaces. The scenarios assume the existence of at least one tag namespace called *lab-tags*.

Execute this command to create the tag namespace *lab-tags* in compartment *lab-compartment*.

```
oci iam tag-namespace create --compartment-id $compartmentId --name "lab-tags"  --description "Tag Namespace for REAL OCI scenarios"  
```{{execute}}


## Create Virtual Cloud Network (aka VCN)

The Virtual Cloud Network defines the connections within and two resources in the *lab-compartment*. It consists of quite a few moving parts. Fortunately, the OCI Console provides a wizard that creates all these parts for us. Run the OCI Networking Quickstart wizard in the context of compartment *lab-compartment*  – to create VCN, subnets, internet gateway, NAT gateway, service gateway.

Note: this wizard is available in the OCI Console: https://console.us-ashburn-1.oraclecloud.com/networking/vcns ; replace the section *us-ashburn-1* with your tenancy's home region. If you execute the next command, the proper URL is printed in the terminal window *and* the url is clickable in the terminal 
`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/networking/vcns"`{{execute}}

Make sure that the List Scope element in the lower left hand corner of the OCI Console window is set to *lab-compartment*.
![](assets/compartment-scope.png)

The start the wizard.
![](assets/run-vcn-wizard.png)

Select the default option in th VCN wizard "VCN with Internet Connectivity" and press *Start VCN Wizard*.
![](assets/stepone-vcn-wizard.png)

Use as the name of the VCN: *vcn-lab*. Accept all examples for CIDR blocks and default settings elsewhere. 
![](assets/run-vcn-wizard.png)

When the wizard is done run this statement to retrieve the OCID of the VCN that has been created, as well as the public subnet's id and the identifier of the security list created for the VCN:
```
vcns=$(oci network vcn list  --compartment-id $compartmentId --all)
export vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "$vcnId"
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

sls=$(oci network security-list list  -c $compartmentId --vcn-id $vcnId)
export slOCID=$(echo $sls | jq -r '.data | .[0] | .id')

```{{execute}}

## Define Network Security Rule to allow Inbound Traffic to Port 443 

Note: this step is required for the use of the API Gateway. 

Add a network security rule to allow inbound traffic to public subnet on port 443. 

Open the OCI Console for the security list:
`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/networking/vcns/$vcnId/security-lists/$slOCID"
`{{execute}}
![](assets/security-list-overview.png)

Press *Add Ingress Rule*. 

Specify source CIDR as 0.0.0.0/0 (anything goes) and set *Source Port Range* to *All*. Set *Destination Port Range* to *443*. Leave the IP protocol at the default of *TCP*. Press *Add Ingress Rule*.
![](assets/define-ingress-rule.png)

## Create API Gateway

Create an API Gateway called *lab-apigw* using the following command. Note how this gateway references the public subnet identifier of the VCN.

`oci api-gateway gateway create --compartment-id $compartmentId --endpoint-type PUBLIC  --display-name lab-apigw --subnet-id $subnetId `{{execute}}

The feedback from OCI CLI will be that a workrequest is created for creating the API Gateway. The actual creation is a background process that will take from a few seconds to a few dozen seconds to complete.

Retrieve the API Gateway's OCID. Note: if no identifier is returned, you may have to wait a little longer until this command does return a value:
```
apigws=$(oci api-gateway gateway list -c $compartmentId)
export apiGatewayId=$(echo $apigws | jq -r --arg display_name "lab-apigw" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "apiGatewayOCID = $apiGatewayId"
```{{execute}}

Create a Dynamic Group that will be used later on to allow the API Gateway access to functions it should route requests to. The Dynamic Group is called *lab-apigw-dynamic-group* and includes a matching rule that defines which resources are a member of the group (that would be all API Gateways, and of course specifically the one you have just created) 

`oci iam dynamic-group create --compartment-id $TENANCY_OCID --name "lab-apigw-dynamic-group" --description "to organize access for API Gateway to functions"  --matching-rule "[ \"ALL {resource.type = 'ApiGateway', resource.compartment.id = '$compartmentId'}\"]" `{{execute}}

## Create a Stream for Storing Event Messages

Create a stream called *lab-stream*. A stream is Kafka compliant Message or Event Topic.

`oci streaming admin stream create --name "lab-stream" -c $compartmentId --partitions 1`{{execute}}

You can check the new stream in the OCI console if you feel so inclined:
```
echo "To list all streams, open the console at https://console.${REGION,,}.oraclecloud.com/storage/streaming"
```{execute}