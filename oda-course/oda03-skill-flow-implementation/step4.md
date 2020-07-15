The last part of the implementation is to actually print the weather to the user.
You will use a "System.CommonResponse" component for it. This is a very powerful component that enabled you to display cards (on channel that support it), send attachments such as image or video, and send the location of the user.

In this case you will use it to display the information as a card.
<pre>
    <code>
  printWeather:
    component: "System.CommonResponse"
    properties:
      keepTurn: true
      processUserMessage: false
      metadata: 
        responseItems:         
        - type: "cards" 
          cardLayout: "vertical"
          cards:
          - title: "Madrid - 15/07/2020"
            description: "20º - Clear"
            imageUrl: "http://openweathermap.org/img/wn/10d@2x.png"
            cardUrl: "https://www.redexpertalliance.com" 
    transitions:
      next: "endConversationThanks"
    </code>
</pre>
<pre>
    <code>
  endConversationThanks:
    component: "System.Output"
    properties:
      text: "Thanks for using my services. Feel free to ask me again before leaving your home!"
    transitions:
      return: "done"
    </code>
</pre>
Not much to say about it at the moment, type property under responseItems defines the type of the component (cards, atachment...) and then under cards property you are setting the values for the different facets of the card. 
The same way you used keepTurn in previous steps, it can be used on 'System.CommonResponse' component but, in this case, you need to set to false 'processUserMessage' property.