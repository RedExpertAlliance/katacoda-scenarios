# Create a Key

Creating a key that is used to encrypt and decrypt strings - or anything you want to have encrypted and decrypted - is best done in the console.

Please open the vault in the console:
`echo "Open the Console at this URL: https://console.${REGION}.oraclecloud.com/security/kms/vaults/${vaultOCID}"`{{execute}} 

Then create a new (Master Encryption) Key. Set the name to *lab-key*.
![](assets/create-key-in-console.png)

When the key is successfully created, return to the terminal window. Get the key's details:

`   `{{execute}}

Let's retrieve the Key's ocid into an environment variable:
```
keys=$(oci kms management key list -c $compartmentId --endpoint $vaultManagementEndpoint)
export keyOCID=$(echo $keys | jq -r --arg display_name "lab-key" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for vault lab-key = $keyOCID "
```{{execute}}

## Using the Key for some Encryption and Decryption

```
toEncrypt=$(echo "Happy families are all alike,every unhappy family is unhappy in its own way." | base64)
toEncrypt=$(echo $toEncrypt|tr -d ' ')
encrypted=$(oci kms crypto encrypt --key-id $keyOCID --plaintext $toEncrypt --endpoint $vaultCryptoEndpoint)
export cipher=$(echo $encrypted | jq -r '.data | .ciphertext')
echo $cipher
```{{execute}}


And now for some decryption magic: get a the original contents from this unreadable encrypted text, using the *decrypt* operation for the master key:

```
decrypted=$(oci kms crypto decrypt --key-id $keyOCID  --ciphertext $cipher --endpoint $vaultCryptoEndpoint)
export b64encodedPlaintext=$(echo $decrypted | jq -r '.data | .plaintext')
echo $b64encodedPlaintext | base64 --decode
```{{execute}}


## Resources 
https://blogs.oracle.com/developers/protect-your-sensitive-data-with-secrets-in-the-oracle-cloud