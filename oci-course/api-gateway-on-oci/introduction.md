This scenario introduces the OCI Application Gateway. It is used to provide access to a Stock Response and to HTTP Backends. It is also used to expose serverless Functions on Oracle Cloud Infrastructure through a public endpoint. It was prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure in January 2020, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal. It was updated for the REAL OCI Handson Webinar Series that started in June 2020.

You will use the OCI Console to verify the creation of API Deployment with Routes and to monitor the calls to API Gateway. You can inspect the logging from the API Deployment on Object Storage - although it will take some time for the logging to arrive in the OCI Object Storage Bucket. 

The scenario uses an Ubuntu 19.04 environment with Docker and OCI CLI. Before you can start the steps in the scenario, the OCI Command Line interface is downloaded and installed for you. This will take about one minute. You will need Postman as well, if you want to invoke the routes on API Gateway directly from your computer.

The scenario expects a number of preparations:
* you already have deployed a function called *hello#* in an application called lab# where # is a number (either 1 or a number assigned to you in a workshop); the function app and function are in an OCI compartment *lab-compartment*. (this is part of [the Functions on OCI scenario](https://katacoda.com/redexpertalliance/courses/oci-course/functions-on-oci))
* an API Gateway already has been provided in compartment *lab-compartment* with permissions to access functions in this compartment; the API Gateway is associated with a public subnet (this is part of [the OCI Tenancy Preparation Scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial))

Note: it is assumed that you prepared an OCI tenancy using the Katacoda scenario [Preparation of Cloud Trial tenancy for REAL OCI scenarios](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial). This preparation will have created the VCN you need for running functions in OCI as well as the *lab-compartment* in which the functions are created. Additionally, you should have created a key pair in this scenario and prepared the contents of the *config* and  *oci_api_key.pem* files. If you have not gone through this OCI tenancy preparation, please do so before continuing with this scenario. You also need an Auth Token to login to the OCIR Container Registry; this too is created in the preparation scenario and used in the Function on OCI scenario.


![Overview of Function running on Fn](/lucasjellema/scenarios/api-gateway-on-oci/assets/api-gateway-on-oci.jpg)


