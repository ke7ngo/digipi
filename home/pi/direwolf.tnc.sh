#!/bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
trap ctrl_c TERM
function ctrl_c() {
   echo "CTRL-C pressed, killing direwolf in TNC mode"
   sudo killall direwolf
   sudo killall rfcomm
   sudo systemctl stop rigctld 
   exit 0
}



#start direwolf in background
#use different conf file if HF radio plugged in (different ADEVICE)
HFPRESENT=`cat /proc/asound/cards | grep "Burr-Brown" | wc -l`

if [ $HFPRESENT -eq 0 ]; then
  direwolf   -d t  -p   -q d -t 0 -c /home/pi/direwolf.tnc.conf | tee /home/pi/direwolf.log &
else
  sudo systemctl start rigctld
  direwolf   -d t  -p   -q d -t 0 -c /home/pi/direwolf.hftnc.conf | tee /home/pi/direwolf.log &
fi 

# wait for direwolf to open port 8001
sleep 5

# bind bluetooth serial port to direwolf's KISS interface on port 8001,  root access?
sudo rfcomm --raw watch /dev/rfcomm0 1 socat -d -d tcp4:127.0.0.1:8001 /dev/rfcomm0  > /tmp/rfcom.out 2>/tmp/rfcom.out

sleep 100000000000

exit 0
