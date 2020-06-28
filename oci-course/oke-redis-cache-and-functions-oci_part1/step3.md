To quickly assess our new Kubernetes cluster, we can make use of OCI Cloud Shell with its preinstalled kubectl CLI tool. 

Note: All commands in this step need to be executed in Cloud Shell - not in the Katacoda terminal environment.

To access the Kubernetes cluster through Cloud Shell, go through these steps:
1. Go to the OKE console
`echo "Open console at https://console.us-ashburn-1.oraclecloud.com/containers/clusters"`{{execute}}
2. Click on the newly created cluster
![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/clusterConsole.jpg)
3. Click on the button Access cluster
![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/cshell1.jpg)
4. Copy the command:
![OKE Summary](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci_part1/assets/cshell2.jpg)
5. Open Cloud Shell in OCI Console
6. Paste the contents of the clipboard, this will create the config file for K8s
To check whether you can access the Kubernetes Cluster and whether it is running successfully, execute this command to learn about the version of the Kubernetes Cluster:
7. `kubectl version`
And to list all pods in all namespaces:
8. `kubectl get pods -A=true`

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



