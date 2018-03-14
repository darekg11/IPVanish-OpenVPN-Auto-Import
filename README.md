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