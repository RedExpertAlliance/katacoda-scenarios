# Summary

This completes your introduction to Vaults, Keys and Secrets. 

You have created a Vault, generated a Key in that Vault and created a Secret in the Vault.

You have used to Key to encrypt contents. The encrypted contents was later decrypted as well.

The secret was stored in the Vault and later retrieved using the OCI CLI and in a Node application using the Node SDK for OCI. The last step you took was the creation of a Function that retrieves the secret - using its Resource Principal status.  

Finally, the function, the dynamic group and the policy were removed and the Secret, Key and Vault where scheduled for deletion. Note that the pending deletion for the Vault, Key and Secret can still be canceled, although for Key and Secret only when the deletion of the Vault is canceled first.