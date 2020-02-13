A quick way to create real OCI resources is through the Object Storage service - one of the core services in any cloud environment and so too in Oracle Cloud Infrastructure.

In the OCI Service Menu - which you can open from the hamburger icon - navigate to Core Infrastructure | Object Storage | Object Storage.
The direct URL for Ashburn is:
https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets

Now make sure that you are in the right compartment context, of compartment *lab-compartment*. You select the compartment using the Compartment widget in the lower left hand corner. 

Press the button *Create Bucket*. A form appears in which you can enter the details for the new bucket.
![Create Bucket](/RedExpertAlliance/courses/introduction-to-oci/assets/oci-intro-create-bucket.png)


Set *Bucket Name* to *bucket-LAB_ID* (and replace LAB_ID with the id assigned to you by your instructor, for example 01). Accept the default values for Storage Tier and Encryption. In the field *TAG KEY* enter the value *department* and in *VALUE* enter *innovation*. This assigns a key-value pair to the new bucket that we can make use of later on when searching OCI resources. 

Press *Create Bucket*.

The new Object Storage Bucket is created. It should be listed in the list of buckets in compartment *lab-compartment*.
![Bucket List](/RedExpertAlliance/courses/introduction-to-oci/assets/oci-intro-after-create-bucket.png)

Click on the name of the new bucket. 

Objects in this bucket can be created in several ways: through the Command Line Interface of the REST API, in the Cloud Shell or from an SDK. Many OCI services will write their log files or data export files to an object storage bucket. And you can simply upload files through the Console.

Press *Upload Objects*. A dialog window appears where you can specify an object prefix - for example *LAB<LAB_ID>* - and where you can select or drag & drop files from your computer. Go go ahead and select a file to upload - the contents does not matter. 

![Upload File](/RedExpertAlliance/courses/oci-course/introduction-to-oci/assets/oci-intro-upload-file.png)

Press *Upload Objects* to upload the file into the bucket in Object Storage. When the upload is complete, you can close the dialog window. 

The file is now available in the list of objects. A number of actions can be performed on the object, including Download, Rename and Copy and Delete. You can inspect the Object Details. And create a Pre Authenticated Request for the object. This is a unique URL for this object that you can share with anyone to access the file, even someone who does not have any access to Oracle Cloud Infrastructure. This Pre Authenticated Request has an expiration time.

Download the file - to make sure it had been captured correctly in the bucket. You will find out later on how we can easily get hold of this same file from the OCI CLI.