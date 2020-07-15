Now you will create two Promises containing each one a REST call to OpenWeatherMap API.

Copy and paste the following code below 'use strict'; at the begining of the file.
You have to replace 'your_api_key' with the API KEY you got from OpenWeatherMap.
<pre>
    <code>
    var request = require('request');
    var openweather_api_key = "your_api_key";
    var dateFormat = require('dateformat');
    </code>
</pre>
Add the following code to the end of the file, outside 'module.exports' block.
<pre>
    <code>
	var currentWeather = function(location){
	  return new Promise(function(resolve, reject){
		request('http://api.openweathermap.org/data/2.5/weather?q='+location.name+'&units=metric&appid='+openweather_api_key, { json: true }, (err, res, body) => {
		  if(err){
			reject(err);
		  }else{
			resolve(body);
		  }
		});
	  });
	}
	var sevenDaysForecast = function(lat, lon){
	  return new Promise(function(resolve, reject){
		request('https://api.openweathermap.org/data/2.5/onecall?lat='+lat+'&lon='+lon+'&exclude=current,minutely,hourly&units=metric&appid='+openweather_api_key, { json: true }, (err, res, body) => {
		  if(err){
			reject(err);
		  }else{
			resolve(body);
		  }
		});
	  });
	}
    </code>
</pre>
The first function, 'currentWeather' is calling Current Weather Data API. With this API you have different ways of providing the location as a query parameter such as latitude/longitude, ZIP code, City Name, etc.
For this hands-on you will be passing the location name. 
'units=metric' will set the weather info into Celsius. YOu can remove it if you want to temperature to be in Kelvin, or set metric to Imperial if you want Fahrenheit.

The second function 'sevenDaysForecast' will call the One Call API. THis API cam return 7-days of weather forecast. You can only provide latitude and longitude to query this service. 