In this scenario you will create a compute instance using the OCI CLI. This compute instance will host an NGINX web server. The compute instance will live
in the compartment that we are using in all our scenarios: lab-compartment.
The compute instance will live in ASHBURN-AD-1 availability domain and will use a VM with shape VM.Standard2.1.

This scenario will help you to understand:

- How to create a compute instance using the OCI CLI
- How to automate the installation of components within the compute instance

Important notes to use this scenario:

- You can use this scenario to have NGINX as the reverse proxy for the OKE API Server that is used in the [OKE Scenario](https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci "OKE Scenario").
If that is your case, then you need to finish this in order to continue with the OKE Scenario.
- If you are following to learn how to create an OCI compute instance using the OCI CLI, then this is also useful for you. The result of following it will be
an NGINX installed with a welcome index page. 