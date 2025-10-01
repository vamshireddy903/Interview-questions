#  A developer complains they cannot write logs to /var/log/myapp/. What do you do ?

Check if the directory exists
   
     ls -ld /var/log/myapp

Check permissions and ownership

     ls -ld /var/log/myapp

Example output:

    drwxr-xr-x 2 root root 4096 Sep 30 10:00 /var/log/myapp

Here, only root can write. If your developer runs the app as myuser, they cannot write.

Fix: change ownership or permissions

    sudo chown myuser:myuser /var/log/myapp

 or allow group write

    sudo chmod 775 /var/log/myapp

# Check disk space

    df -h /var/log

If the disk is full, writing will fail.

# Your application stopped working with “No space left on device”. How do you resolve it 

**Check disk usage**

    df -h
    
Look for any filesystem at or near 100% usage.  
Pay attention to /, /var, /tmp, or wherever your app stores data/logs.  

**Identify large files**

Check which directories are consuming space:

    du -h / | sort -rh | head -20

**Clean up unnecessary files**

Logs: rotate or delete old logs

    sudo journalctl --vacuum-time=7d   # keep last 7 days of system logs
    sudo rm -f /var/log/myapp/*.old   

**Temporary files:**

    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*

**Unused packages:**

    sudo apt autoremove   # Debian/Ubuntu
    sudo yum autoremove 

**Check for deleted-but-open files**

- Sometimes disk space isn’t freed because files are still held by a process:

    lsof | grep '(deleted)'

- Restart the process or server to release space.

  # A scheduled cron job didn’t run. How do you debug

it’s usually due to syntax, permissions, environment, or execution issues. Here’s a systematic way to debug:

**1️⃣ Check the cron schedule and syntax**

List the user’s cron jobs:

    crontab -l

Verify the timing syntax. For example, a job meant to run at 2:30 AM should look like:

     30 2 * * * /path/to/script.sh

***2️⃣ Check cron service**

Ensure cron is running:

---
    sudo systemctl status cron   # Debian/Ubuntu
    sudo systemctl status crond  # RHEL/CentOS
---

Restart if necessary:

     sudo systemctl restart cron

**3️⃣ Check cron logs**

Cron logs failures and execution. Check:

# Debian/Ubuntu
    grep CRON /var/log/syslog

# RHEL/CentOS
    grep CRON /var/log/cron

Look for your script and any errors.

**4️⃣ Check script permissions**

Ensure the script is executable:

    ls -l /path/to/script.sh
    chmod +x /path/to/script.sh

Ensure the user running the cron has permission to execute it.

**5️⃣ Check environment variables**

Cron runs with a minimal environment. Many scripts fail because PATH or other variables aren’t set.

# In your crontab, use full paths or define PATH:
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

Always use absolute paths to commands in cron jobs.

**6️⃣ Test script manually**
    sudo -u <cron-user> /path/to/script.sh

Ensure it runs without errors outside cron.

**7️⃣ Redirect output for debugging**

Capture stdout and stderr in a log:

30 2 * * * /path/to/script.sh >> /tmp/cron.log 2>&1

Check /tmp/cron.log for errors.
