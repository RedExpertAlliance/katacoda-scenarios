The Cloud Shell is a pretty versatile tool for OCI Administrators and Developers - packed with tools and run time engines that be used for easy interaction with OCI resources.
![Cloud Shell](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-cloud-shell.png)

Cloud Shell has the OCI CLI pre-installed en pre-configured - ready to run. No need to install nor to edit the config file and private key pem.file. In addition to the command line interface, Cloud Shell comes with Terraform (an infrastructure as code provisioning tools that is discussed in a later scenario), Ansible, kubectl (for managing a Kubernetes Cluster), fn (the command line tool for working with serverless functions on OCI, also the subject of several later scenarios), git, vi & nano and language runtimes for Node, Java, Ruby, Perl, PHP, Python and Go. The database clients SQL*Plus and MySQL are also part of the Cloud Shell. Read this article [Oracle Cloud Infrastructure Cloud Shell – integrated OCI CLI, kubectl, terraform, SQL Plus, Docker and Maven](https://technology.amis.nl/2020/03/15/oracle-cloud-infrastructure-cloud-shell-integrated-oci-cli-kubectl-terraform-sql-plus-docker-and-maven/) for an introduction to Cloud Shell.

Cloud Shell is opened from the OCI Console.
![Cloud Shell](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-cloud-shell-open.png)
Go ahead and open Cloud Shell from the Console.

A console will open in the bottom section of the page. You will see a number of messages regarding starting up and attaching the Cloud Shell environment. Cloud Shell is implemented as a Compute VM with attached storage. Anything you save in Cloud Shell is saved on persistent storage (5 GB of user storage) that is available across Cloud Shell sessions.

After a little wait, Cloud Shell will be available and you can start working on the command line. Note: you can maximimize the console. 

![Cloud Shell](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-cloud-shell-opened.png)

Very relevant: you can paste text to the command line or to files opened in *vi* using `shift + Insert` (on Windows) or `Cmd+V` (on Mac). To copy text from the Cloud Shell, use `Ctrl + C` (on Windows) and `Cmd + C`.

Paste the following statement into the Cloud Shell (`Shift + Insert` or `Cmd + V`):
`oci iam compartment list`
and press enter.

The list of compartments should be shown, just as in the previous step. However, in the previous step, we first had to install OCI CLI and prepare the configuration and private key files. In Cloud Shell, all of that is configured for us.

The *jq* tool is also part of Cloud Shell, so to get details for the *lab-compartment*, the following command can be pasted into Cloud Shell and executed:

`oci iam compartment list | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] '`

Feel free to explore some of the other features of Cloud Shell - for example the Node or Java runtimes or the git client.

## Resources

OCI Docs [OCI Cloud Shell])(https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)

3 minute video – introducing Cloud Shell: https://www.youtube.com/watch?v=J51BXxlCbOY