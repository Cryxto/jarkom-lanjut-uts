# nov/16/2023 16:06:04 by RouterOS 6.48.6
# software id = XF27-WJ41
#
# model = RB941-2nD
# serial number = A1C30BB18CA4
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.20.2-172.16.20.254
add name=dhcp_pool1 ranges=172.16.30.2-172.16.30.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=ether3 name=dhcp2
/ip address
add address=172.16.20.1/24 interface=ether2 network=172.16.20.0
add address=1.1.1.2/24 interface=ether4 network=1.1.1.0
add address=172.16.30.1/24 interface=ether3 network=172.16.30.0
/ip dhcp-client
add disabled=no interface=ether4
/ip dhcp-server network
add address=172.16.20.0/24 gateway=172.16.20.1
add address=172.16.30.0/24 gateway=172.16.30.1
/ip firewall nat
add action=masquerade chain=srcnat
add action=dst-nat chain=dstnat dst-address=1.1.1.2 dst-port=9000 protocol=\
    tcp to-addresses=172.16.20.254 to-ports=80
add action=dst-nat chain=dstnat dst-address=172.16.30.254 dst-port=8082 \
    protocol=tcp to-addresses=1.1.1.2 to-ports=9000
/routing ospf network
add area=backbone network=1.1.1.0/24
add area=backbone network=172.16.20.0/24
add area=backbone network=172.16.30.0/24
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=Kantor-A
