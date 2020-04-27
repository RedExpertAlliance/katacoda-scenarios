export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile
# now oci is recognized as a command

echo "Installing OCI CLI in background"

echo "Installing Project Fn - in the background"


echo "Wait for the file /root/allSetInBackground to appear"

