# 1. System Health Monitoring Script: 
Develop a script that monitors the health of a Linux system. It should check CPU usage, memory usage, disk space, and running processes. If any of these metrics exceed predefined thresholds (e.g., CPU usage > 80%), the script should send an alert to the console or a log file. 

[Script](https://github.com/vamshireddy903/Interview-questions/blob/main/Python-tasks/System_health_monitoring.py)

# Prerequisites:

# 1️⃣ Python 3 installed

The script starts with #!/usr/bin/env python3.

Check version:

    python3 --version


If not installed:

      sudo apt update
      sudo apt install python3 python3-pip -y

# 2️⃣ psutil Python module

This script uses psutil to check CPU, memory, disk, and processes.

Install it using pip:

     python3 -m pip install psutil


⚠ On Ubuntu, if you get externally-managed-environment error, use:

    sudo apt install python3-psutil

3️⃣ Permissions

chmod +x filename
