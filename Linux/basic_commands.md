# Table of contents

# 1) cat command — create / append / merge / view

Create a new file  
Append (add new lines)  
View file contents  
Merge multiple files  
Reverse output  

# 2) touch command — create empty files & update timestamps

Create empty files  
Update timestamps  
Check timestamps  

# 3) vi / vim editor — powerful editor

Create or open a file  
Basic workflow  
Example

# 4) nano editor — beginner-friendly editor

Create or open a file  
Basic workflow  
Supporting Commands  
Practical Demo (on AWS EC2)  
Cheat-Sheet (summary)  

Today’s focus: how to create and edit files in Linux.  
This looks very basic, but almost everything in DevOps (logs, configs, scripts, automation) starts with file handling. So mastering this step is essential.

cat command  
touch command  
vi/vim editor  
nano editor  

# Pre-requisites  
You should have an AWS EC2 instance (Amazon Linux / Ubuntu, free tier).  
Connect using SSH or PuTTY (Windows).  
Become root/admin for easier access:  

sudo su -  
 $ means normal user, # means root user.  

1) cat command — create / append / merge / view  
The cat command = concatenate. It is used to create files quickly, add content, join files, or display file content.  

# Create a new file  

cat > file1.txt  
Hello  
How are you?  
<Ctrl-D>  
      
       > means redirect output to file.  

Type lines → press CTRL + D to save.  

If file already exists → it will be overwritten.  

# Append (add new lines)  

cat >> file1.txt  
This is a new line  
<Ctrl-D>  

>> appends text at the end of the file.  

# View file contents

cat file1.txt  

# Merge multiple files

cat file1.txt file2.txt > merged.txt  

Now merged.txt contains contents of both files.

# Reverse output
  
tac file1.txt  
(tac is just cat backwards — it prints lines in reverse order).

⚠️ Limitation: you cannot edit existing text with cat. You can only create or append.

# 2) touch command — create empty files & update timestamps

Most people think touch is only for creating empty files. But its main purpose is updating timestamps (Access, Modify, Change times).

Create empty files

touch empty.txt  
touch one.txt two.txt three.txt     # multiple files in one go
Update timestamps  

touch empty.txt  
Now its last modified time is updated to the current time.  

Check timestamps  

    stat empty.txt  

You will see:

Access time (last opened)  
Modify time (last content change)  
Change time (metadata change)

# 3) vi / vim editor — powerful editor  
vi (or improved version vim) is the most powerful text editor in Linux. Every server has it by default.  

Create or open a file

    vi file3.txt

Basic workflow  
File opens in Normal mode.  
Press i → now you’re in INSERT mode → type content.  
Press Esc → back to Normal mode.  
Save & exit: :wq → Enter.  

Other shortcuts:

:w → save only  

:q! → quit without saving

:wq! → force save + quit

Example

vi notes.txt
# press i  
Hello World  
How are you?  
# press Esc  
:wq  

# 4) nano editor — beginner-friendly editor  
nano is easier to use than vi — simple shortcuts and guidance at the bottom of the terminal.

Create or open a file

nano file4.txt

Basic workflow  
Type directly (nano is always in insert mode).  

Save → CTRL + O → press Enter.  

Exit → CTRL + X.  

Cancel/No → press N when asked.  

Supporting Commands  

# List files

ls
ls -l       # with details (permissions, size, owner, time)  
ls -a       # show hidden files  
See file content  

cat file.txt  
less file.txt   # scroll with arrow keys, q to quit  
head file.txt   # first 10 lines  
tail file.txt   # last 10 lines  
tail -f logfile # follow logs live  

# File info

stat file.txt  

# History of commands

    history

