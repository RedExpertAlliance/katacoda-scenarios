In this scenario we will learn how to deploy Kafka - Confluent Community Edition and Enterprise Edition on top of Oracle Cloud Infraestructure.
Confluent's Kafka offering is the leader in the market, which includes the possibility to install their software on your own infrastructure. But not only that,
but a set of terraform plans has been created and validated to deploy their platform on top of OCI.

The information of those terraform plans can be found here:
https://blogs.oracle.com/cloud-infrastructure/confluent-platform-now-validated-on-oracle-cloud-infrastructure

And the github repo is this one:
https://github.com/oracle-quickstart/oci-confluent
**(All credits on the Terraform Plans to the contributors of this github repo https://github.com/oracle-quickstart/oci-confluent) **

Kafka is conformed by many components: 
- Brokers
- Zookeepers
- REST Proxy Servers
- KSQL Servers
- Connect Servers
- Schema Registry

![Intro](/RedExpertAlliance/courses/oci-course/oci-confluent-kafka/assets/arch1.jpg)

Terraform plans are going to provision the compute instances, install, deploy and configure the services and create a whole Confluent Kafka environment within OCI.

This scenario will help you to understand:

- The usage of terraform plans 
- The Confluent Kafka Architecture
- Create and destroy a Confluent Kafka Cluster deployment in minutes

Important notes to use this scenario:

- As any other scenario of this series, you need to go to the pre-requisite katakoda scenario to configure your tenant. If you haven't done that please go here:
https://www.katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial
- This is not a scenario to learn about Terraform, and if you do not have knowledge about it, is OK, you can still perform the scenario
- This is not going to teach you Kafka, but in the other hand, is going to help you to provision a complete cluster where you can use it and learn it

