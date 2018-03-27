
# Legacy Pocket Forwarder Setup   [clodpi.io](http://clodpi.io)

## Hardware
1) Get the raspberry pi 3 board and get a 8gb micro sd card ready with the raspbian software
2) Connect raspberry pi + pi adapter + RAK831 Gateway Module
3) Connect the raspberry pi to 5v 2amps power supply.

## Firmware setup

### Enable SPI
1) Run `sudo raspi-config`.
2) Use the down arrow to select `9 Advanced Options`
3) Arrow down to `A6 SPI`.
4) Select `yes` when it asks you to enable SPI,
5) Also select `yes` when it asks about automatically loading the kernel module.
6) Use the right arrow to select the `<Finish>` button. 
7) Select `yes` when it asks to reboot.

### Verify SPI
1) Run `ls /dev/*spi*` Should respond with `/dev/spidev0.0  /dev/spidev0.1`

### Install GIT
 `sudo apt-get update`
 
 `sudo apt-get upgrade`
 
 `sudo apt-get install git`

### Install Pocket forwarder

 `cd ~`
 
 `git clone https://github.com/clodpi/loragw.git`
 
 `cd ~/loragw`
 
 `sudo ./install.sh`
 
 Raspberry Pi will reboot after installation.
 
`sudo cat /opt/semtech/packet_forwarder/lora_pkt_fwd/local_conf.json` to get the gateway_ID (Gateway MAC)

 Proceed to https://console.clodpi.io to configure the Gateway

### Configire Pocket forwarder (if needed)
 Edit `local_conf.json` 
 
 `sudo nano /opt/semtech/packet_forwarder/lora_pkt_fwd/local_conf.json`


 Contact us : meetus@clodpi.io

