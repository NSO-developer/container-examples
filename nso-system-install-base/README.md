# Auth
Please note that the Dockerfile creates a user named "admin", see admin.xml. Since system install uses PAM authentication 
by default, you have to change ncs.conf to allow local authentication to allow the admin user to access over e.g. RESTCONF.
