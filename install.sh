#!/bin/bash

set -e


GATEWAY_EUI_NIC=$(ip -oneline link show up 2>&1 | grep -v LOOPBACK | sed -E 's/^[0-9]+: ([0-9a-z]+): .*/\1/' | head -1)
if [[ -z $GATEWAY_EUI_NIC ]]; then
    echo "ERROR: No network interface found. Cannot set gateway ID."
    exit 1
fi

GATEWAY_EUI=$(cat /sys/class/net/$GATEWAY_EUI_NIC/address | awk -F\: '{print $1$2$3"FFFE"$4$5$6}')
GATEWAY_EUI=${GATEWAY_EUI^^}


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

popd

LOCAL_CONFIG_FILE=$INSTALL_DIR/packet_forwarder/lora_pkt_fwd/local_conf.json

echo -e "{\"gateway_conf\":{\"gateway_ID\":\"$GATEWAY_EUI\",\"server_address\":\"console.clodpi.io\",\"serv_port_up\":1700,\"serv_port_down\":1700,\"keepalive_interval\":10,\"stat_interval\":30,\"push_timeout_ms\":100,\"forward_crc_valid\":true,\"forward_crc_error\":false,\"forward_crc_disabled\":false}}" >$LOCAL_CONFIG_FILE

cp files/global_conf.json $INSTALL_DIR/packet_forwarder/lora_pkt_fwd/global_conf.json
install -m 755 files/start.sh /opt/semtech/packet_forwarder/lora_pkt_fwd
#install -m 644 files/local_conf.json   ${ROOTFS_DIR}/opt/semtech/packet_forwarder/lora_pkt_fwd
install -m 644 files/packet-forwarder.service   ${ROOTFS_DIR}/lib/systemd/system/


systemctl enable packet-forwarder

echo "LoRaWAN Gateway EUI : $GATEWAY_EUI"

echo "The system will reboot in 5 seconds..."
sleep 5
shutdown -r now
