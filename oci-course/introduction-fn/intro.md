This scenario introduces serverless Functions with Project Fn. It was originally prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure in January 2020, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal. It was updated for the REAL OCI Handson Webinar Series that started in June 2020

The scenario uses an Ubuntu 19.04 environment with Docker, Fn CLI and Fn Server running locally. It does not require an OCI Cloud instance.

You will create Functions locally and deploy them to the local Fn Server. Functions can then be invoked through the Fn CLI or through regular HTTP clients such as CURL.

The scenario works with Node (JS) and Java as runtime languages. You can experiment with Go, Ruby, Python as runtimes just as easily.

![Overview of Function running on Fn](assets/fn-overview.jpg)
