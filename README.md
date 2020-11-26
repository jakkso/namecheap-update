## Namecheap Dynamic DNS Update Script

This is a simple script, accompanied by a set of systemd service and timer files to run the
program every 30 minutes. I chose to use systemD instead of a cronjob mostly beacuse I wanted
to get a bit more experience working with systemD units.

Installation & configuration is incredibly simple:

### Configure the script

Edit the domain, list of hostnames and password in the script. The domain is your domain, the hostnames are the subdomains for your domain. I've included `@` and `www`, as these indicate `yourdomain.tld` and `www.yourdomain.tld`, respectively.

The password is not your login password, [here are instructions](https://www.namecheap.com/support/knowledgebase/article.aspx/595/11/how-do-i-enable-dynamic-dns-for-a-domain) for finding it.


### Configure the service units

First, edit `NCUpdate.service` so that its fields are correct. In particular, be sure that the
`User`, `WorkingDirectory` and `ExecStart` fields are set to the proper values. I find that absolute paths
tend to prevent a lot of headaches, so be sure to use them for `WorkingDirectory` and `ExecStart`, where the former is the directory where the script is located, and the latter the script itself.

Next, setup the service units.

	# Copy service units 
    sudo cp NCUpdate.service NCUpdate.timer /etc/systemd/system
    
    # Load, enable, and  then start them
    sudo systemctl daemon-reload
    sudo systemctl enable NCUpdate.service NCUpdate.timer
    sudo systemctl start NCUpdate.service NCUpdate.timer

Verify that they are both running without any issues:

    sudo systemctl status NCUpdate.service
    sudo systemctl status NCUpdate.timer


In order to ease the use of the script, I hardcoded the password into the script, so be sure to 
change permissions on the file:

    chmod 700 NCUpdate.sh
    
And that's it!    