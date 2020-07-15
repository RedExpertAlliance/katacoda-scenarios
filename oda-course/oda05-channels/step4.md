Configuration in ODA Platform is now completed, and now we need to install and configure the web widget.

First, you have to move into the same folder where the VSCode workspace is.

`cd ODAComponents`{{execute}}

For a production environment you want to download the SDK from the [Oracle ODA Downloads](https://www.katacoda.com/rsantrod/scenarios/oda04-skill-custom-components) page, but for this hands-on there is a node application preconfigured on Github.
Clone the repository where the widget app is stored.

`git clone https://github.com/rsantrod/katacoda-oda-widget-runable.git`{{execute}}

Lastly install the required node modules that are registered on package.json file

`npm install`{{execute}}