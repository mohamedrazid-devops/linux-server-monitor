#!/bin/bash


# Check required commands
for cmd in top free df awk bc systemctl ps; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "ERROR: Required command '$cmd' is not available."
        exit 1
    fi
done
echo ""
echo "========== MONITORING START: $(date '+%Y-%m-%d %H:%M:%S') =========="
echo "========== LINUX SERVER MONITOR =========="
echo "User     : $(whoami)"
echo "Hostname : $(hostname)"
echo "Uptime   : $(uptime -p)"
echo "Date     : $(date)"

echo "---------- RESOURCE USAGE ----------"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage : $CPU%"

if (( $(echo "$CPU >= 80" | bc -l) )); then
    echo "WARNING: CPU usage is HIGH!"
else
    echo "CPU Status : Normal"
fi

RAM=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2)*100}')
echo "RAM Usage : $RAM%"

if (( $(echo "$RAM >= 80" | bc -l) )); then
    echo "WARNING: RAM usage is HIGH!"
else
    echo "RAM Status : Normal"
fi

DISK=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage : $DISK"

DISK_NUM=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_NUM" -ge 80 ]; then
    echo "WARNING: Disk usage is HIGH!"
else
    echo "Disk Status : Normal"
fi

echo "---------- SERVICE STATUS ----------"

SSH_STATUS=$(systemctl is-active ssh)

if [ "$SSH_STATUS" = "active" ]; then
    echo "SSH Service : Running"
else
    echo "WARNING: SSH Service is NOT running!"
fi

echo "---------- SERVICE MONITORING ----------"

SSH_STATUS=$(systemctl is-active ssh)
CRON_STATUS=$(systemctl is-active cron)

if [ "$SSH_STATUS" = "active" ]; then
    echo "SSH  Service : Running"
else
    echo "WARNING: SSH Service is NOT running!"
fi

if [ "$CRON_STATUS" = "active" ]; then
    echo "Cron Service : Running"
else
    echo "WARNING: Cron Service is NOT running!"
fi

echo "---------- TOP PROCESSES ----------"

echo "High CPU Processes:"
ps aux --sort=-%cpu | head -4

echo "High Memory Processes:"
ps aux --sort=-%mem | head -4

echo "=========================================="
