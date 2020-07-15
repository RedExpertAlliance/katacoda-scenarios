The last step is to modify three states, add a new variable and a new state in the dialog flow to integrate the custom component.

You need a new state to actually call the custom component. As you can see the properties and transition actions matches the ones defined in the custom component.
<pre>
    <code>
  queryWeather:
    component: "weather.query"
    properties:
      locationVariable: "location"
      dateVariable: "date"
      printVariable: "weather"
    transitions:
      actions:
        success: "printWeather"
        dateerror: "showDateError"  
    </code>
</pre>
As you are using 'weather' variable in the component, you have to define it. Add the following code on the variables peroperty under context on the top part of the dialog flow.
<pre>
    <code>
    weather: "string"
    </code>
</pre>
In 'setAskForLocation' statem you need to set next transition to 'queryWeather' state so the custom component can be executed.
<pre>
    <code>
  setAskForLocation:
    component: "System.Text"
    properties:
      prompt: "Please let me know what city do you want to search for"
      variable: "location"
      maxPrompts: 2
      nlpResultVariable: "iResult"      
    transitions:
      next: "queryWeather"
      actions:
        cancel: "noLocation"    
    </code>
</pre>
Next, you have to change the cards values in 'printWeather' state it actually prints the returned data instead of the dummy.
<pre>
    <code>
  printWeather:
    component: "System.CommonResponse"
    properties:
      processUserMessage: false
      keepTurn: true
      metadata: 
        responseItems:         
        - type: "cards" 
          cardLayout: "vertical"
          cards:
          - title: "${location.value.name?capitalize} - ${weather.date}"
            description: "${weather.temp?round}º -  ${weather.weather}"
            imageUrl: "${weather.icon}"
            cardUrl: "https://www.redexpertalliance.com" 
            iteratorVariable: "weather"
    transitions:
      next: "endConversationThanks"
    </code>
</pre>
You can use Apache Freemaker expresions within the dialog flow.
In this case you are using 'location.value.name?capitalize' to make the first letter in uppercase, and 'weather.temp?round' to round the degrees and remove decimals.

The last thing to add is a new state to navigate for 'dateeror' transition.
<pre>
    <code>
  showDateError:
    component: "System.Output"
    properties:
      text: "I'm sorry but none can see that far away! I can only let you know the weather for the next seven days! Please try again!"
    transitions:
      return: "done"  
    </code>
</pre>