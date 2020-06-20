In this scenario you will create a Node JS application that creates files on OCI Object Storage. Then you will turn this application into a Function and deploy that function to Oracle Cloud Infrastructure. Next, you will expose this File Writer Function through API Gateway for public access. Finally, you will create, deploy and invoke a second function - RSSFeed Reader - that writes RSS Feed contents through FileWriter to OCI Object Storage. 

You will use the OCI Console to verify the update of your API Deployment and to monitor the calls to API Gateway and check the creation of files on OCI Object Storage.

The scenario uses an Ubuntu 19.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the API Gateway directly from your computer.

The scenario expects a number of preparations:
* you already have deployed a function called *hello#* in an application called lab# where # is a number (either 1 or a number assigned to you in a workshop); the function app and function are in an OCI compartment *lab-compartment*. (this is part of [the Functions on OCI scenario](https://katacoda.com/redexpertalliance/courses/oci-course/functions-on-oci))
* an API Gateway already has been provided in compartment *lab-compartment* with permissions to access functions in this compartment; the API Gateway is associated with a public subnet (this is part of [the OCI Tenancy Preparation Scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial))
* there is already an API Deployment on the API Gateway - called MY_API_DEPL#

Note: it is assumed that you prepared an OCI tenancy using the Katacoda scenario [Preparation of Cloud Trial tenancy for REAL OCI scenarios](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial). This preparation will have created the VCN you need for running functions in OCI as well as the *lab-compartment* in which the functions are created. Additionally, you should have created a key pair in this scenario and prepared the contents of the *config* and  *oci_api_key.pem* files. If you have not gone through this OCI tenancy preparation, please do so before continuing with this scenario. You also need an Auth Token to login to the OCIR Container Registry; this too is created in the preparation scenario and used in the Function on OCI scenario.

The scenario was prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure on January 20th, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal. The scenario was updated for the REAL OCI Handson Webinar Series that started in June 2020.

![Function on OCI to read RSS Feed and pass it to second Function (via API Gateway) to write to Object Storage](/lucasjellema/scenarios/oci-functions-objects-apigateway/assets/oci-rssfeeder.jpg)
