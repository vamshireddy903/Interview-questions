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

# 9 Write a Bash script that reads a system log file (e.g., /var/log/syslog) and performs the following tasks:

Search for all lines containing the word "error" (case-insensitive).

Print the matched log lines on the screen.

Display the total count of lines containing the word "error".

[error_check.sh](https://github.com/vamshireddy903/Interview-questions/blob/main/Shellscript_tasks/error_check.sh)

# What is sed?

sed is a command-line text editor used to search, replace, insert, or delete text in a file or input stream — without opening an editor.

# Print file contents (default behavior with -n and p)

      sed -n 'p' file.txt
      
equivalent cat text.txt

# Replace first occurrence of a word in each line

    sed 's/error/warning/' filename.txt

➡ replaces the first occurrence of "error" with "warning".

# Case-insensitive replace

    sed 's/error/warning/Ig' logfile.txt

➡ replaces "error", "Error", "ERROR", etc. with "warning".

# Delete a line (e.g., line 3)

    sed '3d' filename.txt

# Delete lines containing a keyword

    sed '/error/d' filename.txt

# Display the last line of the file

     sed -n '$p' filename.txt

# Display the content from 1-5 line of the file

     sed -n '1,5p' filename.txt

# Delete the perticular line of the content

    sed -i '2d' filename.txt

It will delete the second line

# Delete 4 and 5 th line and take backup before deleting

     sed -i.back '4,5d' filename.txt

<img width="1678" height="798" alt="image" src="https://github.com/user-attachments/assets/a0c36e24-3c6c-4f70-b675-ee8c1af78853" />

# Find the text and replace with new word in 1st occurance

     sed -i 's/hello/hi/' filename.txt


<img width="388" height="173" alt="image" src="https://github.com/user-attachments/assets/3b5190af-1825-439f-82cc-3c48dae719f4" />

# Find the text and replace with new word in globally

     sed -i 's/hello/hi/g' filename.txt

# Insert a line before line 5

     sed '5i This is a new line' filename.txt

# Append a line after line 5

    sed '5a This is an appended line' file.txt

