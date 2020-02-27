## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

If you do not have the OCI config file, nor the oci API key yet, you can go through these steps: https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm

Once you have the config file and the api key, copy their contents in ~/.oci/config and ~/.oci/oci_api_key.pem respectively.

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
(Note. Change the tenantID value for the one that is in the ~/.oci/config file)

`export TENANT_OCID=tenantID`{{execute}}

## Policy pre-requisite

Before creating the cluster, you need to apply a Policy to allow OKE to manage your tenant resources. This policy creation is described here:
https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#PolicyPrerequisitesService

Please create that policy before continue with the next section.

In this scenario we will use both the Oracle Cloud Infrastructure Web Console and the Oracle CLI. In particular in this first step, most of the things 
will be executed using the Web Console.

Please create that policy and then continue with the next section.

For the lab purposes you will be assigned with a LAB ID number, execute this with the ID that the instructor assigns to you:

`export LAB_ID=1`{{execute}}


## Oracle Kubernetes Engine Cluster Creation

With your 30-days free trial account you can create an OKE instance, so let's do it. We will use the quick-create wizard, that simplifies the steps.
In order to do that, go to your Tenant Dashboard and then go to this menu:

![OKE Menu](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/1.jpg)

Once there, click on the Create Cluster blue button:

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/02.jpg)

Select the Quick Create option, and then Launch Workflow:

![OKE Quick Create Option](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/03.jpg)

Once in the workflow window, give ***MyFirstOKE*** as the name, select the compartment and leave the rest of the fields as default:

![OKE Workflow](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/04.jpg)

Let's create an enviornment variable with the value of the name of the OKE cluster:

`export MY_CLUSTER_NAME=MyFirstOKE`{{execute}}

In the lower part of the window enable both Tiller and Kubernetes Dashboard:

![OKE Enable Tiller](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/05.jpg)

Finally, click on Next:

![OKE Click on Next](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/06.jpg)

And read the summary for your cluster:

![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/07.jpg)

Click on Create Cluster and wait for the cluster to be created. In the home page for OKE, wait for the status to be Active:

![OKE Ready](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/08.jpg)

Once the status turned into Active, you are about to be able to use it.

Let's go the next step!