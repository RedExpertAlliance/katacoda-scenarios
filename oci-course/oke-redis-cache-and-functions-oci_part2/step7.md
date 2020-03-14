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

And our load balancer service is going distribute the requests to all our pods. 

To verify this, we are gona hit 3 times our login endpoint and validate the origin field of the response. 
The origin field is the name of the pod that is responding.
```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Hugo","password":"Hugo123"}'
```{{execute}}

```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Paco","password":"Paco123"}'
```{{execute}}

```
curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Luis","password":"Luis123"}'
```{{execute}}

The origin field must be different on every response.

## Extra step

If you want to dynamically scale your deployment, you can try the following:

`kubectl autoscale deployment session-api --cpu-percent=5 --min=10 --max=16 --insecure-skip-tls-verify -n $NAMESPACE`{{execute}}

The previous command means that the deployment by the name session-api, will autoscale when it goes above 5% of CPU usage, and it will go to a maximum
of  16 pods, and remain at 10 pods as a minimum.

If you have a way to create a good ammount of calls to the API you may be able to stress it and see the autoscale in action. 