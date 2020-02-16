You will first make some noise: by taking several actions through the Object Storage service, you make sure that there are some metrics generated for us to inspect. Then you will first retrieve the metrics through the Command Line Interface.

Let's upload five new files to the bucket *bucket-$LAB_ID*
```
FILENAME=helloWorldFile$LAB_ID

for i in {1..5}
do
   echo "Welcome $i times"
   NEWFILENAME="$FILENAME.v$i.txt"
   echo "Hello World in this Bright New File #$i" > $NEWFILENAME
   oci os object put --bucket-name="bucket-$LAB_ID" --name "$NEWFILENAME" --file ./$NEWFILENAME --metadata '{"file_tag":"HelloWorld_v$i"}'
   sleep 2
done
```{{execute}}
