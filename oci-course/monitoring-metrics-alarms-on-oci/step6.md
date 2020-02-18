Make some noise to trigger the alarm

We will download the files that were created earlier in this scenario, all of them in rapid succession (within one minute). This traffic will generate metrics that should the alarm to be triggered.
```
FILENAME=helloWorldFile$LAB_ID

for i in {1..5}
do
   echo "Retrieving details for file # $i "
   NEWFILENAME="$FILENAME.v$i.txt"
   oci os object get --bucket-name="bucket-$LAB_ID" --name $NEWFILENAME --file "speed-downloaded-$NEWFILENAME"
done
```{{execute}}

The metric PutRequests in the metrics namespace OCI_OBJECTSTORAGE in compartment *lab-compartment* 