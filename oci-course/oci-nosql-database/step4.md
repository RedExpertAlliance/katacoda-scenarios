Execute this command to derive the name to be assigned to the table:
```
export docTableName=labDocumentsTable$LAB_ID
echo Table is called $docTableName
```{{execute}}

The next step is the creation of the table for schemaless JSON documents with the NoSQL Database service. Execute this next command to have a table created with three columns:
* id - numeric, meaningless primary key
* document - JSON

`oci nosql table create --compartment-id $compartmentId  --name $docTableName --ddl-statement "CREATE TABLE IF NOT EXISTS $docTableName (id INTEGER, document JSON, PRIMARY KEY(SHARD(id)))" --table-limits="{\"maxReadUnits\": 25,  \"maxStorageInGBs\": 1,  \"maxWriteUnits\": 25 }" `{{execute}} 

Check if the table has been created:
`oci nosql table list --compartment-id $compartmentId `{{execute}}

Note: the creation of the table happens asynchronously from the *oci nosql table create* command. It might be required to execute the list command a few times before the table is present.

Insert a JSON document into the new table:

```
document='{ "staff":[{"name":"Sven","country":"Germany"},{"name":"José","country":"Portugal"},{"name":"Rolando","country":"Mexico"},{"name":"Arturo","country":"Norway"}]}'
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $docTableName  (id, document)  VALUES (2,$document)"
```{{execute}}

And show to how utterly schemaless our database is, let's create an entirely different JSON document (the contents of document *special-doc.json*), and insert that into the table too:

```
document=$(cat special-doc.json)
echo $document
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $docTableName  (id, document)  VALUES (5,$document)"
```{{execute}}

Query the table for all its data:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT * FROM $docTableName"`{{execute}}

In the next step, let's see how we can query and manipulate the JSON document in the NoSQL database.