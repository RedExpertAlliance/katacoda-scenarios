## Create kube config file and connect to your cluster

Once the cluster is in Active state, we can create the kubeconfig file in order to connect to it.
If you want to learn more about the kubeconfig file, please take a look at here: https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengdownloadkubeconfigfile.htm

Let's create the kubeconfig file using the following steps:

First let's validate our OCI CLI version:
`oci -v`{{execute}}

Now let's create the kubeconfig file:
`mkdir -p $HOME/.kube`{{execute}}

Now let's get the cluster id of our cluster with this:

`clusterlist=$(oci ce cluster list -c $TENANT_OCID)`{{execute}}

With the list of clusters, now let's get the clusterID of our particular cluster ($MY_CLUSTER_NAME):

`export CLUSTER_ID=$(echo $clusterlist | jq -r --arg display_name $MY_CLUSTER_NAME '.data | map(select(."name" == $display_name)) | .[0] | .id')`{{execute}}

And let's configure it:

`oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0`{{execute}}

And finally, let's create an environment variable that points to our kubeconfig file:

`export KUBECONFIG=$HOME/.kube/config`{{execute}}

**Before testing it, please use the IP address that you got from the OCI Compute instance creation scenario and open the File `/root/.kube/config`{{open}} to 
change the current value for the hostname of the API Server to point to the IP address of your reverse proxy you've created in the mentioned scenario:**

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
    server: https://<PLACE_HERE_THE_IP_ADDRESS>:6443
  name: cluster-c3tgnzyga2t
~~~~

To test it, let's use the kubectl command to validate that we are able to connect to our cluster:

`kubectl get pods --insecure-skip-tls-verify`{{execute}}

The result should be something like this:
~~~~
NAME                                    READY     STATUS        RESTARTS   AGE
kube-dns-664f6d6bcd-d29mf               3/3       Running       0          128d
kube-dns-664f6d6bcd-hx4wm               3/3       Running       0          2d14h
kube-dns-664f6d6bcd-ks8bc               3/3       Running       0          16d
kube-dns-autoscaler-658fbb9654-5bljm    1/1       Running       0          128d
kube-flannel-ds-2wtbt                   1/1       Running       1          191d
kube-flannel-ds-nmv28                   1/1       Running       1          191d
kube-flannel-ds-v2z8l                   1/1       Running       1          191d
kube-proxy-h7cn8                        1/1       Running       0          191d
kube-proxy-rk87x                        1/1       Running       0          191d
kube-proxy-vjjsq                        1/1       Running       0          191d
kubernetes-dashboard-78ccc578b6-mmfzf   1/1       Running       16         2d14h
proxymux-client-10.0.10.2               1/1       Running       0          191d
proxymux-client-10.0.11.2               1/1       Running       0          191d
proxymux-client-10.0.12.2               1/1       Running       0          191d
tiller-deploy-5d6cc99fc-45mwd           1/1       Running       0          128d
~~~~

(Note. You will get different names and ages, but a similar output should be shown)