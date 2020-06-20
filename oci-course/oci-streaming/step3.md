# Node Application as OCI Stream Consumer

OCI can be accessed through a console, through the OCI CLI and through REST APIs. Custom applications probably work most easily with this last option. In this step you will create (well, actually the code is already there, cloned from github and almost ready to execute) and test a Node JS application that consumes messages from the OCI Stream *lab-stream*. 

## Prepare Node application
Some steps are required before the Node application can be successfully executed.

### Configure OCI connection details

Copy the private key file used for accessing OCI to the Function resources directory:
`cp ~/.oci/oci_api_key.pem ~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub/oci_api_key.pem`{{execute}}

Open file `~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub/oci-configuration.js` in the IDE. This file is used by the Node application to connect to the OCI REST APIs. It has to make signed HTTP requests - signed using the private key of an OCI User with necessary permissions on the OCI Object Storage.

Copy the JSON snippet produced by the next command between the curly braces in fil *oci-configuration.js*:
```
json="\"namespaceName\": \"$ns\",\n
\"region\": \"$REGION\",\n
\"compartmentId\": \"$compartmentId\",\n 
\"authUserId\": \"$USER_OCID\",\n
\"identityDomain\": \"identity.$REGION.oraclecloud.com\",\n
\"tenancyId\": \"$TENANCY_OCID\",\n
\"keyFingerprint\": \"YOUR_FINGERPRINT_FROM FILE ./oci_api_key.pem\",\n
\"privateKeyPath\": \"./oci_api_key.pem\",\n
\"coreServicesDomain\": \"iaas.$REGION.oraclecloud.com\",\n
\"bucketOCID\": \"$bucketOCID\",\n
\"bucketName\":\"$bucketName\",\n
\"objectStorageAPIEndpoint\":\"objectstorage.$REGION.oraclecloud.com\",\n
\"streamingAPIEndpoint\": \"streaming.$REGION.oci.oraclecloud.com\"\n
"
echo "paste JSON fragment in file oci-configuration.js "
echo -e $json
```{{execute}}

Define the correct value for the *keyFingerprint* property in this file: replace the text *YOUR_FINGERPRINT_FROM FILE ./oci_api_key.pem* with the actual fingerprint value from the indicated file. 

### Install required libraries

Navigate to the directory that contains the File Writer application:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub`{{execute}}

and run `npm install` to install the required libraries.

`npm install`{{execute}} 


## Run the Stream Consumer to consume all current messages on OCI Stream lab-stream

Run the Stream Consume application with the following command:

`node stream-consumer`{{execute}}

This application creates a cursor on the *lab-stream* with TRIM_HORIZON set - meaning all messages on the Stream. It then reads messages from the cursor and writes them to the console.

You may want to check the code that reads from the Stream. It is in file *stream-consumer.js*.

Note the following lines
```
    let buff = new Buffer.from(e.value, 'base64');
    let text = buff.toString('ascii');
    log( text)
```

that take care of decoding (from  Base64 en from ByteArray format) the message payload.

Go to the OCI Console (as lab-user at: https://console.us-ashburn-1.oraclecloud.com/storage/streaming) and publish a few test messages on *lab-stream*. 

`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/storage/streaming"`{{execute}}

Then run the Node application another time - and watch the fresh messages come in.

`node stream-consumer`{{execute}}

You could change the constant CURSOR_TYPE from TRIM_HORIZON (all messages) to LATEST (only messages published after the cursor was created) - in file *stream-consumer.js*, line 8. Run the application again - and again - to only see new messages.


## Resources

A blog article: [Oracle Cloud Streaming Service – Scalable, Reliable, Kafka-like Event service on OCI](https://technology.amis.nl/2020/01/07/oracle-cloud-streaming-service-scalable-reliable-kafka-like-event-service-on-oci)


