# Working with Secrets

Encode a secret plain text into a base64 encoded string

`the_secret=$(echo "my secret message" | base64)`{{execute}}

What does the encoded message look like?
`echo $the_secret`{{execute}}

Verify if the encoding was successful by decoding again:

`echo $the_secret | base64 --decode`{{execute}}

This is not encryption and decryption. This is simple encoding and decoding, no key required and completely symmetrical.

# Creating the Secret in OCI Vault

Let's now create a secret in our vault for this secret text:

```
oci vault secret create-base64 \
        --compartment-id $compartmentId \
        --secret-name THE_SECRET \
        --vault-id $vaultOCID \
        --key-id $keyOCID \
        --region $REGION \
        --secret-content-content $the_secret
```{{execute}}
Our base64 encoded value is stored - encrypted using the key specified. Its stored value is unreadable. And not accessible anyway through the regular APIs.

Verify if we can retrieve the secret in the listing of all secrets:
List of secrets:
`oci vault secret list --compartment-id $compartmentId`{{execute}}

Get the Secret OCID into environment variable *secretOCID*.
```
secrets=$(oci vault secret list -c $compartmentId )
export secretOCID=$(echo $secrets | jq -r --arg secret_name "THE_SECRET" '.data | map(select(."secret-name" == $secret_name)) | .[0] | .id')
echo "OCID for secret THE_SECRET = $secretOCID "
```{{execute}}

## Checking on the Secret 

To inspect the secret in the OCI Console:

`echo "to inspect the secret, open the console at https://console.$REGION.oraclecloud.com/security/kms/vaults/${vaultOCID}/secrets"`{{execute}}

To retrieve specific secret details using the OCI CLI:

`oci vault secret get --secret-id $secretOCID`{{execute}}

Every secret has at least one secret version. Every time you update the contents of a secret, you create a new secret version. Secret version numbers start at 1 and increment by 1. A Secret Bundle is as best as I can determine the same thing as a version of the secret. It can have more than one rotation state at a time. Where only one secret version exists, such as when you first create a secret, the secret version is automatically marked as both 'current' and the 'latest'. Other states are 'pending', 'previous' and 'deprecated'. To retrieve a specific version of a secret, you need to retrieve the desired secret-bundle. If you do not specify a specific version or state, you will get the version that has status *current*. 

Get the secret-bundle for our little secret:

`oci secrets secret-bundle get --secret-id $secretOCID`{{execute}} 

## Retrieve Secret contents
If we want to get access to the actual contents of the secret, we can fetch the specific content section in the secret-bundle object. We need to base64 decode the content - to get the readable, plain text value.
```
secretBundle=$(oci secrets secret-bundle get --secret-id $secretOCID )
export secretContents=$(echo $secretBundle | jq -r  '.data["secret-bundle-content"] | .content')
echo "base64 encoded secret content = $secretContents "
```{{execute}}

Verify if the encoding was successful by decoding again; the result should be *my secret message*:

`echo $secretContents | base64 --decode`{{execute}}

Secrets can be simple strings, but also quite complex documents - JSON or otherwise. Secret contents are base64 encoded documents and the OCI Vault does not care what the contents of the secret signifies. The maximum size of a secret bundle is 25 KB, so do not go and store pictures as secrets. 

Optionally, you can apply a rule to manage how secrets are used. You can either create a rule regarding the reuse of secret contents across versions of a secret, or you can create a rule specifying when the secret contents expire. You can set how frequently you want secret contents to expire and what you want to happen when the secret or secret version expires. Expiration of individual secret versions is represented by a period of 1 to 90 days. Expiration of the secret itself is represented by an absolute time and date between 1 to 365 days from the current time and date. 

## Resources
(OCI Documentation - Managing Secrets)[https://docs.cloud.oracle.com/en-us/iaas/Content/KeyManagement/Tasks/managingsecrets.htm]

