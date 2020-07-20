This scenario introduces serverless Functions with Project Fn. It was originally prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure in January 2020, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal. It was updated for the REAL OCI Handson Webinar Series that started in June 2020

The scenario uses an Ubuntu 20.04 environment with embedded browser based VS Code, Docker, Fn CLI and Fn Server running locally. It does not require an OCI Cloud instance.

You will create Functions locally and deploy them to the local Fn Server. Functions can then be invoked through the Fn CLI or through regular HTTP clients such as CURL. You will get some guidance on debugging and logging.

In step 3. you will look at testing the function - both locally, before deployment (using Jest) as well as remotely after deployment - for functionality (with Newman) and performance (using Apache Bench).

In step 4, you will look at passing (environment specific) context variables to the function's runtime deployment

The scenario works with Node (JS) and Java as runtime languages. You can experiment with Go, Ruby, Python as runtimes just as easily.

The scenario offers two bonus steps: one let's you create a Java function implemented with a GraalVM powered natively executable image (small size and faster startup ) and the other one demonstrates how any custom Docker Container image can provide the implementation of an Fn function.   

![Overview of Function running on Fn](assets/fn-overview.jpg)
