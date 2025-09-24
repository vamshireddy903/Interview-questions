# 1. Do you have hands-on in Linux? If yes, Which Platform?
Yes, commonly on Ubuntu, CentOS, Amazon Linux, Red Hat (RHEL).

# 2.What is the latest version of Ubuntu?
 As of Sept 2025 → Ubuntu 24.04 LTS (Noble Numbat).
 
# 3.I have index.html on GitHub, I need to push it into aws. The requirement is one load balancer is required and we provide index.html in GitHub repo and we provide username and token. How to achieve this?
 Steps:

Launch EC2 (Amazon Linux/Ubuntu).

Install web server (Apache/Nginx).

Clone repo from GitHub using username + PAT (token).

git clone https://<username>:<token>@github.com/<repo>.git

Move index.html into /var/www/html/.

Attach EC2 to an Application Load Balancer (ALB) target group.

Configure ALB listener (HTTP:80 → Target group).

Access ALB DNS name in browser to view index.html.
  
# 4 what is dependinces resources for the IP?
- Elastic IP (for static public IP).  
- Internet Gateway (for internet).  
- Route Table entry.  
- Security Groups (allow 22, 80/443).  
  
# 5 What is the command to connect EC2 instance?

   ssh -i <keypair.pem> <username>@<public IP>
   
# 6 How to implement Internet gateway?

Internet Gateway (IGW) is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet.  
Internet Gateway enables resources (like EC2 instances) in public subnets to connect to the internet. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public.

<img width="894" height="277" alt="image" src="https://github.com/user-attachments/assets/72e19754-6175-4225-9d41-9a310dc35370" />

VPC → Create IGW → Attach IGW to VPC.

# 7 How to configure internet gateway to route table?

Edit Route Table → Add route: 0.0.0.0/0 → igw-xxxx.

# 8 What is the exact command to log in the instance and what kind of authentication will you use ? Do you need password to provide or something else ?

SSH key-pair based (not password).

ssh -i mykey.pem ec2-user@<public-ip>

# 9 In which path will you create index.html in Server ?

- For Apache: /var/www/html/index.html  
- For Nginx: /usr/share/nginx/html/index.html  

# 10. Explain Most common linux Commands 

ls, cd, mkdir, rm, cp, mv, cat, less, head, tail, ps, top, df, du, chmod, chown, grep, find, tar, zip, systemctl, service

# 11. How to check one running process?

ps -ef | grep <process-name>

# 12. How to list running process?
```
top
htop
ps aux
```
# 13. You need to find one particular process id and how to kill that? Is it possible in single command?

if you know the process name (say nginx), you can directly find its PID and kill it:

    pkill -f nginx

or

    kill -9 $(pidof nginx)

# 14 How to check disk usage?

     df -h
     
# 15 How to find free memory?

    free -m
    
# 16 How do you archive and compress directory in Linux?

     tar -czvf mydir.tar.gz mydir

<img width="707" height="332" alt="image" src="https://github.com/user-attachments/assets/3ef00acb-0c16-4bcb-b800-5e0f7ff80a4f" />

want to extract it

    tar -xvf mydir.tar.gz

# 17 Chmod 755 means?

- Owner: read, write, execute  
- Group: read, execute  
- Others: read, execute  

# 18 If I provide chmod 755 means, what exactly will happen?

- Makes file executable by owner, group, and others.
- Common for scripts & directories.

# 19 what is chown ?

Change ownership of file/dir.

1. Change only the owner:

        sudo chown ubuntu test.txt

2. Change the group

       sudo chown :newgroup test.txt
   
4. change the user and group

       sudo chown <new_owner>:<new_group> test.txt

# 20 How to list all ssh users in Linux?

Users who can SSH usually have a shell like /bin/bash, /bin/sh, /bin/zsh, etc. System users or service accounts often have /sbin/nologin or /usr/sbin/nologin.

    cat /etc/passwd | grep bash

# 21 If one apache server is running, I need to check logs? where do I check? In which directory?

- /var/log/apache2/ (Ubuntu/Debian)  
- /var/log/httpd/ (CentOS/RedHat)
  
# 22 what kind of logs can see in /var/log ?

syslog, auth.log, kern.log, messages, dmesg, secure, application logs.

# 23 Purpose of Grep command?

 Search for patterns in text.
 
# 24 I need to grep keyword:linux. Expect the keyword linux, I need to list out all the lines from the linux.txt file. which flag will you used with grep?

      grep -v "linux" linux.txt
      
# 25 How do copy file from the container to host ?

      docker cp <container-id>: /path/file /host/path

39. I want to configure one alerting disk Usage of one of the server reaches 80%, it should alert sms? where can I do these configuration? 
40. How to generate token in GitHub? Explain the steps.
