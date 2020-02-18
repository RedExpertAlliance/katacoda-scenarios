## Create kube config file and connect to your cluster

Once the cluster is in Active state, we can create the kubeconfig file in order to connect to it.
If you want to learn more about the kubeconfig file, please take a look at here: https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengdownloadkubeconfigfile.htm

Let's create the kubeconfig file using the following steps:

First let's validate our OCI CLI version:
`oci -v`{{execute}}

Now let's create the kubeconfig file:
`mkdir -p $HOME/.kube`{{execute}}

Now let's get the cluster id of our cluster with this:

`clusterlist=$(oci ce cluster list -c $TENANT_ID)`{{execute}}
`export CLUSTER_ID=$(echo $clusterlist | jq -r --arg display_name "RCPK8sCluster" '.data | map(select(."name" == $display_name)) | .[0] | .id')`{{execute}}

And let's configure it:

`oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0`{{execute}}

And finally, let's create an environment variable that points to our kubeconfig file:

`export KUBECONFIG=$HOME/.kube/config`{{execute}}

To test it, let's use the kubectl command to validate that we are able to connect to our cluster:

`kubectl get pods`{{execute}}

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

(Note. You will get different names, but a similar output should be printed)

With this we have our cluster ready to be used.