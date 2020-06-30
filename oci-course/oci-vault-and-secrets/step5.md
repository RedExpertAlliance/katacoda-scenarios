# Retrieve Secrets from Node Application

In this step, you will work with a Node application that retrieves the secret from the vault. This application uses the OCI SDK for TypeScript | JavaScript | Node to handle most of the work regarding composing and signing the REST API calls. The SDK still makes the REST calls under the hood - just like the CLI - and just as with the CLI are the details of these calls hidden from view.

![](assets/oci-sdks.png)

## 

npm init node-read-secret

npm install oci-sdk --save




## Resources

[Protect Your Sensitive Data With Secrets In The Oracle Cloud](https://blogs.oracle.com/developers/protect-your-sensitive-data-with-secrets-in-the-oracle-cloud)
[OCI SDK for JavaScript/Node/TypeScript](https://blogs.oracle.com/developers/oci-sdk-for-typescript-is-now-available-heres-how-to-use-it)

[How to Implement an OCI API Gateway Authorization Fn in Node.js that Accesses OCI Resources](https://www.ateam-oracle.com/how-to-implement-an-oci-api-gateway-authorization-fn-in-nodejs-that-accesses-oci-resources)

[OCI SDK for Node/JS/TypeScript - Secrets Library - getSecretBundle](https://docs.cloud.oracle.com/en-us/iaas/tools/typescript/1.2.0/classes/_secrets_lib_client_.secretsclient.html)