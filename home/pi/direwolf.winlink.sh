

#start direwolf in background
#use different conf file if HF radio plugged in (different ADEVICE)
HFPRESENT=`cat /proc/asound/cards | grep "Burr-Brown" | wc -l`

if [ $HFPRESENT -eq 0 ]; then
  direwolf   -d t  -p  -q d -t 0 -c /home/pi/direwolf.winlink.conf    | tee /home/pi/direwolf.log &
else
  sudo systemctl start rigctld
  direwolf   -d t  -p  -q d -t 0 -c /home/pi/direwolf.winlink-hf.conf | tee /home/pi/direwolf.log &
fi


#direwolf   -d t  -p   -q d -t 0 -c /home/pi/direwolf.winlink.conf | tee /home/pi/direwolf.log

# descriminator output of radioshack is through 120K (100+20).


exit 0

