
sudo bluetoothctl -a
scan on
devices
pair 60:45:CB:20:F4:96
trust 60:45:CB:20:F4:96
quit


vi /etc/bluetooth/rfcomm.conf 
rfcomm1 {
    # Automatically bind the device at startup
    bind yes;

   # Bluetooth address of the device
   #tablet       device 60:45:CB:20:F4:96;
   #raspberrypi  device B8:27:EB:99:D2:96;
   device 60:45:CB:20:F4:96;

    # RFCOMM channel for the connection
    channel 1;

    # Description of the connection
    comment "Packet Radio Bluetooth Connection";
}



rfcomm --raw watch /dev/rfcomm0 1 socat -d -d tcp4:127.0.0.1:8001 /dev/rfcomm0 
