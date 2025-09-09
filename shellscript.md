# 1. How do you check the available shells on a Linux system?

      cat /etc/shells
      
  Lists all valid login shells available on the system.

# 2 How do you check the current shell you are using?

      echo $SHELL or echo $0
      
# 3. How do you check which package manager is available?

      command -v apt   # Check if apt is available (Debian/Ubuntu)
      command -v yum   # Check if yum is available (RHEL/CentOS/Fedora)

# 4 How do you check installed packages?
Debian/Ubuntu:

    dpkg -l | grep package_name

RHEL/CentOS/Fedora:

    rpm -qa | grep package_name 

# 5 Example output if Git is installed:

    ii  git        2.43.0-1ubuntu1  amd64  fast, scalable, distributed revision control system

Here:
  ii → package is installed.

   git → package name.

   2.43.0-1ubuntu1 → version installed.

# 6 Write a Bash script to check if Git is installed on a Linux system, detect the package manager (yum or apt), and install Git if it is not already installed.
[script](https://github.com/vamshireddy903/Interview-questions/blob/main/Shellscript_tasks/git_install.sh)

# 7 Write a shell script to monitor the disk usage and configure the email

First configure mail.sh and then execute disk_check.sh

 [script](https://github.com/vamshireddy903/Interview-questions/tree/main/Shellscript_tasks)

# 8 Write script to check the status of the docker and restart
[docker status_restart_scipt](https://github.com/vamshireddy903/Interview-questions/blob/main/Shellscript_tasks/docker_status_restart.sh)

```

#!/bin/bash

echo "Name of the script is: $0"
echo "First argument passed to the script is: $1"
echo "Second argument passed to the script is: $2"

echo "Total number of arguments passed to the script is: $#"
echo "Total values passed to the script is: $@"

```
<img width="970" height="200" alt="image" src="https://github.com/user-attachments/assets/57b75cf0-c83b-4d32-bafe-f5e87f29a868" />

$# → Number of arguments

Represents how many arguments were passed to a script or function.

$? → Exit status of the last command

Stores the exit code of the last executed command:

0 → success

Non-zero → some error occurred

$@ → All arguments

Represents all arguments passed to a script, as separate words.

$* → All arguments as a single string

All arguments passed to the script are combined into one string.

Words are separated by the first character of IFS (usually a space).


