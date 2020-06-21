# Adding a Route in an API Deployment to the File Writer Function

In this step, you will create a route to the File Writer  Function on OCI. 

```
apps=$(oci fn application list -c $compartmentId)
labApp=$(echo $apps | jq -r --arg display_name "lab$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

funs=$(oci fn function list --application-id $labApp)
fileWriterFun=$(echo $funs | jq -r --arg display_name "file-writer" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for file-writer function : $fileWriterFun"
```{{execute}}

Create the new file api_deployment.json:

`touch api_deployment.json`{{execute}}

Open the new file *api_deployment.json* in the text editor and copy the definitions of the routes */write* and */health* to the api_deployment.json file. The /write route accepts POST requests. The route is of type ORACLE_FUNCTIONS_BACKEND and has a Function as its target - the function file-writer. 

Replace `function ocid` in the file with the OCID that was found just now.

<pre class="file" data-filename="api_deployment.json" data-target="append">
{
  "routes": [
    {
      "path": "/write",
      "methods": ["POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "function ocid"
      }
    },
    {
      "path": "/health",
      "methods": ["GET"],
      "backend": {
        "type": "STOCK_RESPONSE_BACKEND",
        "body": "{\"status\":\"Up and Running\"}",
        "headers":[],
        "status":200
      }
    }
  ]
}
</pre>

We need to set some variables before proceeding into the next steps:

```
depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
```{{execute}}

Update the API Deployment in API Gateway lab-apigw with the following command: 

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment.json`{{execute}}

It will take a few seconds (up to 15 seconds) for the API Gateway to synchronize its definition with the new specification. When the API Gateway deployment is updated, you can start using the new route. 

You can check on the state of the API Deployment and the current update (called a *workrequest*) in the OCI Console. Execute this command to get the URL to the Console:

```echo "Your OCI Console Endpoint to inspect your API Deployment's current state: https://console.$REGION.oraclecloud.com/api-gateway/gateways/$apiGatewayId/deployments/$apiDeploymentId/workrequests"```{{execute}}

## Invoke the File Writer Function - Now publicly exposed through API Gateway

Using *curl* you can now invoke the route that leads to the function *file-writer* that you created in the previous step, and POST a file name and some data content to the function.

`curl -X "POST" -H "Content-Type: application/json" -d '{ "filename":"file-sent-through-public-endpoint-on-API-Gateway.txt","contents":"A new file with lots of fun contents"}' $deploymentEndpoint/write`{{execute}}

Check the current contents of the bucket:

`oci os object list --bucket-name $bucketName`{{execute}}

Check in OCI Console for Object Storage: the bucket you have created and the file that should now be visible and manipulatable in the console: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets.

Retrieve the file that was just created:

`oci os object get  -bn $bucketName --name file-sent-through-public-endpoint-on-API-Gateway.txt --file new-file.txt`{{execute}}

Check contents of the file:
```
ls -l new-file*
cat new-file.txt
```{{execute}}


Feel free to invoke the function in Postman and/or in your Browser, using its endpoint:

`echo "Function Hello's Endpoint $deploymentEndpoint/write"`{{execute}}

and a body that contains a JSON object in this structure:
```
{ "filename": "file-name.txt"
, "contents": "<the contents of the new file object"}
```

## Resources

Blog article [Oracle Cloud Serverless Functions unleashed: exposing OCI Functions through API Gateway](https://technology.amis.nl/2020/01/01/oracle-cloud-serverless-functions-unleashed-exposing-oci-functions-through-api-gateway/); this article shows the actions you just went through on the command line from the OCI Console point of view.

A blog article: [Publish Oracle Function for Reading and Writing Object Storage Files through OCI API Gateway](https://technology.amis.nl/2020/01/05/publish-oracle-function-for-reading-and-writing-object-storage-files-through-oci-api-gateway/)

OCI API Gateway Docs – Adding a Function in Oracle Functions as an API Gateway Back End – https://docs.cloud.oracle.com/iaas/Content/APIGateway/Tasks/apigatewayusingfunctionsbackend.htm

