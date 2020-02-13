Virtually all OCI resources live in a *compartment*. The tenancy is organized in *compartments*, somewhat similar to folders on a file system. A compartment is a logical collection of related resources (such as compute instances, virtual cloud networks, block volumes, functions, API Gateway) that can be accessed only by certain groups that have been given permission by an administrator. Any resource can be part of only one compartment. There is not something akin to a symbolic link or shortcut.  

A compartment should be thought of as a logical group and not a physical container. Compartments can be nested, to six levels deep. Compartments do not cost money - you can create many of them if that helps you to better organize your tenancy. The tenancy itself is the root compartment that holds all your cloud resources. 

In the console, navigate to the menu option Governance and Administration | Identity | Compartments.

https://console.us-ashburn-1.oraclecloud.com/identity/compartments  

You will see a flattened list all compartments in the tenancy *that you have access to*. You should at least see the tenancy's root compartment (that has at least two subcompartments) as well as the *lab-compartment* that was prepared for this scenario. Inspect the *lab-compartment* by clicking on it.

Click on *Create Compartment*. Type `lab-LAB_ID` where LAB_ID is the number assigned to you by the instructor. For example: `lab-01`. Type *compartment for personal lab resources* as description. Create the new compartment by clicking on *Create Compartment*.

You have now created a new compartment, nested under *lab-compartment* that itself is nested under the *root-compartment*. 

For any other cloud resource you will create - such as a VM, database, or data catalog - you must specify to which compartment you want the resource to belong. That could be your newly created compartment, or one that does not yet exist. As an example: many tenancies contain a *Sandbox*  compartment, used for experiments and early development work. Security policies in this compartment are fairly relaxed compared for example to the *Production* compartment.

Click on the new compartment. It will obviously be empty at this stage and not have any Child Compartments. The parent compartment is *lab-compartment*.  

In the next step, you will work with the Object Storage Service. You will create a bucket - a container for objects. Then you will upload a file into this bucket.
