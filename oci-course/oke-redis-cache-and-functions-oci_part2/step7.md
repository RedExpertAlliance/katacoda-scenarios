## Scaling our API

The deployment whe used to deploy our API only created one instance

We can verify this on the session-api.yml file.

```
cat kubernetes/session-api.yml | grep replicas
```{{execute}}

And listing our pods
`kubectl get pods -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

If we have too much requests we can can create more instances or pods to handle it.
`kubectl scale --replicas=10 deployment session-api -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

Now we have 10 session-api pods:
`kubectl get pods -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

You should get something like this:

~~~~
NAME                           READY     STATUS    RESTARTS   AGE
redis-656759dbd4-2dzgh         1/1       Running   0          43m
session-api-5d497db7f6-4q7zw   1/1       Running   0          73s
session-api-5d497db7f6-682wc   1/1       Running   0          73s
session-api-5d497db7f6-99bfn   1/1       Running   0          73s
session-api-5d497db7f6-bz682   1/1       Running   0          73s
session-api-5d497db7f6-dhl4v   1/1       Running   0          73s
session-api-5d497db7f6-ljs97   1/1       Running   0          73s
session-api-5d497db7f6-mp299   1/1       Running   0          5m26s
session-api-5d497db7f6-rb75g   1/1       Running   0          73s
session-api-5d497db7f6-tdbtq   1/1       Running   0          73s
session-api-5d497db7f6-zfpmr   1/1       Running   0          73s
~~~~

(**Wait until you get Running in all pods' status**)

Our load balancer service is going distribute the requests to all our pods. 

To verify this, we are going hit 3(three) times our login endpoint and validate the origin field of the response. 
The origin field is the name of the pod that is responding.
```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Hugo","password":"Hugo123"}'
```{{execute}}

And you should get something like this:

~~~~
{"sessionID":"c964eac7-8adb-47fd-a2f8-9badbb745b75","expiration":1586453914,"origin":"session-api-5d497db7f6-tdbtq"}
~~~~

```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Paco","password":"Paco123"}'
```{{execute}}

And you should get something like this:

~~~~
{"sessionID":"c964eac7-8adb-47fd-a2f8-9badbb745b75","expiration":1586453914,"origin":"session-api-5d497db7f6-zfpmr"}
~~~~

```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Luis","password":"Luis123"}'
```{{execute}}

And you should get something like this:

~~~~
{"sessionID":"c964eac7-8adb-47fd-a2f8-9badbb745b75","expiration":1586453914,"origin":"session-api-5d497db7f6-rb75g"}
~~~~

**The origin field must be different in every response.**

## Extra step

If you want to dynamically scale your deployment, you can try the following:

`kubectl autoscale deployment session-api --cpu-percent=5 --min=10 --max=16 -n $NAMESPACE --insecure-skip-tls-verify`{{execute}}

The previous command means that the deployment by the name session-api, will autoscale when it goes above 5% of CPU usage, and it will go to a maximum
of  16 pods, and remain at 10 pods as a minimum.

If you have a way to create a good ammount of calls to the API you may be able to stress it and see the autoscale in action. 