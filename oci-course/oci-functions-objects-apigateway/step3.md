# Create, Deploy and Invoke Node Application as FileWriter Function on OCI

In this step, you wrap the FileWriter application in a Function and deploy that function on OCI. Then we will invoke the function.

Check the contents of file `~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/func.js` in the IDE. This file is the wrapper for the Fn Function around the FileWriter application.

Open the file *func.yaml* in the IDE. Change the *name* of the function from *file-writer* to *file-writer#* , where # is the LAB_ID you have been assigned. 

`echo $LAB_ID`{{execute}}

Let's deploy this function to application `lab#`. Execute the next command - make sure you are in the correct directory.

```
cd ~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer

fn -v deploy --app "lab$LAB_ID"
```{{execute}}

We have to ensure that the environment variable *bucketName* is set in the context where function FileWriter is executing. This is done by defining a configuration setting for the function:
```
fn config function "lab$LAB_ID" file-writer bucketName "$bucketName"
```{{execute}}

To invoke the function

`echo -n '{ "filename":"my-special-file.txt","contents":"A new file, written by a Function on OCI"}' | fn invoke lab$LAB_ID file-writer`{{execute}}

Check the current contents of the bucket:

`oci os object list --bucket-name $bucketName`{{execute}}

Check in OCI Console for Object Storage: the bucket you have created and the file that should now be visible and manipulatable in the console: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets.

`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/object-storage/buckets"`{{execute}}

Retrieve the file that was just created:

`oci os object get  -bn $bucketName --name my-special-file.txt --file my-special-file.txt`{{execute}}

Check contents of the file:
```
ls -l my-special-file*
cat my-special-file.txt
```{{execute}}


