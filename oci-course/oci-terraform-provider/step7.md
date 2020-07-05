Resource Management and Stacks

The OCI CLI command for creating a stack from the file *stack.zip* that simply contains the *main.tf* and *variables.tf* that we have been working with in this scenario. Unfortunately: this command is not currently processed correctly by the CLI, and we do not seem to be able to create a stack from the command line.  
`oci resource-manager stack create -c="$compartmentId" --config-source="./stack.zip" --display-name "Bucket and Object Stack"  --description="A sample stack consisting of a Bucket and an Object in the Bucket" --terraform-version="0.12.x"  --variables="{\"namespace\":\"$ns\",\"compartment_id\":\"$compartmentId\"}"`{{execute}}

Let's go to the OCI Console, to the page where stacks can be added - as well as managed:
`echo "To inspect, create and edit Stacks open your browser at url https://console.$REGION.oraclecloud.com/resourcemanager/stacks"`{{execute}}

Click on *Create Stack*. Select the radio button *Sample Solution*. Then click on *Select Solution*. From the list of sample solutions, select *Compute Instance*.
![](assets/select-stack-solution.png)
Click on Next. Select *vcn-lab* as the Virtual Cloud Network. Select the Public Subnet as the Subnet.
![](assets/set-stack-variables.png)
Click Next. And click Create.

Note: at the time of creating a *stack* - the only thing we are doing is making a Terraform configuration available as an OCI resource. The configuration is not yet planned or applied; no additional OCI Resources are created when we create the stack. Once the stack is there, we can refine the settings of variables and then decide to run a *plan* and eventually an *apply* job.

The new stack is shown. Now we have several options, such as Plan and even Apply the Stack. We can also download the configuration - and see how this sample stack was put together and even start making our own customizations on top of that sample.
![](assets/new-stack-details.png)



get stack.zip

curl https://objectstorage.us-ashburn-1.oraclecloud.com/p/oxFzU7g2eVTIyqNMRmI82tojieBzq2n5OH-hTgwRLWc/n/idtwlqf2hanz/b/buck-01/o/stack.zip > stack.zip

## Resources

[Create a stack from the command line](https://docs.cloud.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/samplecomputeinstance.htm#build)
