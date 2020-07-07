# Expose Functions through API Gateway

Create a file called api_deployment.json in the current directory with this contents. 

`touch api_deployment.json`{{execute}}

Copy the definition of the route */stock* to the api_deployment.json file:

<pre class="file" data-filename="api_deployment.json" data-target="replace">
{
  "routes": [
    {
      "path": "/stock",
      "methods": ["GET"],
      "backend": {
        "type": "STOCK_RESPONSE_BACKEND",
        "body": "{\"special_key\":\"Special Value\"}",
        "headers":[],
        "status":200
      }
    }
  ]
}
</pre>
It is possible that the API Gateway Deployment already exists from a previous scenario, in which case the next create command will fail. Which is fine.

Create the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment create --compartment-id $compartmentId --display-name MY_API_DEPL_$LAB_ID --gateway-id $apiGatewayId --path-prefix "/my-depl$LAB_ID" --specification file://./api_deployment.json`{{execute}}

It will take a few seconds - up to 15-20 seconds - for the new API Deployment to be created. You can check the progress of the creation in the OCI Console.

```
depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
```{{execute}}

```
apps=$(oci fn application list -c $compartmentId)
labApp=$(echo $apps | jq -r --arg display_name "lab$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

funs=$(oci fn function list --application-id $labApp)
hello1Fun=$(echo $funs | jq -r --arg display_name "$function1" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for hello function : $hello1Fun"
hello2Fun=$(echo $funs | jq -r --arg display_name "$function2" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for hello function : $hello2Fun"
```{{execute}}

Open the new file *api_deployment.json* in the text editor and copy the definitions of the routes */hello1* and */hello2* to the api_deployment.json file. The /hello1 and hello2 routes accept both GET and POST requests - but not PUT, DELETE and others. The routes are of type ORACLE_FUNCTIONS_BACKEND and have the two new Functions as their targets.  

Replace `function hello1 ocid` and `function hello2 ocid` in the file with the OCID that was found just now.

<pre class="file" data-filename="api_deployment.json" data-target="replace">
{
  "routes": [
    {
      "path": "/hello1",
      "methods": ["GET","POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "function hello1 ocid"
      }
    },    
    {
      "path": "/hello2",
      "methods": ["GET","POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "function hello2 ocid"
      }
    }
  ]
}
</pre>

Update the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment.json`{{execute}}

Confirm the update in the terminal window.

It will take a few seconds (up to 15 seconds) for the API Gateway to synchronize its definition with the new specification. When the API Gateway deployment is updated, you can start using the new route. 

You can check on the state of the API Deployment and the current update (called a *workrequest*) in the OCI Console. Execute this command to get the URL to the Console:

```echo "Your OCI Console Endpoint to inspect your API Deployment's current state: https://console.$REGION.oraclecloud.com/api-gateway/gateways/$apiGatewayId/deployments/$apiDeploymentId/workrequests"```{{execute}}

## Invoke the Hello Function - Now publicly exposed through API Gateway

Using *curl* you can now invoke the route that leads to the function *hello* that you created in a previous scenario, and POST an input message to the function.

`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $deploymentEndpoint/hello`{{execute}}

Feel free to invoke the function in Postman and/or in your Browser, using its endpoint:

`echo "Function Hello's Endpoint $deploymentEndpoint/hello"`{{execute}}