## Create kube config file and connect to your cluster

Once the cluster is in Active state, we can create the kubeconfig file in order to connect to the cluster usin *kubectl*.
If you want to learn more about the kubeconfig file, please take a look at here: https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengdownloadkubeconfigfile.htm

Let's create the kubeconfig file using the following steps:

First let's validate our OCI CLI version:
`oci -v`{{execute}}

Now let's create the kubeconfig file:
`mkdir -p $HOME/.kube`{{execute}}

Now let's get the cluster id of our cluster with this:

`clusterlist=$(oci ce cluster list -c $compartmentId)`{{execute}}

With the list of clusters, now let's get the clusterID of our particular cluster ($MY_CLUSTER_NAME):

`export CLUSTER_ID=$(echo $clusterlist | jq -r --arg display_name $MY_CLUSTER_NAME '.data[] | select ((.name == $display_name) and (."lifecycle-state" == "ACTIVE")) | .id')`{{execute}}

`echo "The cluster ID is $CLUSTER_ID"`{{execute}}

Now let's just be sure that our PATH environment variable is well set:

`export PATH=/root/bin/:$PATH`{{execute}}

And let's configure it:

`oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region $REGION --token-version 2.0.0`{{execute}}

And finally, let's create an environment variable that points to our kubeconfig file:

`export KUBECONFIG=$HOME/.kube/config`{{execute}}

Now we need to get the IP address for our OKE API Server. Remember, katacoda is blocking port 6443, and that is the port where our API Server is serving.
We need to write down the IP address and then go to the OCI Compute instance creation scenario to configure the reverse proxy that we will use in Part 2 
of this OKE scenario.

Go to the File /root/.kube/config and get the hostname. Is something like this:

~~~~
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURqRENDQW5TZ0F3SUJBZ0lVTThsYWVMUGZrRmo3RmJtODd3c0VtK01iRTNV
d0RRWUpLb1pJaHZjTkFRRUwKQlFBd1hqRUxNQWtHQTFVRUJoTUNWVk14RGpBTUJnTlZCQWdUQlZSbGVHRnpNUTh3RFFZRFZRUUhFd1pCZFhOMAphVzR4RHpBTkJnTlZCQW9U
Qms5eVlXTnNaVEVNTUFvR0ExVUVDeE1EVDBSWU1ROHdEUVlEVlFRREV3WkxPRk1nClEwRXdIaGNOTVRrd09ERXdNVGN6T0RBd1doY05NalF3T0RBNE1UY3pPREF3V2pCZU1R
c3dDUVlFRQmtvcTgzNHdXR1FSMWwzTWVENWIrZApJbGNsblZlV0VTL0N1QkxMdG9kemZQWjBrMW5O
MzFUclIwZmUvUUJnVkhwRlQzQVp0cnBCNU43VytqR0t3RStuCk1QU0ZocUNxbHpLVDhUV0ZXZnRYOEI4bnBUQ1JCNWYzQm1ZZ1pielNvYU5SaTVzeWtpMW5ybk9CVkN3anB4
aU4KcGNrOGtsem51SmRHaGxaSzdJdTNISVF0RC9tREZqd3hKMjQyMmRTMThJNGMwY01kMGxVR3l0TnJKVnR0OVFXWgpvajB0YkRsY0liaEtsT1RVSTdybnplUGE0OEJZOFJC
NjAyRWxtbGxoUmZQWFNEUDR1bHEvVjlnT2t1ZFlMaE1ECjVJYzZDKy9mZTUxZmpZM1M0T3prODkyWWRWOHdublM2Y2RQZkNiOGVIenhEMEI5cHhZWHVsdVpuN2tKbk1ZUVUK
LS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    server: https://<IP_ADDRESS>:6443     <-----
  name: cluster-c3tgnzyga2t
~~~~

**Write down the IP Address and you can proceed to scenario:
https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-api-server-reverse-proxy**

Up to this point you have configured a Kubernetes cluster on top of Oracle Cloud Infrastructure. It is a Kubernetes cluster with 3 nodes. Those nodes
are OCI compute instances that were created automatically by the quick creation wizard.
The Kubernetes API Server is serving at the IP address that you can check in the ~/kube/config file and listening on port 6443.

## OCI Cloud Shell
The OCI Cloud Shell us a browser based command line interface that is available in the OCI Console. The Cloud Shell environment is configured for accessing OCI resources. It provides many tools - including the OCI CLI, Terraform, Fn CLI and also kubectl. The OKE Cluster instance that you have created can be accessed using kubectl in the Cloud Shell. You can try this out in the next (Bonus) step/