## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

If you do not have the OCI config file, nor the oci API key, you can go through these steps: https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and is connected to your tenant.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.


## Policy pre-requisite

Before creating the cluster, you need to apply a Policy to allow OKE to manage your tenant resources. This policy creation is described here:
https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#PolicyPrerequisitesService

Please create that policy and then continue with the next section.

## Oracle Kubernetes Engine Cluster Creation

With your 30-days free trial account you can create an OKE instance, so let's do it. We will use the quick-create wizard, that simplifies the steps.
In order to do that, go to your Tenant Dashboard and then go to this menu:

![OKE Menu](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/1.jpg)

Once there, click on the Create Cluster blue button:

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/2.jpg)

Select the Quick Create option, and then Launch Workflow:

![OKE Quick Create Option](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/3.jpg)

Once in the workflow window, give a name to your cluster, select the compartment and leave the rest of the fields as default:

![OKE Workflow](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/4.jpg)

In the lower part of the window enable both Tiller and Kubernetes Dashboard:

![OKE Enable Tiller](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/5.jpg)

Finally, click on Next:

![OKE Click on Next](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/6.jpg)

And read the summary for your cluster:

![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/7.jpg)

Click on Create Cluster and wait for the cluster to be created. In the home page for OKE, wait for the status to be Active:

![OKE Ready](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/8.jpg)