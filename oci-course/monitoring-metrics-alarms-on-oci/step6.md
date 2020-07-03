You will now make some noise to set off the alarm. You will download the files that were created earlier in this scenario, all of them in rapid succession (within one minute). This traffic will generate metrics that should trigger the alarm.

Execute this statement to have all five files downloaded from bucket *bucket-$LAB-id*:
```
FILENAME=helloWorldFile$LAB_ID

for i in {1..5}
do
   echo "Retrieving details for file # $i "
   NEWFILENAME="$FILENAME.v$i.txt"
   oci os object get --bucket-name="bucket-$LAB_ID" --name $NEWFILENAME --file "speed-downloaded-$NEWFILENAME"
done
```{{execute}}

Five files are downloaded. As a consequence, the count for metric PutRequests in the metrics namespace OCI_OBJECTSTORAGE in compartment *lab-compartment* is well over 3 for this minute. Note: it will take about a minute or two for the Alarm to become triggered; alarms are only triggered when there triggering condition has existed for at least one minute - or a longer period if so specified. 

When the Alarm is triggered, a message is published to the Notification Topic. And this results in an email to your email address - because of the subscription on the topic. You should receive an email before too long - and it should look like this:
![Email Alert](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-alarm-notification.png)

You can check the alarm status in the console as well: 

`echo "Open the console at https://console.$REGION.oraclecloud.com/monitoring/alarms"`{{execute}} 

Open open the menu for Monitoring | Alarms, and click on the alarm definition. For this alarm in its current, firing state, it will look like this:
![Alarm firing](/RedExpertAlliance/courses/oci-course/monitoring-metrics-alarms-on-oci/assets/oci-alarm-firing.png)

