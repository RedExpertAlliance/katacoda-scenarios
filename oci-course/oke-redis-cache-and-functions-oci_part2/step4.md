## Deploy Redis

First of all, what is Redis?

Taken from their [webiste](https://redis.io "Redis Homepage") :
 
![REDIS](/RedExpertAlliance/courses/oci-course/oke-redis-cache-and-functions-oci/assets/redis.jpg)

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

`cd redis-session-api`{{execute}}

`kubectl apply -f kubernetes/redis-deployment.yml -n $NAMESPACE`{{execute}}

Then wait (around 30s) for the redis cluster to be ready, issuing:

`kubectl get pods -n $NAMESPACE -w`{{execute}}

~~~~
NAME                                    READY     STATUS        RESTARTS   AGE
redis-664f6d6bcd-bs56r                  1/1       Running       0          46h
~~~~
(Note. The -w option is to make the command to keep running every second, we will use it to have for the status to turn into Running)

Wait for the status to turn into "Running", then do a ctrl+c, to get back at the command line.


## Deploy Redis service

With our Redis instance up and running we will deploy the servie describe in the file "kubernetes\redis-svc.yml". 

To deploy it, we will use the same thing as the previous step. That is:

`kubectl apply -f kubernetes/redis-svc.yml -n $NAMESPACE`{{execute}}

To validate that our service is running properly, let's do this:

`kubectl get services -n $NAMESPACE`{{execute}}

You should get something like this:

~~~~
NAME      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
redis     ClusterIP   10.96.195.244   <none>        6379/TCP   31s
~~~~

Now that we have our Redis cluster and our Redis service running properly, we will create a Docker image that contains our Go application (API) that will
be deployed into our cluster and that will use the Redis Service.
