const https = require('https')
const httpSignature = require('http-signature')
const jsSHA = require("jssha")
const fs = require('fs')


function sign(request, options) {

    const headersToSign = [
        "host",
        "date",
        "(request-target)"
    ];

    const methodsThatRequireExtraHeaders = ["POST", "PUT"];

    if (methodsThatRequireExtraHeaders.indexOf(request.method.toUpperCase()) !== -1) {
        options.body = options.body || "";

        const shaObj = new jsSHA("SHA-256", "TEXT");
        shaObj.update(options.body);

        request.setHeader("Content-Length", options.body.length);
        request.setHeader("x-content-sha256", shaObj.getHash('B64'));

        headersToSign = headersToSign.concat([
            "content-type",
            "content-length",
            "x-content-sha256"
        ]);
    }

    httpSignature.sign(request, {
        key: options.privateKey,
        keyId: options.keyId,
        headers: headersToSign
    });

    const newAuthHeaderValue = request.getHeader("Authorization").replace("Signature ", "Signature version=\"1\",");
    request.setHeader("Authorization", newAuthHeaderValue);
}// sign


const readObjectFromStorage = async function (privateKey, keyId, tenancyId, namespace, bucketName, fileName) {
    /* return a promise that contains the REST API call */
    return new Promise((resolve, reject) => {
        /* the domain/path for the REST endpoint */
        const requestOptions = {
            host: 'objectstorage.us-ashburn-1.oraclecloud.com',
            path: `/n/${encodeURIComponent(namespace)}/b/${encodeURIComponent(bucketName)}/o/${encodeURIComponent(fileName)}`,
        };

        /* the request itself */
        const request = https.request(requestOptions, (res) => {
            let data = ''
            res.on('data', (chunk) => {
                data += chunk
            });
            res.on('end', () => {
                resolve(JSON.parse(data))
            });
            res.on('error', (e) => {
                reject(JSON.parse(e))
            });
        })

        /* sign the request using the private key, tenancy id and the keyId (see above) */
        sign(request, {
            privateKey: privateKey,
            tenancyId: tenancyId,
            keyId: keyId,
        })

        request.end()
    })
}

const readObject = async function (namespace, bucketName, fileName) {
    const privateKeyPath = process.env.OCI_RESOURCE_PRINCIPAL_PRIVATE_PEM
    const sessionTokenFilePath = process.env.OCI_RESOURCE_PRINCIPAL_RPST
    const rpst = fs.readFileSync(sessionTokenFilePath, { encoding: 'utf8' })
    const privateKey = fs.readFileSync(privateKeyPath, 'ascii')

    const payload = rpst.split('.')[1]
    const buff = Buffer.from(payload, 'base64')
    const payloadDecoded = buff.toString('ascii')
    const claims = JSON.parse(payloadDecoded)

    /* get tenancy id from claims */
    const tenancyId = claims.res_tenant
    /*  set the keyId used to sign the request; the format here is the literal string 'ST$', followed by the entire contents of the RPST */
    const keyId = `ST$${rpst}`

    const response = await readObjectFromStorage(privateKey, keyId, tenancyId, namespace, bucketName,fileName)
    return response


}
module.exports = {
    readObject: readObject
}


