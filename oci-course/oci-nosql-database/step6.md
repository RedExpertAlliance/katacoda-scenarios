# Bonus: Interact with NoSQL Database from Function
In this step, you will work with a very simple Node application that leverages the Node SDK for NoSQL Database. Then you will turn this Node application into a function - and invoke that function to query NoSQL Database on your behalf.

## Simple Node Application using the SDK for NoSQL Database

`fn init --runtime node nosql-talker`{{execute}}

Execute the following snippet - that will do several things including downloading the NoSQL Database SDK for Node (`npm install oracle-nosqldb`)
```
cd nosql-talker

npm install oracle-nosqldb --save
npm install

cp ~/.oci/oci_api_key.pem .

cp ~/nosql.js .
```{{execute}}

Open file *nosql.js* in the IDE. Check out function *nosqlActor* and see how the SDK facilitates the interaction for querying and creating records. 

This next command creates a snippet of JSON that you need to copy and paste into file *nosql.js*, starting at line 5:
```
json="region: \"$REGION\",\n
compartment: \"lab-compartment\",\n 
auth: {\n
    iam : {\n
        tenantId: \"$TENANCY_OCID\",\n
        userId: \"$USER_OCID\",\n
        fingerprint: \"YOUR_FINGERPRINT_FROM FILE ~/.oci/config\",\n
        privateKeyFile: \"oci_api_key.pem\"\n
    }\n
}"
echo "paste JSON fragment in file oci-configuration.js "
echo -e $json
```{{execute}

Note: After pasting the snippet into nosql.js, there is one final step before you can run the Node application: Replace the fingerprint mock value with the actual fingerprint value from file ~/.oci/config

And now execute the Node application that interacts with NoSQL Database Cloud Service:
`node nosql.js`{{execute}}

If the execution fails you may have overlooked the step instruction to replace the fingerprint in nosql.js. I kept making that mistake 

See the results coming in. Feel free to edit the file `nosql.js` and manipulate the results.

## Create and Deploy Function

Open file *func.js*. Copy the snippet below and paste it in *func.js*, completely replacing all current contents:

<pre class="file" data-target="clipboard">
const fdk=require('@fnproject/fdk')
const nosql=require('./nosql')

fdk.handle(async function(input){
  let name = 'John';
  if (input.name) {
    name = input.name;
  }
  const rows = await nosql.queryRecordByName(name)
  console.log(`\nInside Node nosql-talker function; the query result is in: ${JSON.stringify(rows)}`)
  return {'name':name, 'results': rows}
})
</pre>


Now deploy the function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

And run it:

`echo -n '{ "name":"Rolando"}' | fn invoke lab$LAB_ID nosql-talker`{{execute}}
and
`echo -n '{ "name":"Sven"}' | fn invoke lab$LAB_ID nosql-talker`{{execute}}

## Resources

[Tutorial: Connecting an Application to Oracle NoSQL Database Cloud Service](https://oracle.github.io/nosql-node-sdk/tutorial-connect-cloud.html)

[Oracle NoSQL Database Node.js SDK](https://oracle.github.io/nosql-node-sdk/index.html)
