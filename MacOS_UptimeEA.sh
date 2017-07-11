#!/bin/bash
##########################################

# Adds in Strict mode for easier debugging
# and error limitations
set -euo pipefail
IFS=$'\n\t'


## Variables #############################
# gets current date in epoch
currDate=$(date "+%s") 
# uses sysctl to get the boottime listed, awk and sed to clean up
bootDate=$(/usr/sbin/sysctl -n kern.boottime  | awk '{print $4}' | sed 's/,//')


## Work Area #############################
uptimeEpoch=$(((currDate-bootDate)/86400))

echo "<result>$uptimeEpoch Days</result>"
exit 0