#!/bin/bash
clear
echo Installing Websocket-SSH Python
sleep 1
echo Sila Tunggu Sebentar...
sleep 0.5
cd
#Buat name user github dan nama folder
GitUser="Y16ZR"
namafolder="WEBSOCKET-PYTHON"
#wget https://github.com/${GitUser}/main/${namafolder}/

#System Websocket
cd
#System Websocket-Ovpn Service
cd /etc/systemd/system/
wget -O /etc/systemd/system/cdn-ovpn.service https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/cdn-ovpn.service
#System Websocket-Http
cd /etc/systemd/system/
wget -O /etc/systemd/system/ws-http.service https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/ws-http.service
#system ws Https
cd /etc/systemd/system/
wget -O /etc/systemd/system/ws-https.service https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/ws-https.service


#Install ws-OpenVPN
wget -q -O /usr/local/bin/cdn-ovpn https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/cdn-ovpn.py
chmod +x /usr/local/bin/cdn-ovpn
#Install ws http
wget -q -O /usr/local/bin/ws-http https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/ws-http.py
chmod +x /usr/local/bin/cdn-dropbear
#install ws https
wget -q -O /usr/local/bin/ws-https https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/${namafolder}/ws-https.py
chmod +x /usr/local/bin/cdn-dropbear

#Enable & Start & Restart Doxou-ovpn service
systemctl daemon-reload
systemctl enable cdn-ovpn
systemctl start cdn-ovpn
systemctl restart cdn-ovpn

#Enable & Start & Restart ws-http service
systemctl daemon-reload
systemctl enable ws-http
systemctl start ws-http
systemctl restart ws-http

#Enable & Start & Restart ws-https service
systemctl daemon-reload
systemctl enable ws-https
systemctl start ws-https
systemctl restart ws-https