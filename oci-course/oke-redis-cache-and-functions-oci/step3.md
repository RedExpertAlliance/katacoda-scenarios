# Deploy your first application to OKE

We have our cluster up and running, now we are going to follow the next steps to deploy our application on top of it:

1. Download the code
2. We are going to create a namespace where we will deploy our application. We will learn more about namespaces later on.
3. Our first deployment will be the Redis cluster, using a StatefulSet (YML)
4. On top of the Redis Cluster we will deploy a service (YML)
5. We are going to use a Docker file that will contain our main.go application
6. With the Docker image created, we will register it on Oracle Container Registry (OCIR)
7. Once register, we are going to deploy our Go application (API) from a yaml file
8. We will expose the service


## Download the code

To download the code execute this:

`git clone https://github.com/muchacho/repo.git`{{execute}}

This code was created by Ricardo Ortega.

## Namespace creation

Namespaces are created to organize what you deploy on top of your cluster. In the Kubernets documentation you will read that namespaces are like virtual clusters
deployed on the same physical cluster.
The intention to create namespaces is to be used in environments where you have differente users working in different teams and projects.

After you created your cluster, you will have a set of default namespaces. Exeute this to get the list:

`kubectl get namespaces`{{execute}}

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/09.jpg)

Those are the default namespaces. 

For our scenario we will create the namespace: ociLab + $LAB_ID

`export NAMESPACE=ocilab$LAB_ID`{{execute}}

Now let's create the namespace:

`kubectl create namespace $NAMESPACE`{{execute}}

If you re-issue the `kubectl get namespaces`{{execute}}  you will see your newly created namespace listed:

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/10.jpg)

In order to deploy your artifacts to the ocilab#LAB_ID namespace, you just need to include the option -n $NAMESPACE within the kubectl commands. 

For example, to get the list of pods in the $NAMESPACE, you will do:

`kubectl get pods $NAMESPACE`{{execute}}

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/11.jpg)

## Deploy Redis Cluster

First of all, what is Redis?

