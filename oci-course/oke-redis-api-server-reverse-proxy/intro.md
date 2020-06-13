In this scenario you will create a compute instance using the OCI CLI. This compute instance will host an NGINX web server. The compute instance will live
in the compartment that we are using in all our scenarios: lab-compartment.
The compute instance will live in the region you decide it, and will use a VM with shape VM.Standard2.1.

**This scenario is needed to complete the OKE scenario, since this will serve as a Reverse Proxy for the OKE API Server. This is needed, because within the
katacoda environment it is blocked port 6443 for outbound connections. 
In this scenario you will provision a compute instance that will contain an NGINX server, configured as a reverse proxy to send traffic to the API Server.**

Important notes to use this scenario:

- You can use this scenario to have NGINX as the reverse proxy for the OKE API Server that is used in the [OKE Scenario Part 2](https://www.katacoda.com/redexpertalliance/courses/oci-course/oke-redis-cache-and-functions-oci_part2 "OKE Scenario Part 2").
If that is your case, then you need to finish this in order to continue with the OKE Scenario.
- Depending on your region you will set an specific image id for your VM Shape.