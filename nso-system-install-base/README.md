# System Install Docker Image
This docker file shows an **example** of a stripped down system install. Please note that you may want to modify it to your needs.

## Dockerfile
The Dockerfile is a two step dockerfile, in the first NSO is installed and then a lot of files are removed.

In the second step, all packages needed by NSO (Java, Python, etc.) are installed and then the stripped down version of NSO is copied.

# Auth
Please note that the Dockerfile creates a user named "admin", see admin.xml. If you look in the Dockerfile, you can see that a hashed password is inserted using `chpasswd`. The Dockerfile also has an example of how this password hash (cisco123) is generated.

As an alternative, run-nso.sh also checks for an environment variable called ADMIN_PWD. If this variable is set, it's used to set the password for admin.

This makes it possible to inject the password using Kubernetes secrets, see test-deployment.yaml.

**TODO**: Make is possible to pass password hash through the environment.
