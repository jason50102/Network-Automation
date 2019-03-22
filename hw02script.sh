#!/bin/sh
# /home/tdc484/tdc484s18/hw02/hw02script.sh
# Author: Jason_Wu
# Date: 01/17/2018
# Description: compute the round trip delay with various packets
# Usage: hw02script.sh <no command line arguments>

#loop all target machines

HOSTLIST="140.192.40.4 192.168.1.16 100.1.1.15 192.168.2.15 192.168.20.23 10.1.1.1 10.1.1.2 10.1.1.3"

SIZELIST="64 128 256 512 1024 1280 1472 3000"

printf "IP Address%-5s Packet Size%-3s RTT%-4s Standard Deviation%-5s\n"
echo "-------------------------------------------------------------"

for IP in $HOSTLIST
do
   for SIZE in $SIZELIST
   do
	RESULT=`/usr/local/bin/supercmd ping -f -c 100 -s $SIZE $IP | fgrep rtt | cut -d" " -f4`
	RTT=`echo $RESULT | cut -d"/" -f2`
	SD=`echo $RESULT | cut -d"/" -f4`
	
	if [[ $RESULT = "" ]] #for unreachable targets
	then 
	    echo "Fail to reach the target host: $IP"
	    break
	else
	    printf "%-18s %5d  %10.3f %10.3f\n" $IP $SIZE $RTT $SD #reachable targets
        fi
   done
done

