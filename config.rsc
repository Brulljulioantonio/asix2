# Configuracion base MikroTik
# WAN: ether3 (DHCP client) | LAN: ether4 (192.168.27.0/24)
# Se puede ejecutar varias veces sin duplicar reglas.

# Cliente DHCP en WAN (solo si no existe ya)
:if ([:len [/ip dhcp-client find interface=ether3]] = 0) do={
  /ip dhcp-client add interface=ether3 disabled=no add-default-route=yes use-peer-dns=yes
}

# IP de la LAN (solo si no existe ya)
:if ([:len [/ip address find interface=ether4 address="192.168.27.1/24"]] = 0) do={
  /ip address add address=192.168.27.1/24 interface=ether4 comment="LAN"
}

# NAT de la LAN (solo si no existe ya)
:if ([:len [/ip firewall nat find comment="NAT LAN"]] = 0) do={
  /ip firewall nat add chain=srcnat out-interface=ether3 action=masquerade comment="NAT LAN"
}
