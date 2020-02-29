The queries that can be executed against the NoSQL Database tables can refer to JSON document properties in both the WHERE and SELECT clauses. Here are some examples of how you can query the contents of the JSON documents. 

Query the *staff* object from all documents that contain such an object:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT d.document.staff FROM $docTableName d WHERE EXISTS d.document.staff"`{{execute}}

Only select the *country* values from the staff members (from the records that even have a *staff* object in the root of their *document*) :
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT d.document.staff.country FROM $docTableName d WHERE EXISTS d.document.staff"`{{execute}}

From the second JSON document, select all countries that alphabetically rank behind Switzerland:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT d.document.values(\$value > \"Switzerland\") FROM $docTableName d WHERE id=5"`{{execute}}


# Updating JSON Documents
The JSON documents in the NoSQL Database table can be updated in a partial fashion. Here are two examples.

Partially update the second JSON document - change the country name for just the NL entry, from Netherlands to Holland:
`oci nosql query execute --compartment-id $compartmentId --statement="UPDATE $docTableName d set d.document.NL=\"Holland\" where id=5 returning id, document"`{{execute}}

Query the document for key NL to see the change applied:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT d.document.NL FROM $docTableName d WHERE id=5"`{{execute}}

In a similar way, the next command will add a staff member in the former JSON document - by adding an element to the array object:

`oci nosql query execute --compartment-id $compartmentId --statement="UPDATE $docTableName d ADD d.document.staff  {\"name\":\"Dan\",\"country\":\"USA\"} where id=2 returning *"`{{execute}}

Query the document for the *staff* object and verify that *Dan* was added:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT d.document.staff FROM $docTableName d WHERE id=2"`{{execute}}

## Resources

[Documentation NoSQL Database - Querying JSON Data](https://docs.oracle.com/en/database/other-databases/nosql-database/18.1/sqlfornosql/working-json.html)

Partial JSON Document Update in Oracle NoSQL Database - https://blogs.oracle.com/nosql/json-partial-updates-using-the-oracle-nosql-database-query-language