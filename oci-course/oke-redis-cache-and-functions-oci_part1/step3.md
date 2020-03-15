To quickly assess our new Kubernetes cluster, we can make use of OCI Cloud Shell with its preinstalled kubectl CLI tool. 

Note: All commands in this step need to be executed in Cloud Shell - not in the Katacoda terminal environment.

To access the Kubernetes cluster through Cloud Shell, go through these steps:
1. Copy the contents of file ~/.kube/config to the clipboard
2. Open Cloud Shell in OCI Console
In Cloud Shell, execute these commands:
3. `touch $HOME/.kube/config`
4. `vi $HOME/.kube/config`
5. Paste the contents of the clipboard to the *config* file and save the file
To check whether you can access the Kubernetes Cluster and whether it is running successfully, execute this command to learn about the version of the Kubernetes Cluster:
6. `kubectl version`
And to list all pods in all namespaces:
7. `kubectl get pods -A=true`

You can go one step further and create a new deployment on the Kubernetes cluster. Still in Cloud Shell, execute these commands to create a a deployment of a *hello world* application and subsequently expose that application through a load balancer as a public application: 

```
kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
kubectl get deployments
kubectl expose deployment hello-node --type=LoadBalancer --port=8080
```

List the services:
`kubectl get services`
This will show a list of services in the *default* namespace. This should include a service with name *hello-node* of type *LoadBalancer* and with an external IP assigned. Using this IP address, you can access the *hello-node* application from a new browser window, at *http://<IP-ADDRESS>:8080* . The browser should show the result from the container at the heart of the pod that is created with the *hello-node* deployment: *Hello World!*.

To clean up after ourselves, execute these commands:
```
kubectl delete service hello-node
kubectl delete deployment hello-node
```



