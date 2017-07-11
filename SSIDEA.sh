#!/bin/bash
#
############
#
# Wifi Connection Extension Attribute
# Displays SSID of connected network
#
############

# Lets create some variables to keep this clean
SSID=`airport -I | grep " SSID" | cut -d ":" -f2`
AirportState=`airport -I | grep "state" | cut -d ":" -f2`


# If statement to see if Airport is running
if [ $AirportState == running ];
	then 
	echo "<result>$SSID</result>"

else
	echo "No Wifi Connection Found"

fi