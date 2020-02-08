You can publish your own metrics to Monitoring using the API. You can view charts of your published metrics using the Console , query metrics using the API, and set up alarms using the Console or API.You can access your published custom metrics the same way you access any other metrics stored by the Monitoring service. Define your metrics with aggregation in mind. While custom metrics can be posted as frequently as every second, the minimum aggregation interval is one minute.

For example, to monitor application health, one of the common KPIs is failure rate, for which a common definition is the number of failed transactions divided by total transactions. This KPI is usually delivered through application monitoring and management software.

As a developer, you can capture this KPI from your applications using custom metrics. Simply record observations every time an application transaction takes place and then post that data to the Monitoring service. In this case, set up metrics to capture failed transactions, successful transactions, and transaction latency (time spent per completed transaction).

To see an example of the JSON data structure that should be sent as part of the command to publish custom metrics, make this call using the *generate-param-json-input metric-data* switch:

`oci monitoring metric-data post --generate-param-json-input metric-data`{{execute}}

Open file *custom-metrics.json*

`custom-metrics.json`{{open}}

Replace two occurrences of `$compartmentId` in this file with the value of the compartment OCID:
`echo compartment OCID= $compartmentId`{{execute}}

Feel free to change timestamps or other values in the file.

To post the metrics defined in this file, execute this statement:

`oci monitoring metric-data post --endpoint https://telemetry-ingestion.us-ashburn-1.oraclecloud.com --metric-data file://./custom-metrics.json`{{execute}}



