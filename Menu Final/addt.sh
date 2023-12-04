#!/bin/bash
COLOR1='\033[0;35m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
Repo="https://raw.githubusercontent.com/AutoFTbot/Tunnel/main/"

source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}            • CREATE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[0;41;36m           TROJAN ACCOUNT          \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			m-trojan
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

echo "#! ${user} ${exp} ${uuid}" >>/root/akun/trojan/.trojan.conf

# Link Trojan Akun
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bugkamu.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"

cat >/var/www/html/trojan-$user.txt <<-END

# Format Trojan GO/WS

- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
        Host: ${domain}

# Format Trojan gRPC

- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc

-------------------------------------------------------
                  Link Akun Trojan 
-------------------------------------------------------
Link WS          : ${trojanlink}
-------------------------------------------------------
Link GRPC        : ${trojanlink1}
-------------------------------------------------------

END

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1│${NC}            • CREATE TROJAN USER •              ${NC} $COLOR1│$NC" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" | tee -a /root/akun/trojan/$user.txt
echo -e "Remarks          : ${user}" | tee -a /root/akun/trojan/$user.txt
echo -e "Host/IP          : ${domain}" | tee -a /root/akun/trojan/$user.txt
echo -e "port             : 443" | tee -a /root/akun/trojan/$user.txt
echo -e "Key              : ${uuid}" | tee -a /root/akun/trojan/$user.txt
echo -e "Path             : /trojan-ws" | tee -a /root/akun/trojan/$user.txt
echo -e "ServiceName      : trojan-grpc" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" | tee -a /root/akun/trojan/$user.txt
echo -e "Link WS          : ${trojanlink}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" | tee -a /root/akun/trojan/$user.txt
echo -e "Link GRPC        : ${trojanlink1}" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" | tee -a /root/akun/trojan/$user.txt
echo -e "Expired On       : $exp" | tee -a /root/akun/trojan/$user.txt
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" | tee -a /root/akun/trojan/$user.txt
echo "" | tee -a /root/akun/trojan/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
