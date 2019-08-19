# Automatic OpenVPN configs import for IPVanish on Linux

**How to run**:  
1. `git clone` this repository
2. `sudo su` in order to run `apt install` and script as root
3. `apt-get install network-manager-openvpn
` in order to install NetworkManager for OpenVPN
4. `apt-get install network-manager-openvpn-gnome` - installing only `network-manager-openvpn` did not allow me to import configuration from file
5. Edit your username in `import-vpn-connections.sh` script file
6. `chmod +x import-vpn-connections.sh`
7. `./import-vpn-connections.sh` to execute script
8. Wait... (depends on number of files to import, for all of them it took around 1 hour)  
If you do not need to import all of configs, just remove the ones you do not need from `imports` directory  
9. Done, you should now see list of imported VPN connections in your Network Manager

**Limitations:**  
1. Unfortunately setting password via:  
`nmcli connection modify "$CON_NAME" +vpn.secrets password="$PASSWORD"` does not work (does not set `vpn.secrets` property on connection) when executed from script and I could not find solution for this issue. It is working correctly when executed in terminal window so no clue what might be wrong here.  
Because of that first time connection to any of imported VPNs will prompt for your IPVanish password, after that it will work without password for every next connection.  
**If anybody have idea for this, please do Pull Request or write an issue**

**Fixing DNS Leak on Ubuntu 18.04:**  
1. Do everything as told in: https://github.com/jonathanio/update-systemd-resolved
2. Connect to your VPN via: `sudo openvpn --config ipvanish-NL-Amsterdam-ams-a04.ovpn`
3. In new terminal execute: `systemd-resolve --status`
4. Find Index of Link of your interface that is used to communicate with your router / ISP, let's assume it's `Link 3`
5. Execute: `sudo busctl call org.freedesktop.resolve1 /org/freedesktop/resolve1 org.freedesktop.resolve1.Manager SetLinkDNS 'ia(iay)' 3 0` - **NOTICE 3** - THIS WILL ERASE DNS SERVERS FROM YOUR INTERFCE FIXING THE DAMN DNSLEAK
6. Test out for leaks
7. Be happy.
8. After closing VPN connection make sure to restart Network Manager in order to get that DNS Server back, otherwise your requests won't hit any DNS server: `sudo service network-manager restart`
