Now you will start implementing the main part of the dialog flow, the weather forecast request from the user.

First, you need to define two variables. This can be done in the top part of the code, under context variables.
Check your code so it looks like the following.
<pre>
    <code>
context:
  variables:
    location: "LOCATION"
    date: "DATE"
    iResult: "nlpresult"
    </code>
</pre>
Add the following code at the end of the existing code.
<pre>
    <code>
  initWeatherForecast:
    component: "System.SetVariable"
    properties:
      variable: "date"
      value: "${iResult.value.entityMatches['DATE'][0]}"
    transitions:
      next: "setAskForLocation"

  setAskForLocation:
    component: "System.Text"
    properties:
      prompt: "Please let me know what city do you want to search for"
      variable: "location"
      maxPrompts: 2
      nlpResultVariable: "iResult"      
    transitions:
      next: "printWeather"
      actions:
        cancel: "noLocation"

  noLocation:
    component: "System.Output"
    properties:
      text: "I need a location to provide the weather. Please type for example 'What's the weather in London'"
    transitions:
      return: "done"
    </code>
</pre>

The first state executed is 'initWeatherForecast'. You are using a 'System.SetVariable' component to store in 'date' variable the date provided by the user on the initial request. It doesnt matter if it exists or not inside the 'iResult' variable, it will transition to 'setAskForLocation' state.

In the second state, you are using a 'System.Text' component, that allows you to ask the user for  the location if it is not stored in 'location' variable. There are some things to keep in mind here:
* Some states, including the ones using 'System.Text' components, will only be executed if the variable defined in the variable property is not set. This is called entity slotting.
* By setting the property 'nlpResultVariable', you are trying to set the value from the intent resolution before checking if the value exists.
* maxPrompts value defines the number of times the user will be prompted for the location. In this case only twice, and after the second time it will navigate to the state defined in the 'cancel' action of the transitions.
If the user provided a location in their initial request or it has been provided on this state execution, it will transition to 'printWeather' state.

The last state of this piece of code is 'noLocation'. Here you are just sending a message reminding the user that a location is needed and ending the conversation.