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

`git clone https://github.com/manraog/redis-session-api.git`{{execute}}

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

In order to deploy your artifacts to the ocilab$LAB_ID namespace, you just need to include the option -n $NAMESPACE within the kubectl commands. 

For example, to get the list of pods in the $NAMESPACE, you will do:

`kubectl get pods -n $NAMESPACE`{{execute}}

![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/11.jpg)

## Deploy Redis

First of all, what is Redis?

Taken from their [webiste](https://redis.io "Redis Homepage") :
 
![OKE Create Cluster](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/12.jpg)

Basically is an in-memory data structure store, that can be used as a database.

In our scenario we will use it to store a session of a user that wants to use and API. The session will last one minute, and the token will be stored in Redis.

We know is a simple scenario, but is a valid one.

The yaml file for our Redis is the following:

~~~~
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:5.0
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
      volumes:
      - name: redis-data
        emptyDir: {}
~~~~

We apply the yaml file into our cluster within the namespace that we created steps before:

`kubectl apply -f kubernetes/redis-deployment.yml -n $NAMESPACE`{{execute}}

Then wait for the redis cluster to be ready, issuing:

`kubectl get pods -n $NAMESPACE -w` {{execute}}

~~~~
NAME                                    READY     STATUS        RESTARTS   AGE
redis-664f6d6bcd-bs56r                  1/1       Running       0          46h
~~~~
(Note. The -w option is to make the command to keep running every second, we will use it to have for the status to turn into Running)

Wait for the status to turn into "Running", then do a ctrl+c, to get back at the command line.


## Deploy Redis service

With our Redis instance up and running we will deploy the servie describe in the file "kubernetes\redis-svc.yaml". 

To deploy it, we will use the same thing as the previous step. That is:

`kubectl apply -f kubernetes/redis-svc.yml -n $NAMESPACE` {{execute}}

To validate that our service is running properly, let's do this: <TBD>

Now that we have our Redis cluster and our Redis service running properly, we will create a Docker image that contains our Go application (API) that will
be deployed into our cluster and that will use the Redis Service.

## Build Docker image for our Go application

The Go application will represent the API that will be used as an authentication API. The idea of this API is to authenticate the user and return a session token,
this session token will be stored in Redis for about 2 minutes. After 2 minutes the token will be invalidated and the user will have to re-authenticate.

Inside api folder we will find the Dockerfile and de go code:

~~~~
# Golang base image
FROM golang:1.7.4

# Set the current working directory
WORKDIR /go/src/app

# Copy code file
COPY . .

# Download all dependencies
RUN go get -d -v ./...
RUN go install -v ./...

# Build the Go app
RUN go build -o api .

# Expose port
EXPOSE 8080

# Command to run the executable
ENTRYPOINT ["./api"]
~~~~

Now let's build the image:

`docker build api -t lab-user/session-api:1.0.0`{{execute}}

After that, use `docker images`{{execute}} to see that the image is created and is registered locally.

Before tagging it we need some environment variables to be set:

`cs=$(oci iam compartment list)`{{execute}}

`export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')`{{execute}}

```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

vcns=$(oci network vcn list -c $compartmentId)
vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')
export ocirname=cloudlab
```{{execute}}

Now let's tag it. 

`docker tag lab-user/session-api:1.0.0 us-ashburn-1.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}} 

So far we have an image that contains our Go code, and is locally in our file system. Now we need to register in Oracle Container Registry

## Image Registration

The first step is to login to OCIR:

`docker login us-ashburn-1.ocir.io`{{execute}}

You will be prompted for your user. The notation you need to use is $ns/lab-user. And for the password, is the Auth Token that you generated in Step 4
for the OCI Lab preparation https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation

Now let's push the image to OCIR:

`docker push lab-user/ocilab:latest us-ashburn-1.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}}
The result must me something like this:
~~~~
docker push us-ashburn-1.ocir.io/idi66ekilhnr/spsocir/session-api:1.0.0
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

Let's create the secret. But before that, set the following 03 environment variables.
***(Note. For pwd and youremail, set your information. The password is the one you used for login to docker)*** 

`export user=$ns/lab-user`{{execute}}

`export pwd=mypwd`{{execute}}

`export youremail=me@me.com`{{execute}}

Now execute the following to create the secret:
`kubectl create secret docker-registry ocilabsecret --docker-server=us-ashburn-1.ocir.io --docker-username=$user --docker-password=$pwd --docker-email=$youremail -n $NAMESPACE`{{execute}}

Now let's edit our yaml file: session-api.yml. We will edit with the value of variable $image, that is going to be set with the following export.

`export image=us-ashburn-1.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}}
`echo $image`{{execute}}

Find the image reference and change it for the value of the variable $image.

~~~~
image: docker.io/rortegasps/redis-session:latest
~~~~

Now let's deploy our api, with:

`kubectl apply -f session-api.yml -n $NAMESPACE`{{execute}}

To find out if the service was properly deploy, execute:

`kubectl get services $NAMESPACE`{{execute}}

In the next step you will test the newly created service.