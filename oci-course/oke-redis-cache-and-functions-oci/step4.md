# Let's test the the deployed API

Our service has been deployed and we can see it deployed in our cluster:

`kubectl get services -n  $NAMESPACE`{{execute}}

The context for our API is: <TBD>

Let's execute the folowing CURL to test it and validate that is writing and reading from our Redis cache:

- Authenticate a user and create a sessionId:

`curl -X POST http://IP/context`{{execute}}

- Get the user profile using the sessionId:

`curl -X POST http://IP/context`{{execute}}

- Let's test the refresh token resource:

`curl -X POST http://IP/context`{{execute}}

Wait for 03 minutes and re-test. You will see that the session has expired:

- Try to get the USer Profile and it will fail:

`curl -X POST http://IP/context`{{execute}}

- Let's get into Redis to see how the entries are generated 

<TBD>

