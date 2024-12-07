#!/bin/bash
#wget https://github.com/${GitUser}/
clear
GitUser="Official-VCode"
MYIP=$(curl -sS ipv4.icanhazip.com)
#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'
clear
echo ""
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;34mLoading menu\033[1;36m- \033[1;34m["
while true; do
   for((i=0; i<2; i++)); do
   echo -ne "\033[1;36m#"
   sleep 2s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim & break
   echo -e "\033[1;34m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;34mWait \033[1;34m- \033[1;34m["
done
echo -e "\033[1;34m]\033[1;36m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

clear
# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Active)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))
clear
#NAMA ISP
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
#TARIKH EXP
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
exp=$(cat /usr/bin/e)
# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
Tipe=$NAME
COUNTRY=$( curl -s ipinfo.io/country )
CITY=$( curl -s ipinfo.io/city )
# Getting Domain Name
Domen="$(cat /usr/local/etc/xray/domain)"
clear
# Status SSH
statusssh="$(systemctl show ssh.service --no-page)"
status_textssh=$(echo "${statusssh}" | grep 'ActiveState=' | cut -f2 -d=)
ONSSH="\e[0;32mON\e[0m"
OFFSSH="\e[0;31mOFF\e[0m"
if [ "${status_textssh}" == "active" ]                           
then
ssh=$ONSSH
else
ssh=$OFFSSH
fi
clear
#STATUS OVPN
statusovpn="$(systemctl show --now openvpn-server@server-tcp-1194 --no-page)"
status_textovpn=$(echo "${statusovpn}" | grep 'ActiveState=' | cut -f2 -d=)
ONOVPN="\e[0;32mON\e[0m"
OFFOVPN="\e[0;31mOFF\e[0m"
if [ "${status_textovpn}" == "active" ]                           
then
ovpn=$ONOVPN
else
ovpn=$OFFOVPN
fi
echo -e "$NC"
#status xray
statusxray="$(systemctl show xray.service --no-page)"
status_textxray=$(echo "${statusxray}" | grep 'ActiveState=' | cut -f2 -d=)
ONXRAY="\e[0;32mON\e[0m"
OFFXRAY="\e[0;31mOFF\e[0m"
if [ "${status_textxray}" == "active" ]                           
then
xray=$ONXRAY
else
xray=$OFFXRAY
fi
clear
#status shadowsocks
statusss="$(systemctl show shadowsocks-libev.service --no-page)"
status_textss=$(echo "${statusss}" | grep 'ActiveState=' | cut -f2 -d=)
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"
if [ "${status_textss}" == "active" ]                           
then
ss=$ONSS
else
ss=$OFFSS
fi
clear
#JUMLAH SSH
if [ -f /etc/debian_version ]; then
	UIDN=1000
elif [ -f /etc/redhat-release ]; then
	UIDN=500
else
	UIDN=500
fi
JUMLAHSSH="$(awk -F: '$3 >= '$UIDN' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
#JUMLAH VMESS WS
JUMLAHVMESSWS=$(grep -c -E "^#vms " "/usr/local/etc/xray/config.json")
#JUMLAHVMESSWS
JUMLAHVLESSWS=$(grep -c -E "^#vls " "/usr/local/etc/xray/config.json")
#JUMLAH VLESS XTLS
JUMLAHVLESSXTLS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
#JUMLAH TROJAN WS
JUMLAHTROJANWS=$(grep -c -E "^### " "/usr/local/etc/xray/akuntrws.conf")
#JUMLAH TROJAN GRPC TLS$NC
JUMLAHTROJANGRPC=$(grep -c -E "^### " "/usr/local/etc/xray/akunxtrgrpc.conf")
#JUMLAH WIREGUARD
source /etc/wireguard/params
JUMLAHWG=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")
#JUMLAHSSH
JUMLAHSS=$(grep -c -E "^### " "/etc/shadowsocks-libev/akun.conf")

clear
echo ""
echo -e   " \e[0;34m ════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[0;34m ║\e[104m                \e[97m WELCOME TO PREMIUM SCRIPT \e[1m               \e[m\e[0;34m║"
echo -e   " \e[0;34m ╔══════════════════════════════════════════════════════════╗\e[m"
echo -e "  \e[0;34m║       ${white}Created By ${red}EZ-Code${NC} (${blue}https://t.me/EzcodeShop${NC})"
echo -e "  \e[0;34m║"
echo -e "  \e[0;34m║  \e[0;94mISP           \e[0;34m=\e[0;94m $NAMAISP       "
echo -e "  \e[0;34m║  \e[0;94mOS            \e[0;34m=\e[0;94m $NAME $Versi_OS"
echo -e "  \e[0;34m║  \e[0;94mCITY          \e[0;34m=\e[0;94m $CITY ($COUNTRY)"
echo -e "  \e[0;34m║  \e[0;94mIP VPS        \e[0;34m=\e[0;94m $MYIP           "
echo -e "  \e[0;34m║  \e[0;94mDOMAIN        \e[0;34m=\e[0;94m $Domen          "
echo -e "  \e[0;34m║  \e[0;94mEXPIRY SCRIPT \e[0;34m=\e[0;97m $exp ${green} ($certifacate days)"
echo -e "  \e[0;34m║  \e[0;94mEXPIRY STATUS \e[0;34m=\e[0;94m $sts "
echo -e "  \e[0;34m╚══════════════════════════════════════════════════════════╝\e[m"
echo ""
echo -e "        \e[0;94mSSH : $ssh   \e[0;94mOVPN : $ovpn   \e[0;94mXRAY : $xray   \e[0;94mSS : $xray"
echo -e "       $green——————————$blue———————————————$cyan————————————$yellow—————————――$NC"
echo -e "  \e[0;34m┏━━━━━━━━━━━━━━━━[ \e[0;33mCONTROLL PANEL MENU\e[m \e[0;34m]━━━━━━━━━━━━━━━━━━━┓"
echo -e "  \e[0;34m┃                                                          ┃"
echo -e "      $green[${white}•1${green}] ${white}SSH/OPENVPN$NC          $green[${white}•5${green}] ${white}XRAY VMESS/VLESS WS$NC"
echo -e "      $green[${white}•2${green}] ${white}WIREGUARD$NC            $green[${white}•6${green}] ${white}XRAY VLESS TCP XTLS$NC"
echo -e "      $green[${white}•3${green}] ${white}SHADOWSOCKS$NC          $green[${white}•7${green}] ${white}XRAY TROJAN WEBSOCKET$NC"
echo -e "      $green[${white}•4${green}] ${white}SHADOWSOCK-R$NC         $green[${white}•8${green}] ${white}XRAY TROJAN GRPC TLS$NC"
echo -e "  \e[0;34m┃                                                          ┃"
echo -e "  \e[0;34m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "  ┏       ${yellow}SYSTEM MENU             \e[0;34m┃$NC       ${yellow}TOTAL USER ${NC}        \e[0;34m┓"
echo -e "  \e[0;34m┃$NC      $green—————————————            \e[0;34m┃      ${green}————————————$NC        \e[0;34m┃"
echo -e "  \e[0;34m┃$NC$green[${white}•9${green}] ${white}RESTART ALL SERVICE       \e[0;34m┃$NC    SSH & OVPN $green   =$NC $yellow$JUMLAHSSH"
echo -e "  \e[0;34m┃$NC$green[${white}10${green}] ${white}SERVER AUTO-REBOOT        \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}11${green}] ${white}DOMAIN CLOUDFLARE         \e[0;34m┃$NC    VMESS WS $green     =$NC $yellow$JUMLAHVMESSWS "
echo -e "  \e[0;34m┃$NC$green[${white}12${green}] ${white}BACKUP/RESTORE SERVER     \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}13${green}] ${white}ADD/CHANGE DOMAIN SERVER  \e[0;34m┃$NC    VlESS WS $green     =$NC $yellow$JUMLAHVLESSWS "
echo -e "  \e[0;34m┃$NC$green[${white}14${green}] ${white}ADD/CHANGE NS(SLOW DNS)   \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}15${green}] ${white}RENEW CERTIFICATE XRAY    \e[0;34m┃$NC    VlESS XTLS $green   =$NC $yellow$JUMLAHVLESSXTLS"
echo -e "  \e[0;34m┃$NC$green[${white}16${green}] ${white}SHOW ALL PORT VPN         \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}17${green}] ${white}CHANGE PORT VPN           \e[0;34m┃$NC    TROJAN WS $green    =$NC $yellow$JUMLAHTROJANWS "
echo -e "  \e[0;34m┃$NC$green[${white}18${green}] ${white}SHOW RUNNING SCRIPT       \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}19${green}] ${white}CLEAR-LOG & CACHE         \e[0;34m┃$NC    TROJAN GRPC $green  =$NC $yellow$JUMLAHTROJANGRPC  "
echo -e "  \e[0;34m┃$NC$green[${white}20${green}] ${white}SHOW SERVER BANDWITH      \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}21${green}] ${white}CHANGE PASSWORD VPS       \e[0;34m┃$NC    WIREGUARD $green    =$NC $yellow$JUMLAHWG  "
echo -e "  \e[0;34m┃$NC$green[${white}22${green}] ${white}SHOW SPEEDTEST SERVER     \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}23${green}] ${white}UPDATE PREMIUM SCRIPT     \e[0;34m┃$NC    SHADOWSOCKS $green  =$NC $yellow$JUMLAHSS "
echo -e "  \e[0;34m┃$NC$green[${white}24${green}] ${white}REBOOT SERVER             \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m╔══════════════════════════════════════════════════════════╗\e[m"
echo -e "    $red[${white}0${red}] ${white}Exit from the menu ${blue}(${red}Ctrl + C${NC}${blue})$NC"
echo -e "  \e[0;34m╚══════════════════════════════════════════════════════════╝\e[m"
read -p "  $(echo -e ${yellow}         Enter Your Options  ${green}[${NC}${white}1-24 or x${green}]${NC} :)  "  main
echo -e ""
case $main in
1)
menu-ssh
;;
2)
menu-wg
;;
3)
menu-ss
;;
4)
menu-ssr
;;
5)
x-vmess
;;
6)
x-vless
;;
7)
x-tr
;;
8)
x-trojan
;;
9)
restart
;;
10)
autoreboot
;;
11)
menu-domain
;;
12)
menu-br
;;
13)
add-host
;;
14)
add-ns
;;
15)
cert
;;
16)
info
;;
17)
change-port
;;
18)
check-sc
;;
19)
clear-log
;;
20)
vnstat
;;
21)
passwd
;;
22)
speedtest
;;
23)
script-update
;;
24)
reboot
;;
X)
exit
;;
x)
exit
;;
0)
exit
;;
*)
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
menu
;;
esac