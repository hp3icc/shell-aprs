sudo mkdir /opt/shell-aprs

cat > /lib/systemd/system/aprsb1.service  <<- "EOF"
[Unit]
Description=APRS BEACOM1
After=syslog.target network.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/opt/shell-aprs/bcom1.sh

[Install]
WantedBy=multi-user.target
EOF
#
cat > /opt/shell-aprs/bcom1.sh  <<- "EOF"

#!/bin/bash
###### shellbeacon 1.0 A simple SHELL APRS Auto Beacon by WA1GOV
###### Works with Linux & Windows/Cygwin with netcat package installed
######
## Change the following variables to select your call, password, locaton etc.

callsign="HP3ICC-10" # Change this to your callsign-ssid
password="19384" # See http://apps.magicbug.co.uk/passcode/
position="!0831.27N/08021.59Wr" # See position report below
serverHost="noam.aprs2.net" # See http://www.aprs2.net/APRServe2.txt
comment="APRS BEACOM emq-TE1 / Raspbian Proyect by hp3icc"

serverPort=14580 # Definable Filter Port
delay=1800 # default 30 minutes
address="${callsign}>APRS,TCPIP:"

# POSITION REPORT: The first character determines the position report format
#          !4151.29N/07100.40W-
# A ! indicates that there is no APRS messaging capability
#
# The last character determines the icon to be used
#          !4151.29N/07100.40W-
# A dash will display a house icon
# Find your Lat/Long from your mailing address at the link below
# http://stevemorse.org/jcal/latlon.php
# Enter your callsign-ssid on https://aprs.fi/ to check your location

login="user $callsign pass $password vers ShellBeacon emqTE1 1.0"
packet="${address}${position}${comment}"
echo "$packet" # prints the packet being sent
echo "${#comment}" # prints the length of the comment part of the packet

while true
do
#### use here-document to feed packets into netcat
	nc -C $serverHost $serverPort -q 10 <<-END
	$login
	$packet
	END
	if [ "$1" = "1" ]
	then 
	    exit
	fi
	sleep $delay
done
EOF
#
cp /lib/systemd/system/aprsb1.service /lib/systemd/system/aprsb2.service
cp /lib/systemd/system/aprsb1.service /lib/systemd/system/aprsb3.service
cp /opt/shell-aprs/bcom1.sh /opt/shell-aprs/bcom2.sh
cp /opt/shell-aprs/bcom1.sh /opt/shell-aprs/bcom3.sh


sudo sed -i "s/BEACOM1/BEACOM2/g"  /lib/systemd/system/aprsb2.service
sudo sed -i "s/BEACOM1/BEACOM3/g"  /lib/systemd/system/aprsb3.service
sudo sed -i "s/bcom1/bcom2/g"  /lib/systemd/system/aprsb2.service
sudo sed -i "s/bcom1/bcom3/g"  /lib/systemd/system/aprsb2.service

systemctl daemon-reload
sudo chmod +x /opt/shell-aprs/*

sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/shell-aprs/main/menu.sh)"
