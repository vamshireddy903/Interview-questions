# 🔥 LINUX USER & GROUP MANAGEMENT CHEAT SHEET

# 🧑‍💻 USER MANAGEMENT

**✅ Create a user**

    sudo useradd <username>

**Create user with home directory:**
 
    sudo useradd -m <username>

**Create user with shell:**

    sudo useradd -m -s /bin/bash <username>

 **✅ Set password for user**

    sudo passwd <username>

**✅ Delete user**

    sudo userdel <username>

**Delete user + home directory:**

     sudo userdel -r ,username>

**✅ Modify user (change shell)**

     sudo usermod -s /bin/zsh username

**✅ Lock user account**

    sudo usermod -L <username>

**✅ Unlock user account**

    sudo usermod -U <username>

**🔍 Check if user exists**

    id <username>

id=identity

Or:

    getent passwd <username>

# 👥 GROUP MANAGEMENT

**✅ Create group**

    sudo groupadd devops

**✅ Delete group**

    sudo groupdel devops

**✅ Add user to group (secondary group)**
 
    sudo usermod -aG devops <username>

**✅ Add user to multiple groups**

     sudo usermod -aG devops,admin,wheel <username>

**🔍 Check group info**

    getent group devops

**🔍 List all groups**

    cut -d: -f1 /etc/group

**🛠️ USER + GROUP COMBINED OPERATIONS**

**Create user with primary group**

    sudo useradd -m -g devops username

**Create user and assign multiple groups**

     sudo useradd -m -s /bin/bash username
    
    sudo usermod -aG devops,admin username

  <img width="436" height="187" alt="image" src="https://github.com/user-attachments/assets/0c198c50-2e82-41ef-a7d2-2854193e50f7" />


**Remove user from a group**

    sudo gpasswd -d username devops

**📁 FILE PERMISSION & OWNERSHIP (Bonus)**

**Change file owner**
 
    sudo chown username file.txt

**Change group ownership**

    sudo chown :devops file.txt

**Change owner & group**

    sudo chown username:devops file.txt

**Change permissions**
```
chmod 755 file.txt
chmod 644 file.txt
chmod u+x script.sh
```
**🚀 Verification Commands**  
**List all users**

    cut -d: -f1 /etc/passwd

**List all groups**

    cut -d: -f1 /etc/group
