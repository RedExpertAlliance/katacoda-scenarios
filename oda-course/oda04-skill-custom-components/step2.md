Great! All the configurations have been made and now you are ready for implementation!
You will be copying and understanding the code behind the implementation.

In VSCode, under 'weather-component' folder, open up 'components' folder. In this folder is where you can can create your components.
By default, there's an example component, 'hellow.world.js', that you can use as a baseline for your new components.

For this workshop, we will start the component from scratch, so delete it.

Now you have to create a new file by right-clicking 'components' folder and selection 'New File'. Name it 'query.js'

Copy and paste the following code in 'query.js' file.
<pre>
  <code>
  'use strict';
  module.exports = {
    metadata: () => ({
      name: 'weather.query',
      properties: {
        locationVariable: { required: true, type: 'string' },
        dateVariable: { required: true, type: 'string' },
        printVariable: { required: true, type: 'string' }
      },
      supportedActions: ['success', 'error', 'dateerror']
    }),
    invoke: (conversation, done) => {

    }
  };
  </code>
</pre>

Metadata help you to define your custom component. In this case you will have three parameters:
  * locationVariable: The location provided by the user.
  * dateVariable: The date provided by the user.
  * printVariable: You will be storing here the data that will be returned to the user.

You can pass any value from the dialog flow to the component. What I like to do is not passing the value directly to the component, but the variable anem that hold the value. Doing this you prevent any change in the variable names to impact on your custom component execution.

You will have three actions as well:
  * success: Everyhing worked fine and the REST service has been called successfully.
  * dateerror: The date is not within the 7 days range that the service provides (for free).
  * error: Any other error will transition with this action.

Actions define the possible outcomes of the component, and it can be defined in the dialog flowunder transitions property as you learned in the previous scenario.

Next, you will be retrieving the properties and the variable values.
Add the following code inside 'invoke' function.

<pre>
    <code>
    const { locationVariable } = conversation.properties();
    const { dateVariable } = conversation.properties();
    const { printVariable } = conversation.properties();
    var location = conversation.variable(locationVariable);
    var date = conversation.variable(dateVariable);
    </code>
</pre>

'conversation.properties()' enables you to retrieve the different properties defined in the component.
'conversation.variable("variable_name")' and 'conversation.variable("variable_name", value)' enables you to set a variable.