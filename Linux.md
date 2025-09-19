# When / is 100% full on Linux

If the root filesystem is full, system stability breaks.

**🔍 What Happens:**

Can’t write logs → services may crash.

Package installs/updates fail.

Temp files (/tmp) cannot be written → apps fail.

Critical daemons may stop → SSH, cron, systemd issues.

# 🔧 Fix:

Find biggest consumers
```
df -h
du -sh /* | sort -h
```

Clean logs
```
journalctl --vacuum-time=7d
rm -rf /var/log/*.gz
```

Delete old packages / caches
```
sudo apt clean        # Debian/Ubuntu
sudo yum clean all    # RHEL/CentOS
```

Check orphaned processes holding deleted files

    lsof +L1

(restart those processes to release space).

Move heavy files

Shift large files to another mount point (/mnt, /home, /data).

# How to check which process is using a port (e.g., 8080)?

    sudo lsof -i :8080
    sudo netstat -tulnp | grep 8080

Explanation: Useful when services fail to start because port is already in use.


# How do you find top memory-consuming processes?

    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head

Explanation: Helps in troubleshooting OOM issues.

# A user cannot log in via SSH. What do you check?

Check SSH service: 

    systemctl status sshd

Check firewall:  

    sudo iptables -L -n or ufw status

Check /etc/ssh/sshd_config (PermitRootLogin, PasswordAuthentication)

Check logs:
```
tail -f /var/log/auth.log   # Ubuntu/Debian
tail -f /var/log/secure     # RHEL/CentOS
```

# How to check system boot logs?

    dmesg | less
    journalctl -b

Explanation: Useful when troubleshooting kernel, disk, or hardware issues.

# How do you monitor real-time logs of a file?
```
tail -f /var/log/syslog
tail -f /var/log/messages
```

# How to view logs on your system

Since you’re on a systemd-based distro (Ubuntu with WSL or a newer release), use journalctl.

Examples:

Follow all logs in real time (like tail -f /var/log/syslog):

    sudo journalctl -f

Check logs for a specific service (e.g., ssh):

    sudo journalctl -u ssh

 Check kernel messages (like /var/log/kern.log):

     sudo journalctl -k -f

Check logs since boot:

    sudo journalctl -b

Filter by time:

    sudo journalctl --since "2025-09-17 20:00:00" --until "2025-09-18 10:00:00"

✅ In real-time troubleshooting:

On RHEL/CentOS/Amazon Linux → tail -f /var/log/messages  
On Ubuntu/Debian (old) → tail -f /var/log/syslog  
On Ubuntu/Debian (new) / WSL / systemd-based → journalctl -f

# How do you check which port a service is listening on

    ss -tulnp

# How do you check your IP and routes?

Check IP address:

    ip addr

Check routes:

    ip route

# How do you debug DNS issues?

Use dig or nslookup:
```
dig google.com
nslookup google.com
```
If DNS fails → check /etc/resolv.conf.

# How do you check if firewall is blocking traffic?

    sudo ufw status

# How do you check which process is using a port?

Example: Port 8080 in use.

    sudo lsof -i :8080

# App not reachable on port 8080

👉 Scenario: You deployed a web app on port 8080, but users can’t access it.

# Troubleshooting Steps:

# Check if the app is running locally

```
ps aux | grep java    # if Java app
systemctl status myapp
```

# Check if the app is listening on port 8080

    ss -tulnp | grep 8080

If not listening → app didn’t start or crashed.

If listening → continue.

# Test locally (from same server)

    curl http://localhost:8080

If working → issue is network/firewall.

If not working → app issue (check logs).

# Check firewall
```
sudo ufw status        # Ubuntu
sudo iptables -L -n -v # General
```

# Ensure port 8080 is allowed.

Check Security Groups (Cloud)

If running on AWS/GCP/Azure → ensure inbound rules allow 8080.

# Test from remote client

    nc -zv <server-ip> 8080

If fails → network/firewall/security issue.

# Answer in interview:
First, I’ll verify if the app is running and listening on port 8080 using ss or netstat. Then, I’ll test with curl localhost:8080. If it works locally but not remotely, I’ll check firewall rules and cloud security groups. Finally, I’ll use nc to verify connectivity from outside.

# Users report DNS resolution is failing

👉 Scenario: Users can’t resolve myapp.com.

# Troubleshooting Steps:

# Check DNS resolution locally
```
dig myapp.com
nslookup myapp.com
```

Check /etc/resolv.conf

Ensure valid nameservers are configured (e.g., 8.8.8.8, 1.1.1.1).

# Check DNS server reachability

    ping 8.8.8.8

Check domain’s DNS records

Use dig A myapp.com (for IPv4)

dig CNAME myapp.com (alias records)

Check for DNS propagation issues (if newly updated)

Use external tools:

    https://dnschecker.org

Check caching issues
```
systemd-resolve --flush-caches
sudo service systemd-resolved restart
```
# Answer in interview:
"I’ll start with dig or nslookup to check DNS resolution. If it fails, I’ll check /etc/resolv.conf to confirm the nameservers are correct. If nameservers are fine, I’ll verify whether the domain has valid DNS records using dig. If still failing, I’ll check for DNS propagation or caching issues.

# Packets are dropping

👉 Scenario: Users report network slowness, and you suspect packet loss.

# Troubleshooting Steps:

# Ping test with packet loss

    ping -c 10 google.com


# Check network path with traceroute

    traceroute google.com

Identify where packets are dropping (local, ISP, external).

# Use MTR (best for packet loss)

    mtr google.com

Shows real-time loss at each hop.

# Check NIC (network interface) stats
```
ip -s link
ethtool eth0
```

Look for dropped packets, errors.

# Check server load (sometimes packet drop is due to CPU/memory pressure)

top

# Check firewall or rate limits

iptables -L -n -v

# Answer in interview:
I’ll first run ping and mtr to confirm packet loss and identify where it occurs. Then, I’ll use traceroute to check which hop is causing the drop. If it’s on my server, I’ll check NIC stats with ip -s link and ethtool. If it’s external, I’ll escalate to the ISP or network team.
<img width="915" height="547" alt="image" src="https://github.com/user-attachments/assets/7eba4c0d-873a-4491-a579-0b031b742974" />

use hostname -I or ip addr to get my private IP, and curl ifconfig.me to see my public IP. The private IP is used within the LAN, while the public IP is assigned by the ISP and visible on the internet.
