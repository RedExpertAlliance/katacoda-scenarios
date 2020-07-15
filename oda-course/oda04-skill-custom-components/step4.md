Now that the services call are implemented, it is time to beging the business logic implementation.

Using the free services the bot will allow the users to ask the weather forecast for any date within the next seven days.
One Call API already returns 7 days information (including current weather information), but as it requires latitude and longitude, and this is something you don't have at the moment, the component will be calling Current Weather API first to retrive current weather if the user requests today's weather or the coordinates if the user select another day.

It is not mandatory for the user to provide a date, so if no date is provided the componen will just retrive today's weather information.

Copy and paste the following code below the varible within the 'invoke' function.
<pre>
    <code>
    var day = 0;
    var today = new Date();
    const now = today.getTime();
    if(date){
      const diffTime = Math.abs(date.date - now);
      day = Math.ceil(diffTime / (1000 &#42; 60 &#42; 60 &#42; 24));
      if(day > 7){
          conversation.transition("dateerror");
          done();
          return;
      }
    }
    currentWeather(location).then(function(result){
      if(!date || day == 0){
        var printData = {
          "temp": result.main.temp,
          "weather": result.weather[0].main,
          "icon": "http://openweathermap.org/img/wn/"+result.weather[0].icon+"@2x.png",
          "date": dateFormat(today, "dd/mm/yyyy")
        };
        return printData;
      }else{
        return sevenDaysForecast(result.coord.lat, result.coord.lon).then(function(forecastResult){
          var newDate = new Date(today.getTime());
          newDate.setDate(newDate.getDate()+day);
          var printData = {
            "temp": forecastResult.daily[day].temp.day,
            "weather": forecastResult.daily[day].weather[0].main,
            "icon": "http://openweathermap.org/img/wn/"+forecastResult.daily[day].weather[0].icon+"@2x.png",
            "date": dateFormat(newDate, "dd/mm/yyyy")
          };
          return printData;
        }).catch(function(err){
          conversation.transition("error");
          done();
        });
      }
    }).then(function(printData){
      var printArray = new Array();
      printArray.push(printData);
      conversation.variable(printVariable, printArray);
      conversation.transition("success");
      done();
    }).catch(function(err){
      conversation.transition("error");
      done();
    });
    </code>
</pre>
In the first part of the code, you are just setting a few variables to be used later.
  * day variable will store the number of days from today, being today 0, tomorrow 1, etc. It will be used to get the specific position in the One Call API response.
  * today and now will be used to calculate the number of days from the user requests to today.

The next part is checking if the date exists and checking the day difference between that date and today.
If the day difference is greater than 7, the component will transition to 'dateerror' action by using conversation.transtition().

After that, the first promise is being called to retrieve the current weather. If the date was not provided or the day difference is 0, the data is returned, otherwise the second promise is executed.




