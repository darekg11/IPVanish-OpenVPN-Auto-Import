#!/bin/bash

#Your IP-Vanish username
USERNAME="your-ip-vanish-login"

#Your IP-Vanish password (not used now, see reason below)
PASSWORD="your-ip-vanish-password"

#IP-Vanish CERT File.
CERT="ca.ipvanish.com.crt"

CERT_LOCATION_ABSOLUTE="$PWD/$CERT"

for i in imports/*.ovpn; do
    [ -f "$i" ] || break
	#Connection name for each OVPN is the file name without extension so just remove it
	CON_NAME=$(basename "$i")
	CON_NAME="${CON_NAME%.*}"
	#Import single OVPN configuration file
	nmcli connection import type openvpn file "$i"
	#Setup cert file localization
	nmcli connection modify "$CON_NAME" +vpn.data ca="$CERT_LOCATION_ABSOLUTE"
	#Setup username
	nmcli connection modify "$CON_NAME" +vpn.data username="$USERNAME"
	#Setup password
	#Unfortunately below command is failing from script, but works from terminal directly do not know why
	#nmcli connection modify "$CON_NAME" +vpn.secrets password="$PASSWORD"
	#All done
done