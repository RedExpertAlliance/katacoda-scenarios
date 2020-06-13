In this scenario you will create a compute instance using the OCI CLI. This compute instance will host an NGINX web server. The compute instance will live
in the compartment that we are using in all our scenarios: lab-compartment.
The compute instance will live in the region you decide it, and will use a VM with shape VM.Standard2.1.

This scenario will help you to understand:

- How to create a compute instance using the OCI CLI
- How to automate the installation of components within the compute instance

Important notes to use this scenario:

- If you are following to learn how to create an OCI compute instance using the OCI CLI, then this is also useful for you. The result of following it will be
an NGINX installed with a welcome index page. 
- Depending on your region you will use a different image id. Every region has a different OCID for the image id, and therefore you need to set it accordingly.
We will provide you the OCID for your region in step 1

At the end of the scenario you will get something like this:

![Intro](/RedExpertAlliance/courses/oci-course/oci-compute-nginx/assets/intro.jpg)
![Ingress Rule](/RedExpertAlliance/courses/oci-course/oci-compute-nginx/assets/ingress_rule_80.jpg)
