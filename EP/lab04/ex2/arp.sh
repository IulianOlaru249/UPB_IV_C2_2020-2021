#!/bin/bash
 
# localnet-ping.sh - performs differential ARP / ICMP scan
#   $1 : [required] interface name  
 
if [ "$#" -ne 1 ]; then
    echo "Usage: ./localnet-ping.sh wlo1"
    exit 1
fi
 
# generate list of IPs and hostnames in local network for given interface
localnet_hosts=$(sudo arp-scan                                      \
                    --interface=$1           `# scanned network`    \
                    --localnet               `# only local network` \
                | head -n -3                 `# hide footer lines`  \
                | tail -n +3                 `# hide header lines`  \
                | awk '{$2=""; print $0}'    `# hide MAC address`   \
                )
 
# process generated list, one item at a time
while read -r it; do
    # separate IP from hostname
    current_ip=$(awk '{print $1}' <<< $it)
    current_host=$(awk '{$1=""; print $0}' <<< $it)
 
    printf '\033[1;33m%15s   %-35s \033[0;33m==>  \033[0m' \
        $current_ip "$current_host"
 
    # ping current host
    ping -c 1           `# only one ping` \
         -W 1           `# 1s timeout`    \
         $current_ip    `# target host`   \
         1>/dev/null 2>&1
 
    # evaluate ping success
    if [ $? -eq 0 ]; then
        printf '\033[1;32mok\n\033[0m'
    else
        printf '\033[1;31mfail\n\033[0m'
    fi
done <<< "$localnet_hosts"

