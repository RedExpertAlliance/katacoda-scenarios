# OCI Events
INTRO

With OCI Events you can easily configure OCI Services and resources to publish events in response to actions that happened within other OCI elements, such as:

- Identity Services
- Functions
- Database
- Compute
- Big Data Service	
- Object Storage
- Block Volume 
- File Storage
- Data Safe
- Networking
- Health Checks
- Analytics
- Resource Manager
- Content and Experience
- Digital Assistant
- API Gateway

Pretty much most of the OCI components are candidates to trigger events.

Which type of events (you may be asking)? Let's take as an example the Object Storage Service. This Object Storage Service is capable to trigger events in the following scenarios:

1. When a bucket is created, deleted or updated
2. When an object is created, deleted or updated

Now, regardless the service and the type of event, you can create actions that will take place after the event happens. Those actions are of any of the following three types:

1. Streaming
2. Notifications
3. Functions

That means that after a bucket is created/deleted/updated, you have the ability to send a notification (email, for instance). Or you can call a function that can execute something with the information contained in the event. Within the function boundary, you can execute pretty much whatever you want with that information.
Or if you need to stream that information, you can also send it within a stream using Oracle Streams.

You also have the ability to chain events, with the alternative to use the attributes within the event information. For example:
- A bucket is created
- You want to create an action, everytime a bucket is created AND when the resourceName is "backups". 
- If those two things happen, you want to take action and send an Email to the backups administrator.

The format of the OCI Event is compliant with an standard defined by the CNCF for cloud based events. The envelope contains elements such as:

- cloudEventsVersion
- contentType
- data
- eventID
- eventTime
- eventType
- eventTypeVersion
- extensions
- source

(If you want to learn more about the structure, take a look to this documentation https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Reference/eventenvelopereference.htm)

For learning more about events, you can take a look to the official Oracle documentation, here: https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsoverview.htm

The OCI Events scenarios that you are about to go through are the following:

1.First scenario.
- We will use the object storage as the service that will produce the events.
- This first scenario is the simplest one. After a bucket is created and the name is bucketLab+LabID, you will receive an email with the details for the new bucket.
- In this scenario you will learn:
	a) How to create a Rule
	b) How to associate an event
	c) How to create an Action
	d) How to create a Topic with an email Endpoint

2.Second scenario.
- We are still going to use the object storage, but the rule will be different
- In this second scenario, we will react after an object is created in a bucket. 
- We will create a function that will receive the event information including the object created, and it will use its contents to create a PDF and upload it to a second bucket.
- The function code will be provided in the scenario. The recommendation is that you follow the functions scenarios before executing this.

![OCI Cloud Native Events](/RedExpertAlliance/courses/oci-course/infrastructure-events-notifications-streaming-oci/assets/intro.jpg)


# Resources

Oracle Documentation https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsoverview.htm
Event Envelope reference https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Reference/eventenvelopereference.htm