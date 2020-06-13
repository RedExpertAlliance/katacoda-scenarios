## Let's use OCI CLI to provision our compute

The command receives all the following values:
- Compartment Id: It is the compartment where the compute instance will be created
- Display Name: It is the name of the compute instance to be provisioned
- Availability Domain: It is the availability domain where the compute will be provisioned
- Subnet ID: It is the subnet-id where the the compute will use
- Image ID: It is the ID for the image that will be used to create the instance (e.g. Oracle Linux)
- Shape: Is the shape of the compute instance
- SSH Authorized keys-file: It is the path to the public key file
- Config file: It is the file that contains what we want to install in the compute instance

(**Note. All the variables were set in the previous step.**)

The following variable points to the configuration of our instance. In this case it will include the installation for NGINX:
`export CONFIG=/root/computeInstanceConfigNginx.txt`{{execute}}

Let's create the compute instance:

`oci compute instance launch --compartment-id $COMPARTMENT_OCID --display-name $DISPLAY_NAME --availability-domain $AVAILABILITY_DOM --subnet-id $SUBNETID --image-id $IMG_ID --shape $SHAPE --ssh-authorized-keys-file $KEY_PUB --assign-public-ip true --user-data-file $CONFIG --wait-for-state RUNNING > /dev/null`{{execute}}

You will receive a message like this:

~~~~~
Action completed. Waiting until the resource has entered state: ('RUNNING',)
~~~~~

After some minutes the instance will be ready and you will get the prompt back.

You can use the following command to get the list of compute instances. You should see the one you've created with the name $DISPLAY_NAME:

`oci compute instance list --compartment-id $COMPARTMENT_OCID --availability-domain $AVAILABILITY_DOM --display-name $DISPLAY_NAME`{{execute}}

## What did we install in the compute instance?

We have installed **nginx** in the compute instance, with a simple index.html. The config file we used (computeInstanceConfigNginx.txt), looks like this:

~~~~
#cloud-config
write_files:
-   content: |
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
      <head>
        <title>Nginx HTTP Server on Oracle Cloud Infrastructure</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      </head>
      <body>
        <div><b>NGINX</b> on Oracle Cloud Infrastructure. Katacoda OCI scenarios</div>
      </body>
      </html>
    owner: opc:opc
    path: /home/opc/index.html
runcmd:
-   /bin/yum install -y nginx
-   /bin/systemctl start nginx
-   sudo setenforce 0
-   /bin/firewall-offline-cmd --add-port=80/tcp
-   /bin/systemctl restart firewalld
-   cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.original.html
-   cat /home/opc/index.html > /usr/share/nginx/html/index.html
~~~~