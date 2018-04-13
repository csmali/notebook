#!/bin/sh

# Usage ./ping_subnet.sh 192.168.1
 
COUNTER=1
myvariable=$1

while [ $COUNTER -lt 254 ]
do
   if timeout 0.2 ping $myvariable.$COUNTER -c 1  | grep "bytes from" > /dev/null ; then
	echo "$myvariable.$COUNTER is up!"
   else
	echo "$myvariable.$COUNTER seems down!"
   fi
   COUNTER=$(( $COUNTER + 1 ))
done
