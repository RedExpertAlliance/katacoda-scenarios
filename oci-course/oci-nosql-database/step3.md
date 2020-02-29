Querying data from the table

`oci nosql query execute --compartment-id $compartmentId --statement="SELECT * FROM $tableName"`{{execute}}

Of course there is no data yet. Let us create a record:

`oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $tableName VALUES (1,\"John\",\"Scotland\")"`{{execute}}

And query the table again for all its data:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT * FROM $tableName"`{{execute}}

And some more records:
```
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $tableName VALUES (2,\"Rolando\",\"Mexico\")"
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $tableName VALUES (3,\"Sven\",\"Germany\")"
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $tableName VALUES (4,\"José\",\"Portugal\")"
oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO $tableName VALUES (5,\"Robert\",\"Netherlands\")"
```{{execute}}

And query the table again for all its data:
`oci nosql query execute --compartment-id $compartmentId --statement="SELECT * FROM $tableName"`{{execute}}
