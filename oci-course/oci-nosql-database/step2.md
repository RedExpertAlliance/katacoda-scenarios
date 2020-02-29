# https://docs.cloud.oracle.com/en-us/iaas/nosql-database/doc/typical-policy-statements-manage-tables.html
# https://docs.oracle.com/en/database/other-databases/nosql-database/19.5/sqlreferencefornosql/insert-statement.html
# https://docs.oracle.com/en/database/other-databases/nosql-database/19.5/sqlreferencefornosql/sql-query-management.html


allow group lab-participants to manage nosql-tables in compartment lab-compartment
allow group lab-participants to manage nosql-family in compartment lab-compartment

oci nosql query execute --compartment-id $compartmentId --statement="SELECT * FROM test"

oci nosql query execute --compartment-id $compartmentId --statement="INSERT INTO test VALUES (4,\"Hao\",\"Eindhoven\")"