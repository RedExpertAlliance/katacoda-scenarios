# Let's test our new Kafka Confluent cluster running on OCI

Let's get the Public IP address from one of the broker servers:

```
export ADOMAINS=$(oci iam availability-domain list --compartment-id $compartmentId)
export DISPLAY_NAME=broker-1
export AVAILABILITY_DOM=$(echo $ADOMAINS | jq -r '.data | .[0] | .name')
export INSTANCE_DETAILS=$(oci compute instance list --compartment-id $compartmentId --availability-domain $AVAILABILITY_DOM --display-name $DISPLAY_NAME)
export INSTANCE_ID=$(echo $INSTANCE_DETAILS | jq -r '.data | .[0] | .["id"]')
export instance_vnics=$(oci compute instance list-vnics --instance-id $INSTANCE_ID)
export broker1_public_ip=$(echo $instance_vnics | jq -r '.data | .[0] | .["public-ip"]')
```{{execute}}

And to validate that we've retrieved it properly, execute:

`echo "The IP address of the broker-1 instance is: $broker_public_ip"`{{execute}}

`ssh -i /root/keys/confluent opc@$broker1_public_ip `{{execute}}

Now that you've entered into the broker1 server, let's create a first demo topic:

`/usr/bin/kafka-topics --zookeeper zookeeper-0:2181 --create --topic katacodademo --partitions 1 --replication-factor 3`{{execute}}

Now let's publish a message into it

```
curl --location --request POST 'http://rest-0:8082/topics/katacodademo' \
--header 'Content-Type: application/vnd.kafka.binary.v2+json' \
--header 'Accept: application/vnd.kafka.v2+json, application/vnd.kafka+json, application/json' \
-d '{
  "records": [
    {
      "key": "myKey",
      "value": "my key value"
    },
    {
      "value": "value1",
      "partition": 0
    },
    {
      "value": "value2"
    }
  ]
}'
```{{execute}}

You shoud had received something like this as a response:
~~~~
{
   "offsets":[
      {
         "partition":0,
         "offset":0,
         "error_code":null,
         "error":null
      },
      {
         "partition":0,
         "offset":1,
         "error_code":null,
         "error":null
      },
      {
         "partition":0,
         "offset":2,
         "error_code":null,
         "error":null
      }
   ],
   "key_schema_id":null,
   "value_schema_id":null
}
~~~~

Also if you want to get the partitions from your newly created katacoda topic, you can try:

`curl --location --request GET 'http://rest-0:8082/topics/katacodademo/partitions'`{{execute}}

Or post a message to partition:

```
curl --location --request POST 'http://rest-0:8082/topics/katacodademo/partitions/0/' \
--header 'Content-Type: application/vnd.kafka.binary.v2+json' \
--header 'Accept: application/vnd.kafka.v2+json, application/vnd.kafka+json, application/json' \
--data-raw '{
  "records": [
    {
      "key": "a2V5",
      "value": "Y29uZmx1ZW50"
    },
    {
      "value": "a2Fma2E="
    }
  ]
}'
```{{execute}}

And you can try all the basic functionality from your newly created cluster.

Now let's move into the next step, to show you how with terraform we can destroy all the resources that we have provisioned.
