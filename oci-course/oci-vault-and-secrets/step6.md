# Retrieve Secret from Resource Principal Enabled Function

Function deployed to FaaS: Resource Principal enabled. Does not require the private key for a specific user.

Create new function *secret-retriever* using Node as the runtime: 
`fn init --runtime node secret-retriever`{{execute}}

Change to the directory created for the function, with the familiar resources *func.js*, *func.yaml* and *package.json*; install the NPM module for the FN FDK

```
cd secret-retriever
npm install 
```{{execute}}

paste into func.js:
<pre >
const fdk = require('@fnproject/fdk');
const fs = require('fs')

fdk.handle(async function (input) {
    const rpst = fs.readFileSync(process.env.OCI_RESOURCE_PRINCIPAL_RPST, { encoding: 'utf8' })
    const payload = rpst.split('.')[1]
    const payloadDecoded = Buffer.from(payload, 'base64').toString('ascii')
    const claims = JSON.parse(payloadDecoded)
  
  return {
     'pem-file': process.env.OCI_RESOURCE_PRINCIPAL_PRIVATE_PEM
     ,'rpst-file' : process.env.OCI_RESOURCE_PRINCIPAL_RPST
     ,'rpst-claims' : claims
  }
})
</pre>

Deploy the function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Invoke the function:

`fn invoke "lab${LAB_ID}" secret-retriever --content-type application/json`{{execute}}

This will return evidence of the values injected into the function at run time by the Oracle Functions FaaS framework because of the Resource Principal configuration.

Add these dependencies:

`npm install http-signature jssha install --save`{{execute}}

Now again copy this snippet to func.js:
<pre>
const fdk = require('@fnproject/fdk');
//const rs = require('./readSecret')
const ro = require('./readObject')
fdk.handle(async function (input) {
    const r = await ro.readObject(input.namespace, input.bucketName, input.fileName)
    return {
     'fileContents': r
    }
})
</pre>

Deploy the function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Invoke the function:

`export NAMESPACE=$(oci os ns get| jq -r  '.data')`

`echo -n "{\"namespace\":\"$NAMESPACE\", \"bucketName\":\"function-resource-principal-test\", \"fileName\": \"test-file.json\"}" | fn invoke "lab${LAB_ID}" secret-retriever --content-type application/json`{{execute}}

<pre>
const fdk = require('@fnproject/fdk');
const rs = require('./readSecret')
fdk.handle(async function (input) {
    let secretName = "BIG_SECRET"
    if (input) {
      secretName = input.secretName? input.secretName : secretName
    }
    const r = await rs.readSecret(secretName)
    return {
     'secret': r
    }
})
</pre>
Add these dependencies:

`npm install http-signature jssha install --save`{{execute}}

Deploy the function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Invoke the function:

`echo -n '{"secretName":"hushhush"}' | fn invoke "lab${LAB_ID}" secret-retriever --content-type application/json`{{execute}}

This time, a secret really is read from the Vault and its value is included in the function's response.

## Resources



[Oracle Functions - Connecting from Java To An ATP Database With A Wallet Stored As Secrets](https://blogs.oracle.com/developers/oracle-functions-connecting-to-an-atp-database-with-a-wallet-stored-as-secrets)

[OCI SDK for Node/JS/TypeScript - Secrets Library - getSecretBundle](https://docs.cloud.oracle.com/en-us/iaas/tools/typescript/1.2.0/classes/_secrets_lib_client_.secretsclient.html)