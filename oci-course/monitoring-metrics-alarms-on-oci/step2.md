You will first make some noise: by taking several actions through the Object Storage service, you make sure that there are some metrics generated for us to inspect. Then you will first retrieve the metrics through the Command Line Interface.

Let's upload five new files to the bucket *bucket-$LAB_ID* - with some pauses in between. Note: the finest granularity at which the metrics are collected in OCI is one minute; all actions that take place within one minute of each other are aggregated together.
```
FILENAME=helloWorldFile$LAB_ID

for i in {1..5}
do
   echo "Uploading file # $i "
   NEWFILENAME="$FILENAME.v$i.txt"
   echo "Hello World in this Bright New File #$i" > $NEWFILENAME
   oci os object put --bucket-name="bucket-$LAB_ID" --name "$NEWFILENAME" --file ./$NEWFILENAME --metadata '{"file_tag":"HelloWorld_v$i"}'
   sleep 20
done
```{{execute}}

Now retrieve the list of files. Let's list the files in the bucket - to see the files you have uploaded:

`oci os object list --bucket-name="bucket-$LAB_ID"`{{execute}}

To get the details for the new files, execute this statement. It retrieves and downloads all five files. This will generate additional metrics.
```
FILENAME=helloWorldFile$LAB_ID

for i in {1..5}
do
   echo "Retrieving details for file # $i "
   NEWFILENAME="$FILENAME.v$i.txt"
   oci os object get --bucket-name="bucket-$LAB_ID" --name $NEWFILENAME --file "downloaded-$NEWFILENAME"
   sleep 12
done
```{{execute}}

We now have at least caused the creation of two sets of metrics from the Object Storage Service: for PUT requests (that created new objects) and for GET requests (that retrieved these objects). Additional metrics are available for object count, request latency (first byte and all bytes) and total bytes stored.

To retrieve some metrics:



## Resouces
OCI Docs on [Monitoring](https://docs.cloud.oracle.com/en-us/iaas/Content/Monitoring/Concepts/monitoringoverview.htm)