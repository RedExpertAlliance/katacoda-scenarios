## Create kube config file and connect to your cluster

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

And let's configure it:

`oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0`{{execute}}

And finally, let's create an environment variable that points to our kubeconfig file:

`export KUBECONFIG=$HOME/.kube/config`{{execute}}

**Before testing it, please use the IP address that you got from the OCI Compute instance creation scenario and open the file /root/.kube/config from the 
file explorer, to change the current value for the hostname of the API Server to point to the IP address of your reverse proxy you've created in the 
mentioned scenario. Also change the port from 6443 to 443:**

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
    server: https://<PLACE_HERE_THE_IP_ADDRESS>:<CHANGE PORT TO 443>
  name: cluster-c3tgnzyga2t
~~~~

To test it, let's use the kubectl command to validate that we are able to connect to our cluster:

`kubectl get pods --insecure-skip-tls-verify`{{execute}}

(**Note. We need to use the --insecure-skip-tls-verify flag, in order to use our reverse proxy**)

The result should be something like this:
~~~~
No resources found in default namespace.
~~~~
(Note. You will get different names and ages, but a similar output should be shown)