Taken from their [webiste](https://redis.io "Redis Homepage") :
 
![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/12.jpg)

Basically is an in-memory data structure store, that can be used as a database.

In our scenario we will use it to store a session of a user that wants to use and API. The session will last one minute, and the token will be stored in Redis.

We know is a simple scenario, but is a valid one.

The yaml file for our Redis is the following:

~~~~
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-cart
spec:
  selector:
    matchLabels:
      app: redis-cart
  template:
    metadata:
      labels:
        app: redis-cart
    spec:
      containers:
      - name: redis
        image: redis:alpine
        ports:
        - containerPort: 6379
        readinessProbe:
          periodSeconds: 5
          tcpSocket:
            port: 6379
        livenessProbe:
          periodSeconds: 5
          tcpSocket:
            port: 6379
        volumeMounts:
        - mountPath: /data
          name: redis-data
        resources:
          limits:
            memory: 256Mi
            cpu: 125m
          requests:
            cpu: 70m
            memory: 200Mi
      volumes:
      - name: redis-data
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: redis-cart
spec:
  type: ClusterIP
  selector:
    app: redis-cart
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
~~~~

We need first to change directories to where the Redis service yaml file is located

`cd redisapp\yaml\redis`{{execute}}

And then apply the yaml file into our cluster within the namespace that we created steps before:

`kubectl apply -f redisCluster.yml -n $NAMESPACE` {{execute}}

Then wait for the redis cluster to be ready, issuing:

`kubectl get pods -n $NAMESPACE -w` {{execute}}

~~~~
NAME                                    READY     STATUS        RESTARTS   AGE
kube-dns-664f6d6bcd-bs56r               3/3       Running       0          46h
kube-dns-664f6d6bcd-d29mf               3/3       Running       0          133d
kube-dns-664f6d6bcd-ks8bc               3/3       Running       0          21d
~~~~
(Note. The -w option is to make the command to keep running every second, we will use it to have for the status to turn into Running)

Wait for the status to turn into "Running", then do a ctrl+c, to get back at the command line.


## Deploy Redis service

With our cluster up and running we will deploy the servie describe in the file "redisapp\yaml\redis\redisService.yaml". 

To deploy it, we will use the same thing as the previous step. That is:

`cd redisapp\yaml\redis`{{execute}}

And then apply the yaml file into our cluster:

`kubectl apply -f redisService.yml -n $NAMESPACE` {{execute}}

To validate that our service is running properly, let's do this: <TBD>

Now that we have our Redis cluster and our Redis service running properly, we will create a Docker image that contains our Go application (API) that will
be deployed into our cluster and that will use the Redis Service.

## Build Docker image for our Go application

The Go application will represent the API that will be used as an authentication API. The idea of this API is to authenticate the user and return a session token,
this session token will be stored in Redis for about 01 minute. After 01 minute the token will be invalidated and the user will have to re-authenticate.

In order to buld the Docker image , let's go to the folder where is located our code and our Docker file.

`cd redisapp\docker\goapp\`{{execute}}

In this folder we will find the Dockerfile:

~~~~
<Include the Dockerfile>
~~~~

Now let's build the image:

`docker build -t lab-user/ocilab:latest`{{execute}}

Ather that, use `docker images`{{execute}} to see that the image is created and is register locally.

Before tagging it we need some environment variables to be set:

cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

~~~~
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

vcns=$(oci network vcn list -c $compartmentId)
vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')
~~~~

Now let's tag it. 

`docker tag lab-user/ocilab:latest us-ashburn-1.ocir.io/$ns/$ocirname/ocilab:latest`{{export}} 

So far we have an image that contains our Go code, and is locally in our file system. Now we need to register in Oracle Container Registry

## Image Registration

The first step is to login to OCIR:

`docker login us-ashburn-1.ocir.io`{{execute}}

You will be prompted for your user. The notation you need to use is $ns/lab-user. And for the password, is the Auth Token that you generated in Step 4
for the OCI Lab preparation https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation

Now let's push the image to OCIR:

`docker push lab-user/ocilab:latest us-ashburn-1.ocir.io/$ns/$ocirname/ocilab:latest`
The result must me something like this:
~~~~
docker push us-ashburn-1.ocir.io/idi66ekilhnr/spsocir/ocilab:latest
The push refers to repository [us-ashburn-1.ocir.io/idi66ekilhnr/spsocir/ocilab]
1112f2a480f2: Pushed
5f230b75e4e6: Pushed
b84de462b650: Pushed
4a002260d1af: Pushed
095d7efa0cae: Pushed
bd396ca583fd: Pushed
4a5caac3e4d5: Pushed
e68b1a0edd35: Pushed
fb56a84bb9b7: Pushed
623948add310: Pushed
a585345fa3ec: Pushed
a0c8b3c04370: Pushed
8035cb2ef148: Pushed
9acfe225486b: Pushed
90109bbe5b76: Pushed
cb81b9d8a6c9: Pushed
ea69392465ad: Pushed
latest: digest: sha256:fdf4de48313d3c1715aed9266c58ab738c848a5919fddb895b0a505bb402b4be size: 3862
~~~~

If you login to your OCI tenant and go to OCIR, you will see something like this:

![OCIR](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/12.jpg)

The image has been pushed to your OCI registry.

Now we are ready to deploy our Go API.

## Go API deployment

To deploy our Go API we need first to create a Kubernetes Secret to store our Docker Registry credentials, that kubernetes needs to know to pull the image 
and deploy it to the cluster.

Let's create the secret:
kubectl create secret docker-registry ocilabsecret --docker-server=us-ashburn-1.ocir.io --docker-username='"'"$user"'"' --docker-password='"'"$pwd"'"' --docker-email='"'"$youremail"'"' -n $NAMESPACE

Now let's edit our yaml file located in:

`cd redisapp\yaml\go`{{execute}}

Edit the go.yaml file and include this entry:
~~~~
      imagePullSecrets:
      - name: ocilabsecret
~~~~

Now let's deploy our service, with:

`kubectl apply -f go.yml -n $NAMESPACE` {{execute}}

