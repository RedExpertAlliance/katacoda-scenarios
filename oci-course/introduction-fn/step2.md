# Creating a Function with Fn 

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

The fn init command generated a func.yaml function configuration file; this file provides instructions to the Fn Server to build, deploy and invoke the function. Let's look at the contents:

`cat func.yaml`{{execute}}

The generated func.yaml file contains metadata about your function and declares a number of properties including:

* schema_version--identifies the version of the schema for this function file. Essentially, it determines which fields are present in func.yaml.
* name--the name of the function. Matches the directory name.
* version--automatically starting at 0.0.1.
* runtime--the name of the runtime/language which was set based on the value set in --runtime.
* entrypoint--the name of the Docker execution command to invoke when your function is called, in this case node func.js.
* memory - maximum memory threshold for this function. If this function exceeds this limit during execution, it is stopped and error message is logged. 
* timeout - maximum runtime allowed for this function in seconds. The maximum value is 300 and the default values is 30.

There are other user specifiable properties that can be defined in the yaml file for a function. We do not need those for this simple example. See [Func.yaml metadata options](https://github.com/fnproject/docs/blob/master/fn/develop/func-file.md) for a complete overview of the options for the func.yaml file

The package.json file is present in (most) Node applications: it specifies all the NPM dependencies for your Node function - on third party libraries and also on the Fn FDK for Node (@fnproject/fdk).

`cat package.json`{{execute}}

You could open func.js in the text editor to see the generated functionality of the function: that is where the real action takes place when the function is invoked.

## Deploy and Invoke the Function

Create an Fn application - a container for multiple related functions. 

`fn create app hello-app`{{execute}}

An application acts as a namespace for functions. Some management actions are performed on applications. The number of applications allowed in an OCI tenancy is limited to 10; this number can (potentially) be increased.  

Deploy the Function Hello locally, into the app that was just created

`fn -v deploy --app hello-app --local `{{execute}}

When you deploy a function like this, Fn is dynamically generating a Dockerfile for your function, building a container, and then loading that container for execution when the function is invoked. 

Note: Fn is actually using two images. The first contains the necessary build tools and produces the runtime artefact. The second image packages all dependencies and any necessary language runtime components. Using this strategy, the final function image size can be kept as small as possible.

When using `fn deploy --local`, fn server builds and packages your function into a container image which resides on your local machine. You can now verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep hello`{{execute}}

Using the following command, you can check the Fn applications (or function clusters) in your current context:
`fn list apps`{{execute}}

With the next command, you can check which functions have been deployed into a specific application:

`fn list functions hello-app`{{execute}}

Time now to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke hello-app hello`{{execute}}

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

Again, a friendly, this time personalized, welcome message should be your reward.

What is happening here: when you invoke "hello-app hello" the Fn server looked up the "hello-app" application and then looked for the Docker container image bound to the "hello" function, started the container (if it was not already running) and send the request to the handler listening inside the container.

![Fn Server handles request](assets/fn-server-functions.jpg)

## Wrap existing Node module with Fn Function Wrapper
Suppose you already have Node code performing some valuable task. You can take the existing code and turn it into an Fn Function quite easily - using several approaches even. One is to build a custom Docker container and use it as the implementation for your function (see step 6 in this scenario). An easier one is shown next.

Copy the existing Node application *existingNodeApplication.js* to the folder created for function *hello*:
`cp /root/scenarioResources/existingNodeApp.js /root/hello`{{execute}}

This node application is quite simple, as you can verify:
`cat /root/hello/existingNodeApp.js`{{execute}}

Run the existingNodeApp:
`node existingNodeApp.js YourName`{{execute}}

Note: feel free to make changes to the existingNodeApp.js.

Open the file *func.js* in the text editor. Select all current contents (CTRL + A), remove it (Del) and copy this snippet to the file:
<pre class="file" data-target="clipboard">
const fdk=require('@fnproject/fdk');
const app = require( './existingNodeApp.js' );

fdk.handle(function(input){
  let name = 'World';
  if (input.name) {
    name = input.name;
  }
  return {'message': app.doYourThing(name)}
})
</pre>

The function *hello* now leverages the existing Node module *existingNodeApp* for the hard work this function is doing when invoked.

Deploy the Function Hello locally, into the app that was just created
`fn -v deploy --app hello-app --local `{{execute}}

Now to invoke the function:
`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

In the response, you will see the product of the *existingNodeApp*. The Fn function *hello* is now completely implemented by *existingNodeApp*. In this case this application is wafer thin, but in real life this can be a sizable Node application that uses scores of NPM modules. This application can be developed and tested in its own right, outside the context of the Fn framework. You have now seen how easy it is to wrap the application in/as a Function. 


## Logging locally for Debugging

When working with Fn locally, you have the option to turn on the DEBUG log-level using the fn start command. This causes detailed information about functions to be output to the terminal after Fn server is started.

To enable DEBUG logging for Fn server, restart the server with the following command:

`fn start --log-level DEBUG`{{execute}}

Running the Fn server with the DEBUG log level is a great way to track down any issues you are having with your functions.

## File Writing

If you want to write to a file from a function, it can only be to the local file system (inside the function container) and only to /tmp. Each function is configured with its own /tmp as non-persistent disk space. The size of this disk space is set as part of the function configuration.

Of course, functions can write files on/to storage services - such as Oracle Cloud Object Storage.