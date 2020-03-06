In this scenario you will create a compute instance using the OCI CLI. This compute instance will host an NGINX web server. The compute instance will live
in the compartment that we are using in all our scenarios: lab-compartent.
The compute instance will live in ASHBUR-AD-1 availability domain and will use a VM shape VM.Standard2.1.

This scenario will help you to understand:

- How to create a compute instance using the OCI CLI
- How to automate the installation of components within the compute instance

You can use this scenario to have NGINX as the reverse proxy for the OKE API Server that is used in the OKE scenario. Actually it is a pre-requisite for that
scenario.