## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

If you do not have the OCI config file, nor the oci API key yet, you can go through these steps: https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm

Once you have the config file and the api key, copy their contents in ~/.oci/config and ~/.oci/oci_api_key.pem respectively. 
**Remember that in this scenario you will be working with a newly created 30 day free trial OCI instance, and you will be using the administrator of your
tenant, which is the user you created when the tenant was provisioned**

Now let's install Oracle CLI and kubectl, execute this:

`./installCLI.sh`{{execute}}

Let's ensure that the oci cli is in our PATH:

`export PATH=/root/bin:$PATH`{{execute}}

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and is connected to your tenant.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Let's also test that kubectl install and working properly, execute the following:
`kubectl version`{{execute}}

You should receive something like this:

~~~~
Client Version: version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.3", GitCommit:"06ad960bfd03b39c8310aaf92d1e7c12ce618213", GitTreeState:"clean", BuildDate:"2020-02-12T13:43:46Z", GoVersion:"go1.13.7", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
~~~~

Let´s also create the following environment variables, that we will use in the next steps:

`export TENANT_OCID=$(grep -i 'tenancy' $HOME/.oci/config  | cut -f2 -d'=' | head -1)`{{execute}}

For the lab purposes you will be assigned with a LAB ID number, execute this with the ID that the instructor assigns to you:

`export LAB_ID=1`{{execute}}

In Part 1 of the OKE Scenario you wrote down the name of your cluster, if you've followed the instructions your cluster name is MyFirstOKE. Let's set that
as an environment variable:

`export MY_CLUSTER_NAME=MyFirstOKE`{{execute}}

If you've set a different name, please set the variable accordingly.