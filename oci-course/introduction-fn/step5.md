# Passing Context Values to a Function
The behavior of a function can depend on the context in which the function is running. Depending on the environment (Dev, Test, Production), location (region), time of week | month | year, business unit of any other characteristic, the functionality may be (slightly) different. We do not want to change and redeploy the function for every change in context. Nor we do we want to pass these context properties in every request to the function. Fortunately, we can make use of the Fn runtime context for functions - that is available to the function in a native way at runtime through environment variables. Values can be set in the context before and at any time after deploying the function that uses these values. 

Fn config variables can be set for applications (and apply to all functions in the application) or for specific functions. In addition, Fn automatically generates a number of environment variables for your use in every function.

* Application Config Variables: Variables stored in an application are available to all functions that are deployed to that application.
* Function Config Variables: Variables stored for a function are only available to that function.
* Pre-defined environment variables: By default, a number of environment variables are automatically generated in an Fn Docker image. The next figure show the automatically generated variables.

![](assets/predefined-env-vars.png)

Add a configuration variable to the hello-app application

`fn cf a hello-app welcome_message "Herzlich willkommen"`{{execute}}

Check all configuration settings in *hello-app*
 
 `fn ls cf a hello-app`{{execute}}


Invoke function hello again:

`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

You will notice that the *context* parameter that is passed to the function now contains a property *welcome_message* with the value that was set in the application.

Change the value of the configuration variable

`fn cf a hello-app welcome_message "Bonjour mes amis"`{{execute}}

Invoke function hello again and check the *context* parameter:

`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

Configuration values are available as environment variables inside functions. A common way to read their values - anywhere in the Node application that implements the function - is using `process.env["name of variable"].

Open file func.js in the editor and change line 10 to
<pre class="file" data-target="clipboard">
return {'message': app.doYourThing(name), "special_message":process.env["welcome_message"] ,'ctx':ctx}
</pre>

At this point, the function makes use - in a very superficial way - of the value set in the configuration variable.

Now we need to redeploy the function with the same command as before:

`fn -v deploy --app hello-app --local `{{execute}}

Invoke function hello again and check the response for the *special_message* property:

`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

Change the configuration variable and invoke again (no redeployment necessary):

```
fn cf a hello-app welcome_message "Welkom vrienden"
echo -n '{"name":"Elisabeth"}' | fn invoke hello-app hello --content-type application/json
echo -n '{"name":"Alexander"}' | fn invoke hello-app hello --content-type application/json
```{{execute}}

Notice your function immediately picks up and uses the variables. You don’t need to redeploy the function or make any other modifications. The variables are picked up and injected into the Docker instance when the function is invoked.

## Setting Variables with Fn YAML Files
In addition to using the CLI to set Fn variables for your RuntimeContext, you can set them in Fn YAML configuration files.

Open file func.yaml in the editor.

Add the following snippet at the bottom of the file:

<pre class="file" data-target="clipboard">
config:
  hello-config-value1: Allons enfants de la patrie
  hello-config-value2: We lopen door de lange lindenlaan
</pre>

Deploy and invoke the function

```
fn -v deploy --app hello-app --local
echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json
```{{execute}}
Check the contents of the ctx property: it contains the two new configuration variables.

Open file *existingNodeApp.js* in the editor.

Replace line 2 with this line - that will read environment variable *hello-config-value1* and include its value in the function response.

<pre class="file" data-target="clipboard">
return `Warm greeting to you, dear ${name} and all your loved ones and do not forget: ${process.env['hello-config-value1']}`;
</pre>

Deploy and invoke the function

```
fn -v deploy --app hello-app --local
echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json
```{{execute}}

### Hint:

If you put all of your functions under the same parent directory, you can setup an app.yaml file to hold configuration data. Create an app.yaml file in the parent directory of your two functions. Deploy and invoke your function locally from the parent directory of your functions. The command deploys all functions under the parent directory to the application specified in app.yaml.
