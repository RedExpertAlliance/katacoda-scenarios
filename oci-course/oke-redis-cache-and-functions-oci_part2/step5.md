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

~~~~
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
lab-user/session-api   1.0.0               d92490bd187e        40 seconds ago      688MB      <---
alpine                 latest              cdf98d1859c1        12 months ago       5.53MB
redis                  latest              a55fbf438dfd        13 months ago       95MB
ubuntu                 latest              94e814e2efa8        13 months ago       88.9MB
weaveworks/scope       1.10.1              b0d8090d0e91        17 months ago       75.7MB
weaveworks/scope       1.9.1               4b07159e407b        21 months ago       68MB
golang                 1.7.4               f3bdc5e851ce        3 years ago         674MB
~~~~

Before tagging it we need some environment variables to be set:

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

`docker tag lab-user/session-api:1.0.0 $REGION.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}} 

So far we have an image that contains our Go code, and is locally in our file system. Now we need to register in Oracle Container Registry

## Image Registration

We will login to our Oracle Cloud Image Registry to register our image, the username you have to provide is composed of `<tenancy-namespace>/<username>`.
Let's get the username and namespace executing this:
 
```
NAMESPACE=$(oci os ns get| jq -r  '.data')
USER_USERNAME=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."name"')
echo "Username for logging in into Container Registry is $NAMESPACE/$USER_USERNAME"
```{{execute}}

The password is an Authentication Token generated for the specified user, in the OCI Tenancy preparation scenario. If you do not remember the authentication token, you can generate another one in the OCI Console:  https://console.REGION.oraclecloud.com/identity/users/<user-ocid>/swift-credentials or using the instructions in the preparation scenario. 

`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/identity/users/$USER_OCID/swift-credentials"`{{execute}}

Now you can perform the login. Type the username and press enter, then type or paste the authentication token and press enter again. 

`docker login ${REGION_KEY,,}.ocir.io`{{execute}}

Now let's push the image to OCIR:

`docker push $REGION.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}}
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

![OCIR](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/ocir.jpg)

You can open the registry with this url:

`echo "Open the console at https://console.us-ashburn-1.oraclecloud.com/containers/registry"`{{execute}}

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
`kubectl create secret docker-registry ocilabsecret --docker-server=us-ashburn-1.ocir.io --docker-username=$user --docker-password=$pwd --docker-email=$youremail -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

To validate that it was creted, execute:

`kubectl get secrets -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

And you will get something like this:

~~~~
NAME                  TYPE                                  DATA      AGE
default-token-bz52x   kubernetes.io/service-account-token   3         19m
istio.default         istio.io/key-and-cert                 3         19m
ocilabsecret          kubernetes.io/dockerconfigjson        1         5s   <----
~~~~

**Now let's edit our yml file: kubernetes/session-api.yml. We will edit with the value of variable $image, that is going to be set with the following export.**

`export image=$REGION.ocir.io/$ns/$ocirname/session-api:1.0.0`{{execute}}

`echo $image`{{execute}}

Find the image reference and change it for the value of the variable $image.

~~~~
image: docker.io/rortegasps/redis-session:latest
~~~~

Now let's deploy our api, with:

`kubectl apply -f kubernetes/session-api.yml -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

To find out if the service was properly deployed, execute:

`kubectl get services -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

Wait for the External IP address to be assigned (and do not proceed until that happens). After executing the previous command it should be in **pending** state:

~~~~
NAME          TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
redis         ClusterIP      10.96.223.56    <none>        6379/TCP       16m
session-api   LoadBalancer   10.96.207.217   <pending>     80:31039/TCP   38s
~~~~

And after some seconds, you should get something like this:

~~~~
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
redis         ClusterIP      10.96.223.56   <none>         6379/TCP       30m
session-api   LoadBalancer   10.96.31.202   150.111.2.49   80:31548/TCP   82s
~~~~

(Note. **Do not proceed until you get an IP address assgined**)

In the next step you will test the newly created service.