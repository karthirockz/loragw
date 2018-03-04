#!/bin/bash

set -e

rm -rf /opt/semtech
mkdir -p /opt/semtech
cd /opt/semtech && git clone -v https://github.com/Lora-net/lora_gateway.git
cd /opt/semtech && git clone -v https://github.com/Lora-net/packet_forwarder.git

cd /opt/semtech/lora_gateway && make all
cd /opt/semtech/packet_forwarder && make all


install -m 755 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/start.sh /opt/semtech/packet_forwarder/lora_pkt_fwd
#install -m 644 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/global_conf.json   ${ROOTFS_DIR}/opt/semtech/packet_forwarder/lora_pkt_fwd
install -m 644 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/packet-forwarder.service   ${ROOTFS_DIR}/lib/systemd/system/


systemctl enable packet-forwarder
