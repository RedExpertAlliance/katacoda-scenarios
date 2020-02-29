Drop the tables that were created in this scenario - to clean up after yourself:

```
oci nosql table delete  --compartment-id $compartmentId --table-name-or-id  $tableName --force
oci nosql table delete  --compartment-id $compartmentId --table-name-or-id  $docTableName --force
```{{execute}}

Verify if the tables have been dropped:

`oci nosql table list --compartment-id $compartmentId `{{execute}}

This concludes your first rapid introduction to the NoSQL Database service on Oracle Cloud Infrastructure.
