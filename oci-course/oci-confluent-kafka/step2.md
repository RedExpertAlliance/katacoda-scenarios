Download Terraform Installer from GitHub https://github.com/robertpeteuil/terraform-installer
`git clone https://github.com/robertpeteuil/terraform-installer`{{execute}}

Run the Terraform installer to install Terraform
`./terraform-installer/terraform-install.sh`{{execute}}

Test the currently installed version of Terraform. This should be at least version v0.12.

`terraform version`{{execute}}

And now initialize the Terraform provider:

`terraform init`{{execute}}

In our scenario the provider will take values from your oci config file (created in the previous step) as well from a set of environment variables.
Terraform provider will take from the oci config file the following values:

- user_ocid
- fingerprint
- private_key_path
- region

And from the environment variables, it will take:

- tenancy_ocid       
- compartment_ocid  (created in the previous step, name: confluent_ce)
- ssh_public_key    (needed to make ssh to the compute instances that we are going to create) 
- ssh_private_key   (needed to make ssh to the compute instances that we are going to create) 

## Creation of private and public key for the compute instances

For generating the public and private key that will be used to ssh to the compute instances, execute the following (plsease remember to use ***/root/keys/confluent***):

`ssh-keygen -t rsa`{{execute}}

This will prompt you for the location where the keys will be stored. Enter ***/root/keys/confluent***

After that you will be prompted for a passphrase, you can leave it blank if you do not want to set one (we do recommend you to set one).

A similar output like the following one will appear:

~~~~
Generating public/private rsa key pair.
Enter file in which to save the key (/root/keys):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
The key fingerprint is:
11:3a:f8:f4:9o:d9:c7:dg:09:3b:e3:3f:c4:3f:44:95
~~~~

Your public and private key will be listed here **/root/keys** as **confluent** and **confluent.pub**. Where the former is the private and the latter the public key.
`ls -la /root/keys`{{execute}}

## Set environment variables for Terraform Provider

As mentioned in a previous section of this step, we need to set four variables for our terraform provider, let's do it:

```
export TF_VAR_tenancy_ocid=$TENANCY_OCID
export TF_VAR_compartment_ocid=$compartmentId
export TF_VAR_ssh_private_key=/root/keys/confluent
export TF_VAR_ssh_public_key=/root/keys/confluent.pub
```{{execute}}

Now we are all set with our terraform oci provier, and we are ready to execute the plan. 

