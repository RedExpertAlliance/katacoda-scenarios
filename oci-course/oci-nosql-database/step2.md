Creating a table in the NoSQL Database can be done in the console, through the REST API and the SDKs as well as on the command line. You will now create a table on the command line.

Execute this command to derive the name to be assigned to the table:
```
export tableName=labTable$LAB_ID
echo Table is called $tableName
```{{execute}}

The next step is the creation of the table with the NoSQL Database service. Execute this next command to have a table created with three columns:
* id - numeric, meaningless primary key
* name - string
* country - string

`oci nosql table create --compartment-id $compartmentId  --name $tableName --ddl-statement "CREATE TABLE IF NOT EXISTS $tableName (id INTEGER, name STRING, country STRING, PRIMARY KEY(SHARD(id)))" --table-limits="{\"maxReadUnits\": 15,  \"maxStorageInGBs\": 1,  \"maxWriteUnits\": 15 }" `{{execute}} 

Check if the table has been created:
`oci nosql table list --compartment-id $compartmentId `{{execute}}

Note: the creation of the table happens asynchronously from the *oci nosql table create* command. It might be required to execute the list command a few times before the table is present.

You can check the list of NoSQL Database tables in the current compartmant in the console: Database | NoSQL Database.
https://console.us-ashburn-1.oraclecloud.com/nosql/tables

## Resources
[OCI Documentation on SQL for Inserting data  in NoSQL Database](https://docs.oracle.com/en/database/other-databases/nosql-database/19.5/sqlreferencefornosql/insert-statement.html)

[OCI Documentation on SQL Queries in NoSQL Database](https://docs.oracle.com/en/database/other-databases/nosql-database/19.5/sqlreferencefornosql/sql-query-management.html)

[OCI Documentation on REST APIs on NoSQL Database Service](https://docs.cloud.oracle.com/en-us/iaas/api/#/en/nosql-database/20190828/)

[OCI Documentation on Command Line Interface for NoSQL Database Service](https://docs.cloud.oracle.com/en-us/iaas/tools/oci-cli/2.9.4/oci_cli_docs/cmdref/nosql.html) 
