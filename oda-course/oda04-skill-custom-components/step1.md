First of all you need to install Oracle Digital Assistant node sdk.

`npm install -g @oracle/bots-node-sdk`{{execute}}

Then, move into the same folder where the VSCode workspace is.

`cd ODAComponents`{{execute}}

Now you create the folder for our component.

`mkdir weather-component`{{execute}}

And go to that folder.

`cd weather-component`{{execute}}

Then you need to initialize our component. As it is a node.js application, you need to create package.json file.
'-y' options means no questions are asked and the file is created with default values (Just for the hands-on, in your real projects you will assign the right values)

`npm init -y`{{execute}}

Then you need to configure the SDK into our project.

`bots-node-sdk init`{{execute}}

Request module will enable you to make service calls. THis module is deprecated and for production usage you should consider other modules like https (part of Node code), Axios or Alike.

`npm install --save request`{{execute}}

You also need to install dateformat module to easily display the date provided by the user in a specific format.

`npm install --save dateformat`{{execute}}

