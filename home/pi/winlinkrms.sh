#!/bin/bash
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
trap ctrl_c TERM
function ctrl_c() {
   echo "CTRL-C pressed, killing direwolf in winlinke mode"
   sudo killall direwolf
   sudo killall kissattach
   sudo killall ax25d
   exit 0
}



sudo systemctl stop digipeater
sudo killall kissattach
./direwolf.winlink.sh &
sleep 5
sudo kissattach /tmp/kisstnc radio 44.56.4.222
sudo kissparms -c 1 -p radio  # fix invalid port first to tries on direwolf
sudo ax25d  # for rmsgw only

sleep 10000000000
