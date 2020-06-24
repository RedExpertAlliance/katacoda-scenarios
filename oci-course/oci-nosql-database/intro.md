The OCI NoSQL Database Service offers a fully managed, on-demand throughput and storage based provisioning that supports JSON, Table and Key-Value datatypes, all with flexible transaction guarantees. It is designed for database operations that require predictable, single digit millisecond latency responses to simple queries. NoSQL Database Cloud Service is suitable for applications such as Internet of Things, user experience personalization, instant fraud detection, and online display advertising.

Data is held in tables that can contain a mix of structured columns - in a relational style - and columns of JSON document type. Data - both structured and unstructured - can be queried schema-less JSON data by using the familiar SQL syntax. It is possible to update (change, add, and remove) parts of a JSON document. Because these updates occur on the server, the need for a read-modify-write cycle is eliminated, which would consume throughput capacity. ACID transactions are supported for full consistency. If required, consistency can be relaxed in favor of lower latency. 

In addition to the NoSQL SDKs (Java and Python at the time of writing), Oracle NoSQL Database Cloud Service also provides Oracle Cloud Infrastructure Console for you to access, manage, and use the NoSQL Database Cloud Service. The Oracle Cloud Infrastructure Console lets you create and manage NoSQL tables and indexes declaratively. You can also manipulate the data in your NoSQL tables and monitor your Oracle NoSQL Database Cloud Service from the console. All operations on tables, indexes and data in NoSQL Database service can be performed through the OCI Command Line Interface and the REST APIs. Oracle NoSQL Database Cloud Service provides easy-to-use CRUD (Create Read Update Delete) APIs. 

The *managed* aspect of this services results among other things in data safety: The Oracle NoSQL Database Cloud Service stores data across multiple Availability Domains (ADs) or Fault Domains (FDs) in single AD regions. If an AD or FD becomes unavailable, user data is still accessible from another AD or FD. Also encryption: Data is encrypted at rest (on disk) with Advanced Encryption Standard (AES). Data is encrypted in motion (transferring data between the application and Oracle NoSQL Database Cloud Service) with HTTPS.

In this scenario, you will take your first steps with OCI NoSQL Database Service. You will create a structured table, insert several records, query these records - working both from the command line and from the console. You will also work with schemaless (JSON) documents. In the last step, you will create and run a Node application that uses the Node SDK for NoSQL Dataase to query and create records. Finally, you will turn this Node application into a function that is deployed to OCI.

The scenario uses an Ubuntu 20.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. 

The assumption is that you have already completed the [the REAL OCI Handson Tenancy Preparation Scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial).


# Resources
[OCI Documentation on NoSQL Database](https://docs.cloud.oracle.com/en-us/iaas/nosql-database/index.html)
