#!/bin/bash

while true
do
    architecture=$(uname -a)
    physical_cpu=$(grep -c ^processor /proc/cpuinfo)
    virtual_cpu=$(grep "processor" /proc/cpuinfo | wc -l)
    mem_total=$(free -m | awk '/^Mem:/{print $2}')
    mem_used=$(free -m | awk '/^Mem:/{print $3}')
    mem_percentage=$(free | awk '/^Mem:/{printf("%.2f"), $3/$2*100}')
    disk_total=$(df -h | awk '$6=="/"{print $2}')
    disk_used=$(df -h | awk '$6=="/"{print $3}')
    disk_percentage=$(df -h | awk '$6=="/"{print $5}')
    cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
    last_reboot=$(who -b | awk '{print $3, $4}')
    lvm_status=$(sudo lvscan | grep ACTIVE | wc -l)
    connections=$(netstat -antp | grep ESTABLISHED | wc -l)
    user_count=$(who | wc -l)
    ipv4_address=$(ip addr show | grep 'inet ' | awk '{print $2}' | awk -F/ '{print $1}')
    mac_address=$(ip addr show | grep link/ether | awk '{print $2}')
    sudo_commands=$(cat /var/log/auth.log | grep sudo | grep COMMAND | wc -l)

    wall <<EOF
#Architecture: $architecture
#CPU physical: $physical_cpu
#vCPU: $virtual_cpu
#Memory Usage: $mem_used/$mem_total MB ($mem_percentage%)
#Disk Usage: $disk_used/$disk_total ($disk_percentage)
#CPU load: $cpu_load%
#Last boot: $last_reboot
#LVM use: $(if [ $lvm_status -eq 0 ]; then echo "no"; else echo "yes"; fi)
#Connections TCP: $connections ESTABLISHED
#User log: $user_count
#Network: IP $ipv4_address ($mac_address)
#Sudo: $sudo_commands cmd
EOF

    sleep 600 # Sleep for 10 minutes
done
