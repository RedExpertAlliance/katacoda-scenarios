# Clean Up: Secret, Keys, Vault

To cleanup after ourselves we can remove the resources that were created in this scenario. However, some of the resources involved cannot just be deleted. Vault and Keys can be scheduled for deletion, but there is an enforced delay of at least 7 days to prevent an impactful, accidental removal of crucial assets. Secrets and Functions can be delete at will. Deletion of secrets is also handled in this two step approach: schedule for deletion, then after some time the actual removal.

## Remove Secret
To remove the secret that was created in step 4, execute this command. This sets the lifecycle state of the secret to PENDING_DELETION and then deletes it after the specified retention period ends.
`oci vault secret schedule-secret-deletion  --secret-id $secretOCID`{{execute}}

Inspect the state of the secret at this point:
`oci vault secret get --secret-id $secretOCID`{{execute}}
The *lifecycle-state* and the *time-of-deletion* are the most interesting properties in the result of this call.

## Remove Key

Deleting a key is not an immediate action; because of the potential impact, the key is not immediatebly discarded. We can schedule the deletion of a specific key. When we do this, it sets the lifecycle state of the key to PENDING_DELETION and then deletes it after the specified retention period ends; this period is between 7 days and 30 day. While in the pending state, we can undo the deletion to recover key.

This command schedules the key for deletion after 30 days:

`oci kms management key schedule-deletion  --key-id $keyOCID --endpoint $vaultManagementEndpoint`{{execute}}

The new key status can be inspected:
`oci kms management key get  --key-id $keyOCID --endpoint $vaultManagementEndpoint`{{execute}}

The scheduled deletion can be revoked:

`oci kms management key cancel-deletion --key-id $keyOCID --endpoint $vaultManagementEndpoint`{{execute}}

The new key status can be inspected:
`oci kms management key get  --key-id $keyOCID --endpoint $vaultManagementEndpoint`{{execute}}
The *lifecycle-state* is first updated to *CANCELLING_DELETION* and then to *ENABLED*.

## Remove Vault

The next call schedules the deletion of the specified vault. This sets the lifecycle state of the vault and all keys in it that are not already scheduled for deletion to PENDING_DELETION and then deletes them after the retention period ends. The lifecycle state and time of deletion for keys already scheduled for deletion won't change. If any keys in the vault are scheduled to be deleted after the specified time of deletion for the vault, the call is rejected with the error code 409.

`oci kms management vault schedule-deletion --vault-id $vaultOCID`{{execute}}

The new status of the vault is retrieved like this:

`oci kms management vault get --vault-id $vaultOCID`{{execute}}

The new key status - assigned because of the deletion of the vault - can be inspected:
`oci kms management key get  --key-id $keyOCID  --endpoint $vaultManagementEndpoint`{{execute}}

## Remove the Function
Removing the Function is the simplest of all operations - although traces of the Function are left behind in the form of the container image in the OCIR - the Container Registry.

`fn delete f  "lab$LAB_ID" secret-retriever`{{execute}}

## Remove the Dynamic Group and the Policy
Delete the Dynamic Group *functions-in-lab-compartment* that was created in the previous step:

```
oci iam dynamic-group list --compartment-id $TENANCY_OCID
dgs=$(oci iam dynamic-group list --compartment-id $TENANCY_OCID)
export dgId=$(echo $dgs | jq -r --arg dgname "functions-in-lab-compartment" '.data | map(select(."name" == $dgname)) | .[0] | .id')
oci iam dynamic-group delete --dynamic-group-id $dgId --force
```{{execute}}

Also delete the policy *read-secret-permissions-for-resource-principal-enabled-functions-in-lab-compartment* that created in step 6:

```
oci iam policy list --compartment-id $compartmentId
pols=$(oci iam policy list --compartment-id $compartmentId)
export polId=$(echo $pols | jq -r --arg polname "read-secret-permissions-for-resource-principal-enabled-functions-in-lab-compartment" '.data | map(select(."name" == $polname)) | .[0] | .id')
oci iam policy delete --policy-id $polId --force
```{{execute}}
