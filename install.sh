#!/bin/bash

set -e
INSTALL_DIR="/opt/semtech"

rm -rf $INSTALL_DIR

mkdir -p $INSTALL_DIR
pushd $INSTALL_DIR
git clone -v https://github.com/Lora-net/lora_gateway.git
git clone -v https://github.com/Lora-net/packet_forwarder.git

pushd $INSTALL_DIR/lora_gateway && make all
popd
pushd $INSTALL_DIR/packet_forwarder && make all
popd

#cd /opt/semtech/lora_gateway && make all
#cd /opt/semtech/packet_forwarder && make all
popd
pwd
install -m 755 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/start.sh /opt/semtech/packet_forwarder/lora_pkt_fwd
#install -m 644 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/global_conf.json   ${ROOTFS_DIR}/opt/semtech/packet_forwarder/lora_pkt_fwd
install -m 644 /home/pi/loraserver-pi-gen/stage3/02-packet-forwarder/files/packet-forwarder.service   ${ROOTFS_DIR}/lib/systemd/system/


#systemctl enable packet-forwarder
