#!/bin/bash
# By V-Code
# ==================================================
#wget https://github.com/${GitUser}/
GitUser="Y16ZR"
# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#DETAIL NAMA PERUSAHAAN
country="MY"
state="Sabah"
locality="Kota Kinabalu"
organization="@EzcodeShop"
organizationalunit="@EzcodeShop"
commonname="EZ-Code"
email="admin@ez-code.xyz"

echo -e "[ \e[32;1mINFO\e[0m ] DOWLOADING REQUIREMENTS TOOLS . . ."
#INSTALL REQUIREMENTS TOOLS
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y

#SIMPLE PASSWORD MINIMAL
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/password"
chmod +x /etc/pam.d/common-password

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION RC-LOCAL SERVICE . . ."
#GO TO ROOT
cd

#EDIT FILE /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

cd /etc
mv rc.local rc.local.bkp
# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT 
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
cd /etc/slowdns && ./startdns.sh
exit 0
END
#UBAH IZIN AKSES
chmod +x /etc/rc.local
# enable rc local
systemctl enable rc-local
systemctl start rc-local
systemctl start rc-local.service

#DISABLE IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#UPDATE
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#INSTALL WGET AND CURL
apt -y install wget curl

apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof

#SET TIME GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

#SET LOCALE
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION WEBSERVE NGINX . . ."

#INSTALL WEBSERVER NGINX
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/vps.conf"
/etc/init.d/nginx restart
clear

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION BADVPN . . ."
#INSTALL BADVPN
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

apt-get -y update

echo -e "[ \e[32;1mINFO\e[0m ] SETUP PORT SSH . . ."
#SETTING PORT SSH
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 81' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 666' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 22' /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo -e "[ \e[32;1mINFO\e[0m ] SETUP PORT DROPBEAR . . ."

#INSTALL DROPBEAR
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

cd
# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 222
connect = 127.0.0.1:22

[dropbear]
accept = 777
connect = 127.0.0.1:109

[ws-stunnel]
accept = 2096
connect = 700

[openvpn]
accept = 442
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel4
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/lib/systemd/systemd-sysv-install enable stunnel4
systemctl start stunnel4
/etc/init.d/stunnel4 restart




echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION SQUID . . ."

#INSTALL SQUID FOR DEBIAN 9,10 & UBUNTU 20.04
apt -y install squid3

#INSTALL SQUID FOR DEBIAN 11
apt -y install squid

wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

#SETTING VNSTAT
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION OPENVPN . . ."

#OPENVPN
wget https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

#INSTALL FAIL2BAN
apt -y install fail2ban

#INSTAL DDOS FLATE
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION BANNER SSH . . ."

#BANNER /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/BANNER/bannerssh.conf"

echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION BBR . . ."

#INSTALL BBR
wget https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/bbr.sh && chmod +x bbr.sh && ./bbr.sh

#BLOCK TORRENT
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

echo -e "[ \e[32;1mINFO\e[0m ] DOWLOADING TOOLS SSH . . ."
#DOWNLOAD SCRIPT
cd /usr/bin
wget -O add-host "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/add-host.sh"
wget -O about "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/about.sh"
wget -O menu "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/menu.sh"
wget -O menu-br "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MENU/menu-br.sh"
wget -O add-ssh "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/ADD-USER/add-ssh.sh"
wget -O trial "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial.sh"
wget -O del-ssh "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/DELETE-USER/del-ssh.sh"
wget -O member "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/DELETE-USER/delete.sh"
wget -O check-ssh "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHECK-USER/check-ssh.sh"
wget -O restart "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/info.sh"
wget -O ram "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/ram.sh"
wget -O renew-ssh "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/RENEW-USER/renew-ssh.sh"
wget -O autokill "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHECK-USER/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/clear-log.sh"
wget -O change-port "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-ssl.sh"
wget -O port-wg "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-wg.sh"
wget -O port-squid "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-squid.sh"
wget -O port-websocket "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-websocket.sh"
wget -O wbmn "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/xp.sh"
wget -O kernel-updt "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/kernel.sh"
wget -O user-list "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MORE-OPTION/user-list.sh"
wget -O user-lock "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MORE-OPTION/user-lock.sh"
wget -O user-unlock "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MORE-OPTION/user-unlock.sh"
wget -O user-password "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MORE-OPTION/user-password.sh"
wget -O antitorrent "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MORE-OPTION/antitorrent.sh"
wget -O cfa "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CLOUD/cfa.sh"
wget -O cfd "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CLOUD/cfd.sh"
wget -O cfp "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CLOUD/cfp.sh"
wget -O swap "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/swapkvm.sh"
wget -O check-sc "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/running.sh"
wget -O menu-ssh "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MENU/menu-ssh.sh"
wget -O autoreboot "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/autoreboot.sh"
wget -O port-ohp "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-ohp.sh"
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/CHANGE-PORT/port-xray.sh"
wget -O menu-domain "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/MENU/menu-domain.sh"
wget -O add-ns "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/add-ns.sh"
wget -O script-update "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/script-updatessh.sh"
chmod +x add-host
chmod +x menu
chmod +x menu-br
chmod +x menu-domain
chmod +x add-ssh
chmod +x trial
chmod +x del-ssh
chmod +x member
chmod +x delete
chmod +x check-ssh
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew-ssh
chmod +x clear-log
chmod +x change-port
chmod +x restore
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-squid
chmod +x port-websocket
chmod +x wbmn
chmod +x xp
chmod +x kernel-updt
chmod +x user-list
chmod +x user-lock
chmod +x user-unlock
chmod +x user-password
chmod +x antitorrent
chmod +x cfa
chmod +x cfd
chmod +x cfp
chmod +x swap
chmod +x check-sc
chmod +x menu-ssh
chmod +x autoreboot
chmod +x port-ohp
chmod +x port-xray
chmod +x menu-domain
chmod +x add-ns
chmod +x script-update
echo "0 5 * * * root clear-log" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
echo "0 0 * * * root delete" >> /etc/crontab
# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/vnstat restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile
echo "clear" >> .profile
echo "menu" >> .profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finihsing
clear
