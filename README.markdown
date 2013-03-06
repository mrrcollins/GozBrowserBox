# GozBrowserBox

GozBrowserBox is a set of scripts that will take an Ubuntu installation and set up a full screen browser box. It works very will with lower end machines and makes them more useful.

### INSTALLING GOZBROWSERBOX WILL TOTALLY WIPE OUT THE MACHINE IT IS BEING INSTALLED ON WITHOUT WARNING. USE AT YOUR OWN RISK!!!

# Prerequisites

* A machine that you want to use as a GozBrowserBox. For a stand alone machine it will need to be an Intel machine with at least 512MB of RAM. For a Browser Server it needs to be an Intel machine with plenty of RAM. The remote browser setup can be either Intel or PowerPC with at least 128MB of RAM. Disk space is minimal. *THIS WILL TOTALLY WIPE THE HARD DRIVE WITHOUT WARNING. BE SURE THERE ISN'T ANYTHING ON THE MACHINE YOU WANT.*
* The Ubuntu Alternate CD or network installer from [Alternative downloads](http://www.ubuntu.com/download/desktop/alternative-downloads) for 12.04 (this will probably work on other versions, but I can't think of a good reason not to just use 12.04)
* An Internet connection

# Installation

This will set up the current machine to boot into Chrome, be a Chrome server, or use Chrome as a remote browser.

1. Boot off of the Alternate or Network Installer media
2. At the select language prompt, hit the **ESC** key twice, then click *OK*.
3. You will now be looking at a boot prompt. You will want to type this exactly:

For a stand alone installation of only Chrome (This will set up the current machine to boot only into Chrome. The machine must be an Intel based machine and should have at least 512MB of RAM.) :
```
boot: install url=mrrcollins.github.com/GozBrowserBox/gbb.cfg hostname=myhostname
```
 
For an Intel machine that will act as a Chrome server to slower machines, start the hostname with *sb-*:
```
boot: install url=mrrcollins.github.com/GozBrowserBox/gbb.cfg hostname=sb-myhostname
```

For an Intel machine that will act as a remote Chrome browser that connects to a Chrome server, start the hostname with *rb-*:
```
boot: install url=mrrcollins.github.com/GozBrowserBox/gbb.cfg hostname=rb-myhostname
```

For a PowerPC machine that will act as a remote Chrome browser that connects to a Chrome server, start the hostname with *rb-* and use a different config file:
```
boot: install url=mrrcollins.github.com/GozBrowserBox/gbbppc.cfg hostname=rb-myhostname
```

4. The Ubuntu installation will start up and ask you a few questions, answer them. :-)
5. After you set up an administrative user, it will automatically erase and re-partition the hard drive and set it up. Let me repeat that IT WILL AUTOMATICALLY ERASE AND RE-PARTITION THE HARD DRIVE. You've been warned.
6. It will install and reboot. After the login screen flashes the setup is completed.

## Standalone installation

At this point, the standalone set is good to go, log in as the browser user with a blank password.

## Server installation

You will need to set up a static IP address for your server and either set up a DNS entry for a machine named *browser* or edit the client's /etc/hosts file with the server's IP address. 

To set a static IP address:
1. control-alt-F1 will switch you to a terminal window.
2. Log in with the admin user set up during installation (the default username is *gbbadmin*).
3. At the command line type:
```
sudo nano -w /etc/network/interfaces
```
4. Delete the following lines:
```
#NetworkManager#auto eth0
#NetworkManager#iface eth0 inet dhcp
```
and replace with:
```
auto eth0
iface eth0 inet static
        address x.x.x.x
        netmask x.x.x.x
        gateway x.x.x.x
        dns-nameservers x.x.x.x
```
Replace the Xs with the appropriate information for your network.

5. control-x to quit, it will ask you to save the file.
6. 
```
sudo reboot
```
To restart the machine and start using the new settings.

## Remote Browser installation
You will need to add an entry for the browser server on your network's domain name server. An example line for BIND would be:
```
browser                 IN      A       10.0.9.10
```

If you cannot add it to DNS, you can modify the client's /etc/hosts file:
1. control-alt-F1 will switch you to a terminal window.
2. Log in with the admin user set up during installation (the default username is *gbbadmin*).
3. At the command line type:
```
sudo nano -w /etc/hosts
```
4. Add a line at the bottom:
```
xx.xx.xx.xx     browser
```
Put the servers IP address in for the Xs.
5. control-x to exit and save your changes.
6. control-d to log out.
7. control-alt-F7 to switch back to the login screen, which should let you connect to the remote server.

# Security concerns
 
By using the preseed file from my repo, you are basically trusting me with your entire machine. I would recommend forking the repo and using your fork if this makes you uncomfortable. Your machine will also grab the config from Github and use Puppet to apply the changes everytime you start the machine. Basically, I have full control of your machine even after the install. &lt;Insert evil laugh :-)&gt;

# Future

* Write up directions for forking the repo for security!!
