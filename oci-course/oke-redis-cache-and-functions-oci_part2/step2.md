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

To test it, let's use the kubectl command to validate that we are able to connect to our cluster:

`kubectl get pods`{{execute}}

The result should be something like this:
~~~~
No resources found in default namespace.
~~~~

(Note. You will get different names and ages, but a similar output should be shown)