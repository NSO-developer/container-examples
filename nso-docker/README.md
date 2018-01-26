# Simple base image for NSO.

Assumes the user of the container will get the NSO project into /root/nso-project.

NSO is started in /root/nso-project directory as ncs --foreground -v, please see run-nso.sh

# Container URL
The build-and-push.sh script creates the container as containers.cisco.com/frjansso/nso-base, you'll have to update this.
