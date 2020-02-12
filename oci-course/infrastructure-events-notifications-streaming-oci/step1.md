## Wait for OCI CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

## Oracle Events Configuration

In this scenario we will be mostly using the OCI Console to configure the Events, Rules, Topics, etc.

In the tenant that you are using, there are a set of policies already in place, but if you are curious or if you are using your own environment you need to
create a set of polices that will allow users to create and manage rules

As we already mentioned in the tenant you are using, those policies are already in place. But if you are using this tutorial pointing to your tenant, then 
you will have to create the following policies (you need to go to Governance and Administration, go to Identity and click Policies).

Create a Policy and give name/description and type the following statements:

allow group <RuleAdmins> to inspect compartments in tenancy
allow group <RuleAdmins> to use tag-namespaces in tenancy
allow group <RuleAdmins> to inspect streams in tenancy
allow group <RuleAdmins> to use stream-push in tenancy
allow group <RuleAdmins> to use stream-pull in tenancy
allow group <RuleAdmins> to use virtual-network-family in tenancy
allow group <RuleAdmins> to manage function-family in tenancy
allow group <RuleAdmins> to use ons-topic in tenancy
allow group <RuleAdmins> to manage cloudevents-rules in tenancy

(For a full explanation of this statements, go to: https://docs.cloud.oracle.com/en-us/iaas/Content/Events/Concepts/eventsgetstarted.htm)

The <RuleAdmins> group needs to be created and your user must be part of it in order to be able to create what you are going to learn in this scenario.

To validate if your tenant has the policy with the previous statements execute the following:
`oci iam policy get --policy-id policy_ocid`{{execute}}

Ask for your instructor to give you the policy_ocid, or if you are using your own tenant go to the policy page and get the ocid.

With the policy and statement in place, we are ready to create our first Rule that will be triggered after a Object Store Bucket is created.

To do that, login with your credentials to the OIC Dashboard. What we are going to do is:

- Create a Topic
- Create a Suscription
- Create a Rule
- Create a Bucket that will trigger that Rule

Once you are in the OIC Dashboard, go here: Solutions and Platform group, then to Application Integration and click on Notifications.
Create a Topic and give a name & description:
- Name: topic{LabID}
- Description: This is the topic for email notifications

After that, simply use the create button.

Now we need to create a suscription to the previous Topic, and there we will configure our own email address to receive the notifications after the Bucket 
is created.

Click on the Topic that we have created, and then click on Subscription. Give a name and select Email as the protocol, then type your prefered email address
where you want to receive the notifications.

You are all set, now in the next step we will create the Rule that will be triggered after the Bucket creation, and that will use the Topic and Subscription
previously created.






