# EFS
Amazon Elastic File System (EFS) is a serverless, scalable, fully managed file storage service that you can mount to multiple EC2 instances, containers (ECS/EKS), and even on-premises servers at the same time.

It behaves like a shared file system (NFS) that grows and shrinks automatically as you add/remove files.
<img width="1005" height="609" alt="image" src="https://github.com/user-attachments/assets/78bedb7c-1611-4adc-a910-fbe0eb3a14f3" />

# Key Characteristics

**Scalable and Elastic:** EFS storage automatically grows and shrinks as you add or remove files, eliminating the need to provision capacity in advance.  

**Fully Managed:** AWS manages the underlying file storage infrastructure, so you don't need to worry about complex configurations, patching, or maintenance.  

**Shared Access:** Multiple Amazon EC2 instances and other AWS services can concurrently access a single EFS file system.   

**Serverless:** You don't need to provision or manage storage capacity.   

**High Availability and Durability:** EFS is designed for high availability and durability.  

# DEMO
=================

# create 2 EC2 Instances

# Create Security groups

<img width="1849" height="586" alt="image" src="https://github.com/user-attachments/assets/13f17755-7fdd-46bd-9791-3ea4f1b096fc" />

allow: NFS and SSH

# Create EFS

# Login to AWS Console → Navigate to EFS service.

EFS-Click "Create file system".

Configure basic settings:

Name: Give it a name (e.g., my-efs).

VPC: Choose the VPC where your EC2 instance is.

Availability and Performance: Usually leave default (General Purpose, Bursting Throughput).

Configure network access:

Select the subnets in which you want mount targets.

Security group: Use a security group that allows NFS (port 2049) from your EC2 instances.

Optional settings:

Enable automatic backups if needed.

Lifecycle policies to move infrequently accessed files to EFS Infrequent Access.

Click "Create".

AWS will create the file system and mount targets for each selected subnet.

click efs created --- click attach

<img width="1878" height="805" alt="image" src="https://github.com/user-attachments/assets/4305febc-ac7a-48ac-b9e7-026c017c02a1" />

<img width="1874" height="808" alt="image" src="https://github.com/user-attachments/assets/0002f053-93ce-49bb-b5b9-342d1889863c" />

<img width="1892" height="774" alt="image" src="https://github.com/user-attachments/assets/38d2a1c9-e456-4e62-8604-0c9273294928" />


# 1. Update your system
```
sudo apt update
sudo apt upgrade -y
```
# 2. Install NFS client

    sudo apt install nfs-common -y

# Create a mount point on server1

Choose a directory where you want to mount your EFS:
 
    sudo mkdir -p /mnt/efs1
    
  Find your EFS DNS name
  

<img width="1652" height="534" alt="image" src="https://github.com/user-attachments/assets/ecfaa948-92ea-4dba-bcea-667183b9baeb" />

example:  sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0676e1313f9eb48d8.efs.us-east-1.amazonaws.com:/ /mnt/efs1

Check if it mounted correctly:

     df -h
<img width="924" height="269" alt="image" src="https://github.com/user-attachments/assets/5b580439-99b3-4cea-9c94-3e1ded4ac736" />

now cd /mnt/efs1

create file test.txt

# same thing on server 2

create directory

    sudo mkdir /mnt/efs2

    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0676e1313f9eb48d8.efs.us-east-1.amazonaws.com:/ /mnt/efs2

  cd /mnt/efs2

  now do ls you should see

  test.txt file

