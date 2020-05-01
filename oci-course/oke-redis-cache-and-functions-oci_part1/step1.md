## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

If you do not have the OCI config file, nor the oci API key yet, you can go through these steps: https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm

Once you have the config file and the api key, copy their contents in ~/.oci/config and ~/.oci/oci_api_key.pem respectively. 

**Remember that in this scenario you will be working with a newly created 30 day free trial OCI instance, and you will be using the administrator of your
tenant, which is the user you created when the tenant was provisioned**

**Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and is connected to your tenant.**

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

`export LAB_ID=1`{{execute}}

`cs=$(oci iam compartment list)`{{execute}}
`export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')`{{execute}}
`echo "Compartment lab-compartment OCID=$compartmentId"`{{execute}}


## Oracle Kubernetes Engine Cluster Creation

With your 30-days free trial account you can create an OKE instance, so let's do it. We will use the quick-create wizard, that simplifies the steps.
In order to do that, go to your Tenant Dashboard and then go to this menu:

![OKE Menu](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/1.jpg)

Once there, click on the Create Cluster blue button:

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/02.jpg)

Select the Quick Create option, and then Launch Workflow:

![OKE Quick Create Option](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/03.jpg)

Once in the workflow window, give ***MyFirstOKE*** as the name, select the compartment lab-compartment; **for number of nodes select 2** and leave 
the rest of the fields as default:

![OKE Workflow](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/13.jpg)

In the lower part of the window enable both Tiller and Kubernetes Dashboard:

![OKE Enable Tiller](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/5.jpg)

Finally, click on Next:

![OKE Click on Next](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/06.jpg)

And read the summary for your cluster:

![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/7.jpg)

Click on Create Cluster and wait for the cluster to be created. In the home page for OKE, wait for the status to be Active (**it may take around 25 minutes**):

![OKE Ready](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/8.jpg)

You just have to wait, do not go to any other section of the Web Console, just be patient. 
Once the status turned into Active, you are about to be able to use it. **Do not proceed until the status goes to Active.**

Let's set the following variable to identify the cluster name:

`export MY_CLUSTER_NAME=MyFirstOKE`{{execute}} 

Let's go the next step!