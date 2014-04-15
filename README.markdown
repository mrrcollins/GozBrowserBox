# GozBrowserBox

GozBrowserBox is a set of scripts that will take an Ubuntu installation and set up a full screen browser box. It works very will with lower end machines and makes them more useful.

### INSTALLING GOZBROWSERBOX WILL TOTALLY WIPE OUT THE MACHINE IT IS BEING INSTALLED ON WITHOUT WARNING. USE AT YOUR OWN RISK!!!

# Prerequisites

* An older Intel machine that you want to use as a GozBrowserBox. I haven't tried it on machines with less than 512MB of RAM. Disk space is minimal. *THIS WILL TOTALLY WIPE THE HARD DRIVE WITHOUT WARNING. BE SURE THERE ISN'T ANYTHING ON THE MACHINE YOU WANT.*
* The Ubuntu Alternate CD or network installer from [Alternative downloads](http://www.ubuntu.com/download/desktop/alternative-downloads) for 12.04 (this will probably work on other versions, but I can't think of a good reason not to just use 12.04)
* An Internet connection

# Installation

1. Boot off of the Alternate or Network Installer media
2. At the select language prompt, hit the **ESC** key twice, then click *OK*.
3. You will now be looking at a boot prompt. You will want to type this exactly:

 ```
 boot: install url=mrrcollins.github.com/GozBrowserBox/lgbb.cfg
 ```
 
4. The Ubuntu installation will start up and ask you a few questions, answer them. :-)
5. After you set up an administrative user, it will automatically erase and re-partition the hard drive and set it up. Let me repeat that IT WILL AUTOMATICALLY ERASE AND RE-PARTITION THE HARD DRIVE. You've been warned.
6. It will install and reboot. After the login screen flashes, click the login button with the *Browser* user selected.
7. If Google Chrome launches, you're golden!
 
# Security concerns
 
By using the preseed file from my repo, you are basically trusting me with your entire machine. I would recommend forking the repo and using your fork if this makes you uncomfortable. Your machine will also grab the config from Github and use Puppet to apply the changes everytime you start the machine. Basically, I have full control of your machine even after the install. &lt;Insert evil laugh :-)&gt;

# Future

* Write up directions for forking the repo for security!!
* Add the GozBrowserBox Server config and GozBrowserBox Remote config. This will allow you to run Google Chrome on very underpowered machines and PowerPC machines (old Macs) with Flash and sound.
