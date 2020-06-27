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

`oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0`{{execute}}

And finally, let's create an environment variable that points to our kubeconfig file:

`export KUBECONFIG=$HOME/.kube/config`{{execute}}

Now you can try to get the namespaces of the newly created K8s cluster, with this:

`kubectl get namespaces`{{execute}}

You will get something like this:

~~~~
NAME              STATUS   AGE
default           Active   33m
kube-node-lease   Active   33m
kube-public       Active   33m
kube-system       Active   33m
~~~~

Up to this point you have configured a Kubernetes cluster on top of Oracle Cloud Infrastructure. It is a Kubernetes cluster with 3 nodes. Those nodes
are OCI compute instances that were created automatically by the quick creation wizard.
The Kubernetes API Server is serving at the IP address that you can check in the ~/kube/config file and listening on port 6443.

## OCI Cloud Shell
The OCI Cloud Shell us a browser based command line interface that is available in the OCI Console. The Cloud Shell environment is configured for accessing OCI resources. It provides many tools - including the OCI CLI, Terraform, Fn CLI and also kubectl. The OKE Cluster instance that you have created can be accessed using kubectl in the Cloud Shell. You can try this out in the next (Bonus) step/