Work with Vault through CLI

Encode a secret plain text into a base64 encoded tring

`the_secret=$(echo "my secret message" | base64)`{{execute}}

Verify if the encoding was successful by decoding again:

`echo $the_secret | base64 --decode`{{execute}}

Let's now create a secret in our vault for this secret text:

```
oci vault secret create-base64 \
        --compartment-id $compartmentId \
        --secret-name THE_SECRET \
        --vault-id ocid1.vault.oc1... \
        --key-id ocid1.key.oc1... \
        --region $REGION \
        --secret-content-content $the_secret
```{{execute}}

Of course we need to verify if we can retrieve the secret:
List of secrets:
`oci vault secret list --compartment-id $compartmentId`



Specific Secret Details:

`oci vault secret get --secret-id $secretOCID`