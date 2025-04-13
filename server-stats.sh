#!/bin/bash

# failed login attempts
failed_attempts=$(sudo lastb | grep -v 'btmp begins')
if [[ -z $failed_attempts ]]; then
        echo "No failed logins"
else
        echo "Failed logins detected: $failed_attempts"
fi

# logged in users
logged_user=$(who | awk '!seen[$1]++ {printf$1}')
echo "Logged in users list: $logged_user"

# OS version checkup
echo "OS Info:"
cat /etc/os-release | sed -n '1,2p'

# uptime
uptime | sed -E 's/.*up +(.*), +[0-9]+ +users?, +load average: (.*)/uptime: \1 | load average: \2/'

# Set locale to ensure decimal points are used
export LC_ALL=C

echo "Server Performance Stats"
echo "--------------------------"

# 1. Total CPU Usage
cpu_usage=$(top -bn1 | awk '/%Cpu\(s\)/ {printf "%.2f%%", 100-$8}')
echo "1. Total CPU Usage: $cpu_usage"

# 2. Total Memory Usage
memory_info=$(free -m | awk '/Mem:/ {
    total=$2
    used=$3
    free=$4
    used_percent=(used/total)*100
    free_percent=(free/total)*100
    printf "Used: %dMB (%.2f%%), Free: %dMB (%.2f%%)", used, used_percent, free, free_percent}')
echo "2. Total Memory Usage: $memory_info"

# 3. Total Disk Usage
disk_info=$(df -h / | awk '$NF=="/" {
    split($5, a, "%")
    used_percent=a[1]
    free_percent=100-used_percent
    printf "Used: %sB (%.2f%%), Free: %sB (%.2f%%)", $3, used_percent, $4, free_percent}')
echo "3. Disk Usage: $disk_info"

# 4. Top 5 processes by CPU usage
echo "4. Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,%cpu,%mem,cmd --sort=-%cpu | head -n 6

# 5. Top 5 processes by Memory usage
echo "5. Top Processes by Memory Usage:"
ps -eo pid,ppid,%mem,%cpu,cmd --sort=-%mem | head -n 6
