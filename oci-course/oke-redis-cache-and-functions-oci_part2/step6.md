## Service IP

We need to expose the API to the world, so we created the session-api service with a diferent type than the Redis service, we used LoadBalancer type, 
this creates an OCI load balancer in front of our service, in this way we have a public IP to talk with our service.

After some minutes we can retrieve the service IP with:

`export SESSION_API=$(kubectl get svc session-api -o jsonpath='{.status.loadBalancer.ingress[0].ip}') --insecure-skip-tls-verify`{{execute}}

## Test the API

We have 3 endpoints:
- profile: Watch users profile
- login: Login users and get a sessionID token
- refres: Refresh the sessionID before expires

If we hit the profile endpoint without a sessionID token we receive a 401 Unauthorized error:

```
curl -X GET \
  http://"$SESSION_API"/profile
```{{execute}}

Let's request a session ID:
```
export SESSION_ID=$( \
  curl -X POST \
  http://"$SESSION_API"/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"Hugo","password":"Hugo123"}' \
  | jq -r '.sessionID')
```{{execute}}

The previous call will return to us a sessionID and saved it on SESSION_ID variable. We are going to use this session to make the next calls:
~~~~
{
    "sessionID": "3ad7e86d-7ef7-49ac-91f5-90de3a513580",
    "expiration": 1582614198,
    "origin": "session-api-6cd4958fb5-vwf8f"
}
~~~~

Now we can get the profile of the user:
```
curl -X GET \
  http://"$SESSION_API"/profile \
  -H 'SessionID: '"$SESSION_ID"''
```{{execute}}

Every time we login a sessionID is created and saved to Redis with our username and expiration time of 2 minutes.

We can refresh our session and get a new sessionID for another 2 minutes, just copy the sessionID that we got from previous steps:
```
curl -X POST \
  http://"$SESSION_API"/refresh \
  -H 'SessionID: '"$SESSION_ID"''
```{{execute}}

If after two minutes we hit again the profile endpoint we will get a 401 Unauthorized error
```
curl -X GET \
  http://"$SESSION_API"/profile \
  -H 'SessionID: '"$SESSION_ID"''
```{{execute}}

Like this:

~~~~
{"message": "You need to login"}
~~~~

With those calls we have tested our Go API and also the Redis cache.

Now let's see how can we scale our applications in Kubernetes. Let's go to the next Step.