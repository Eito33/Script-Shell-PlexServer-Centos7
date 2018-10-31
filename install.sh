#!/usr/bin/bash
#author : Gabin Rimbault
#
#Update/Upgrade
echo "Update & Upgrade System . . ."
sudo yum update && sudo yum upgrade

#Installing dependencies
echo "Install dependencies : "

echo "Install Wget - "
if [ -f /bin/wget ];
 then 
 	echo "Wget is already install"
 	sleep 5s
 else 
 	yum install wget;
 	echo "Success install"
 	sleep 5s
fi;

#Installation de plexmediaserver
echo "Install plexmediaserver"
echo "Download plexmediaserver"
cd /tmp
wget https://downloads.plex.tv/plex-media-server/1.13.8.5395-10d48da0d/plexmediaserver-1.13.8.5395-10d48da0d.x86_64.rpm
sleep 5s

if [ -f /bin/plexmediaserver ];
 then 
 	echo "Removing plexmediaserver for reinstallation"
 	yum remove plexmediaserver;
 	sleep 5s
 	echo "plexmediaserver has been uninstalled"
 	echo "New Install . . ."
 	rpm -i plexmediaserver-1.13.8.5395-10d48da0d.x86_64.rpm
 	echo "plexmediaserver has been successfully installed"
 	sleep 5s
 else 
 	echo "Installation of plexmediaserver"
 	rpm -i plexmediaserver-1.13.8.5395-10d48da0d.x86_64.rpm
 	echo "plexmediaserver has been successfully installed"
 	sleep 5s
fi;

#Configuration de plexmediaserver
echo "Launch and configuration of plexmediaserver"
echo "Start ..."
sudo systemctl start plexmediaserver.service
sleep 5s

echo "Enable ..."
sudo systemctl enable plexmediaserver.service
sleep 5s

echo "Check status:"
sudo systemctl status plexmediaserver
sleep 10s

#Configuration firewall
echo "Firewall adjustment"

cd /etc/firewalld/services/

if [ -e plexmediaserver.xml ];
 then 
 	echo "Deleting the existing file"
 	rm plexmediaserver.xml

 	echo "Download configuration file"
 	wget http://www.gabinrimbault.fr/opt/plexmediaserver.xml
 	echo "File created"
 	sleep 5s
 else 
 	echo "Download configuration file"
 	wget http://www.gabinrimbault.fr/opt/plexmediaserver.xml
 	echo "File created"
 	sleep 5s
fi;

#Rule assign to the firewall
echo "Configuration of the new firewall rules"
sudo firewall-cmd --add-service=plexmediaserver --permanent

echo "Restart Firewall ..."
sudo firewall-cmd --reload

echo "Check new rules : "
sudo firewall-cmd --list-all
sleep 10s

#create folder and assigning permissions for plex
echo "Creating the plexmediaserver folder in / opt"
sudo mkdir -p /opt/plexmedia/

echo "Assigning permissions"
sudo chown -R plex: /opt/plexmedia

echo "Finalization ..."
echo "Thank you for using this script"