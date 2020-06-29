# Working with Secrets

Encode a secret plain text into a base64 encoded string

`the_secret=$(echo "my secret message" | base64)`{{execute}}

Verify if the encoding was successful by decoding again:

`echo $the_secret | base64 --decode`{{execute}}

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

Of course we need to verify if we can retrieve the secret:
List of secrets:
`oci vault secret list --compartment-id $compartmentId`

Get the Secret OCID
```
secrets=$(oci vault secret list -c $compartmentId )
export secretOCID=$(echo $secrets | jq -r --arg secret_name "THE_SECRET" '.data | map(select(."secret-name" == $secret_name)) | .[0] | .id')
echo "OCID for secret THE_SECRET = $secretOCID "
```{{execute}}

## Check the Secret in the Console:

`echo "to inspect the secret, open the console at https://console.$REGION.oraclecloud.com/security/kms/vaults/${vaultOCID}/secrets"`{{execute}}


Specific Secret Details:

`oci vault secret get --secret-id $secretOCID`{{execute}}

Get Secret Bundle - including the secret contents:

`oci secrets secret-bundle get --secret-id $secretOCID`{{execute}} 

## Retrieve Secret contents
```
secretBundle=$(oci secrets secret-bundle get --secret-id $secretOCID )
export secretContents=$(echo $secretBundle | jq -r  '.data["secret-bundle-content"] | .content')
echo "base64 encoded secret content = $secretContents "
```{{execute}}

Verify if the encoding was successful by decoding again; the result should be *my secret message*:

`echo $secretContents | base64 --decode`{{execute}}

