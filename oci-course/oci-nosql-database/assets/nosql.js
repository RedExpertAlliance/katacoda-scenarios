const NoSQLClient = require('oracle-nosqldb').NoSQLClient;

const getNoSQLClient = function () {
    return nosqlClient = new NoSQLClient({
        region: "us-ashburn-1",
        compartment: 'lab-compartment',
        auth: {
            iam: {
                tenantId: "ocid1.tenancy.",
                userId: "ocid1.user.oc1..aaalv5q",
                fingerprint: "02:4f",
                privateKeyFile: "oci_api_key.pem"
            }
        }
    })
}

const queryRecordByName = async function (name) {
    let nosqlClient
    try {
        nosqlClient = getNoSQLClient();
        const tableName = process.env['tableName'] ? process.env['tableName'] : "labTable1";
        try {
            let result = await nosqlClient.query(
                `SELECT * FROM ${tableName} WHERE NAME= ${name}`);
            return result.rows

        } catch (error) {            
            console.log(`Errors ${JSON.stringify(error)}`)
        }
    } catch (e) {
        console.log(`Exception ${e}, ${JSON.stringify(e)}`)

    } finally {
        if (nosqlClient) {
            nosqlClient.close();
        }
    }
}

const nosqlActor = async function () {
    let nosqlClient
    try {
        nosqlClient = getNoSQLClient();
        const tableName = process.env['tableName'] ? process.env['tableName'] : "labTable1";
        try {
            let result = await nosqlClient.get(tableName, { id: 1 });
            console.log(`Got row with id = 1: ${JSON.stringify(result.row)}`);
            result = await nosqlClient.query(
                `SELECT * FROM ${tableName} WHERE NAME="Rolando"`);
            console.log("All rows where NAME= Rolando")
            for (let row of result.rows) {
                console.log(row);
            }
            result = await nosqlClient.query(
                `SELECT * FROM ${tableName} `);
            console.log("All rows")
            for (let row of result.rows) {
                console.log(row);
            }
            console.log("Add record for Jürgen")
            result = await nosqlClient.put(tableName, { "id": 6, "name": "Jürgen", "country": "Germany" });
            console.log(`Result of adding record for Jürgen: ${JSON.stringify(result)} `)

        } catch (error) {
            //handle errors
            console.log(`Errors ${JSON.stringify(error)}`)
        }
    } catch (e) {
        console.log(`Exception ${e}, ${JSON.stringify(e)}`)

    } finally {
        if (nosqlClient) {
            nosqlClient.close();
        }
    }
}


const run = async function () {

    const result = await nosqlActor()
    console.log("done with run")

}

run()

module.exports = {
    queryRecordByName: queryRecordByName
}


