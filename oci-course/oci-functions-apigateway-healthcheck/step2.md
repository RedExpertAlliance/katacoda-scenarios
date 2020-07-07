# Creating, Deploying and Invoking a Functions on OCI

In this step we will create two simple, identifical function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options that you may use.


```
export function1=hello1$LAB_ID

fn init --runtime node $function1`
cd $function1
```{{execute}}

Three files have been created in the new directory *hello1#*.

`ls`{{execute}}

You could open func.js in the text editor to see the generated functionality. 
`func.js`{{open}}

## Create Application

The application that will act as the container for the two functions probably already exists; however, just to be sure let's try to create it (if this statement fails because the application already exists, that is fine):

`fn create app "lab$LAB_ID" --annotation "oracle.com/oci/subnetIds=[\"$subnetId\"]"`{{execute}}

See the list of applications - that should include your new application:

`fn list apps`{{execute}}

## Deploy the Function

Deploy the Function *hello1#*, into an app that was created beforehand. At this stage a container image is built to host and run the function. This container image is pushed to the Oracle Container Registry on OCR. It is this image that is used to start a container from when the function is (first) invoked.

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Time to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke "lab$LAB_ID" $function1`{{execute}}

The first call may take a while because of the cold start of the function. During cold start, the container image is used to start a new container from the image that was built and pushed. If you call the function a second and third time, it is bound to go a lot quicker - because the container will hang a round for a bit. After ten minutes or so of inactivity, the container will be stopped and the next function call after that will suffer again from cold start.

Note: if you get an error message that looks like "Error invoking function. status: 502 message: dhcp options ocid1.dhcpoptions.oc1.iad.ac5aeaq does not exist or Oracle Functions is not authorized to use it", it is probably caused by the fact that:
* the *lab-compartment* does not have a VCN
* or the VCN does not have a public subnet
* or the public subnet does not have an Ingress Rule to allow incoming traffic on port 443
* or the FaaS Service is not granted access to VCN and network resources in *lab-compartment* through a policy

All of the above should have been prepared in the OCI Tenancy Preparation scenario.

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke "lab${LAB_ID}" "hello$LAB_ID" --content-type application/json`{{execute}}

Again, a friendly, this time personalized welcome message should be your reward - coming from the cloud.

## Create the second function hello2 in the exact same manner

```
export function2=hello2$LAB_ID

fn init --runtime node $function2`
cd $function2
fn -v deploy --app "lab$LAB_ID"
fn invoke "lab$LAB_ID" $function2
```{{execute}}

Both functions should now be deployed and ready to be exposed through API Gateway.