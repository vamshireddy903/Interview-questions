#!/bin/bash

THRESHOLD=25
Disk_size=$(df -h | grep '/dev/root' | awk '{print $5}' | cut -d '%' -f1)
Email="vamsir673@gmail.com"

if [ "$Disk_size" -gt "$THRESHOLD" ]; then
    echo -e "⚠️ Disk space alert on / (root filesystem)\n\nThe root (/) partition is critical because it contains the operating system and essential services. If it runs out of space, the server may stop functioning properly.\n\nCurrent usage: ${Disk_size}%\nThreshold: ${THRESHOLD}%\n\nPlease take action to free up space.\n\n-- Automated Alert" \
    | mail -s "Disk alert on $(hostname)" "$Email"

    if [ $? -eq 0 ]; then
        echo "Mail sent successfully ✅"
    else
        echo "Mail sending failed ❌"
    fi
else
    echo "Disk space is available: (${Disk_size}%)"
fi
