#!/bin/bash
#By EZ-Code
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript Premium By EZ-Code"
echo "Please input link to your vps data backup file."
echo "You can check it on your email if you run backup data vps before."
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp -r wireguard /etc/
cp ss.conf /etc/shadowsocks-libev/ss.conf
cp -r premium-script /var/lib/
cp -r xray /usr/local/etc/
cp -r shadowsocksr /usr/local/
cp -r public_html /home/vps/
strt
rm -rf /root/backup
rm -f backup.zip
echo Done
echo ""
echo -e "             \033[1;33mRESTORE DATA VPS COMPLETED!\033[0m          "
echo ""
echo ""
echo ""
echo -e "${red}Auto reboot in 3 seconds...${NC}"
echo ""
sleep 3
reboot
