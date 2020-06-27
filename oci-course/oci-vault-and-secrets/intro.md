Vault (pka Key Management)

As part of the Oracle Cloud Infrastructure Vault, we can manage both secrets and keys.


## Secrets
Secrets are credentials such as passwords, certificates, SSH keys, or authentication tokens for third-party cloud services that you use with Oracle Cloud Infrastructure services. Storing secrets in a vault provides greater security than you might achieve by storing them elsewhere, such as in code or configuration files. You can retrieve secrets from the vault when you need them to access resources or other services. You (an application) can cache a secret and use it as long as you need it. 

The following diagram illustrates the most fundamental secrets use case. You create secret (credentials) and store them in Oracle Cloud Infrastructure vault. The application can use/read the secret as needed (4) and then connect (5) to the target service.
![](assets/oci-vault.png)
source: https://www.ateam-oracle.com/secure-way-of-managing-secrets-in-oci

Advantages of managing secrets in Oracle Cloud Infrastructure vault
* You can centralize secrets management and only administrators will have Create, Update, and Delete permissions on secrets
* You can rotate/update secrets/credentials without any changes in the consumer application
* Secrets are encrypted at rest to improve security posture
* secrets management proliferates machine to machine communication or serverless computing by making it secure*