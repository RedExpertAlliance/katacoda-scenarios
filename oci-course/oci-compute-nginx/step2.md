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

`oci compute instance launch --compartment-id $COMPARTMENT_OCID --display-name $DISPLAY_NAME --availability-domain $AVAILABILITY_DOM --subnet-id $SUBNETID --image-id $IMG_ID --shape $SHAPE --ssh-authorized-keys-file $KEY_PUB --assign-public-ip true --user-data-file $CONFIG --wait-for-state RUNNING > /dev/null`{{execute}}

You will receive a message like this:

~~~~~
Action completed. Waiting until the resource has entered state: ('RUNNING',)
~~~~~

After some minutes the instance will be ready and you will get the prompt back.

You can use the following command to get the list of compute instances. You should see the one you've created with the name $DISPLAY_NAME:

`oci compute instance list --compartment-id $COMPARTMENT_OCID --availability-domain $AVAILABILITY_DOM --display-name $DISPLAY_NAME`{{execute}}

## What did we install in the compute instance?

We have installed **nginx** in the compute instance, we did it using a config file that contains the following:

~~~~
#cloud-config
write_files:
-   content: |
      load_module '/usr/lib64/nginx/modules/ngx_stream_module.so';
      events {}
      stream {
        server {
          listen     443;
          proxy_pass 147.154.28.140:6443;
        }
      }
    owner: root:root
    path: /home/opc/nginx.conf
runcmd:
-   /bin/yum install -y nginx
-   mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bkp
-   mv /home/opc/nginx.conf /etc/nginx/nginx.conf
-   sudo setenforce 0
-   /bin/firewall-offline-cmd --add-port=443/tcp
-   /bin/systemctl restart firewalld
-   /bin/systemctl start nginx
~~~~