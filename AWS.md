# 1. What is the difference b/w EC2 and Lambda
Elastic compute cloud is server based compute service that let's you to launch virtual machines, configure storages, security groups and scale based on demand. 
You are responsible for managing servers including OS upadtes, scaling and uptime. Pricing is based on the uptime of instance.

Lambda, on the other hand, is a serverless compute resource that helps you to run your code without managing or provisioning server. You simply upload your code and AWS runs it.
You only pay for the execution time and the resourcses used during execution.

![image](https://github.com/user-attachments/assets/51dd1ee3-9cbc-4572-9819-cc323452210b)

# 2. Difference b/w S3 and EBS
S3 (Simple Storage Service) is an object storage service used to store and retrieve any amount of data from anywhere. 
It stores data in the form of objects inside buckets, and is commonly used for files, backups, media, static websites, and big data storage. 
It’s highly durable, scalable, and ideal for unstructured data.

EBS (Elastic Block Store) is block-level storage designed to be used with EC2 instances. It functions like a virtual hard disk, allowing you to store OS files, application data, and databases. 
Each EBS volume can be attached to only one EC2 instance at a time, and it provides persistent storage, meaning the data remains even after instance termination (if configured).

![image](https://github.com/user-attachments/assets/650ffc90-2b05-4a3e-911a-f0541dec7a63)

# 3. What is VPC and why we need it

VPC (Virtual Private Cloud) is a logically isolated network within AWS where you can launch AWS resources, such as EC2 instances, in a secure and controlled environment.

You have full control over:

IP addressing (via your own CIDR block)

Subnets (public and private)

Routing (via route tables)

Internet access (via Internet Gateway or NAT Gateway)

Security (via security groups and network ACLs)

Why do we need it?

It allows you to design your network architecture, just like an on-premises data center.

Helps in segregating environments (e.g., dev, test, prod)

Ensures security and access control for sensitive resources.

🧱 Key VPC Components:
Subnets – divide the network into public and private zones

Route Tables – define routing rules

Internet Gateway (IGW) – enables internet access for public subnets

NAT Gateway – allows private subnets to access the internet

Security Groups / NACLs – control inbound and outbound traffic

# 4 What is IAM and why is it important in AWS?
 is an AWS service that allows you to securely control access to AWS resources. It lets you manage who can access your AWS account and what actions they can perform on specific services.

With IAM, you can:

Create users, groups, and roles

Assign fine-grained permissions using policies

Implement least privilege principle — users only get access to what they truly need

Use MFA (Multi-Factor Authentication) for added security

Following the least privilege principle helps reduce the risk of accidental or malicious access. For example, if you give a user access to only S3:ReadOnly, they can’t delete or write anything.

If IAM permissions are misconfigured, it could lead to unauthorized access, data loss, or security breaches, which is why IAM is considered the foundation of cloud security.

# AWS Secrets Manager:
AWS Secrets Manager is a fully managed service that helps you store, manage, and retrieve sensitive information securely in AWS. This includes credentials like database passwords, API keys, and other secrets.

# Key Features

# Secure Storage
Secrets are encrypted at rest using AWS KMS (Key Management Service).

Access is controlled via IAM policies, so only authorized users or services can retrieve them.

# Automatic Rotation
Secrets Manager can automatically rotate secrets for supported databases (e.g., RDS, Aurora) without downtime.

Reduces risk of using old or compromised credentials.

# Centralized Management
All secrets are stored in one place.

Easy to audit who accessed which secret using CloudTrail.

# Programmatic Access
Applications can retrieve secrets at runtime using AWS SDKs or CLI.

Eliminates the need to hard-code passwords in code or configuration files.

# Example Use Cases
Storing database credentials for an EC2 instance or Lambda function.

Storing API keys for third-party services.

Storing OAuth tokens for applications.

# Problem: When you run out of disk space on an EC2 instance, applications or services may stop working because the root volume (/) is full.

Solution (3 Steps)

Step 1: Expand the Volume in AWS Console
================================
Go to AWS Console → EC2 → Volumes
Select your root volume
Click Modify Volume
Increase the size and click Save

Step 2: Check Your Instance Disk
======================================
SSH into the EC2 instance
Run:

     lsblk

This lists block devices (disks and partitions) so you can confirm the new size

Step 3: Grow & Resize the Root Volume
=============================================
Install the required utility (cloud-guest-utils), which provides the growpart

      sudo apt-get install cloud-guest-utils -y

# Grow the partition to use the new space:
          
      sudo growpart /dev/xvda 1

Here: 
/dev/xvda = disk
1 = partition number

# Resize the filesystem:

    sudo resize2fs /dev/xvda1

Here
resize2fs → A Linux tool used to resize ext2/ext3/ext4 filesystems.
/dev/xvda1 → The partition where your root filesystem (/) is located.



🔹 lsblk Meaning
========================
lsblk = List Block Devices
It shows all the block devices on your system (disks, partitions, loop devices, etc.).

A block device is any device that stores data in fixed-size blocks, like:

Hard disks (HDD/SSD)

EBS volumes (in AWS)

USB drives

Partitions (like /dev/xvda1)

Loop devices (snap packages mount these as virtual disks in Ubuntu)

<img width="882" height="341" alt="image" src="https://github.com/user-attachments/assets/affd9163-d200-47a6-82b4-b40f68dbb104" />

Columns Explained

NAME → Device name (xvda, xvda1, etc.)

SIZE → Size of disk/partition

TYPE → disk / part (partition) / loop

MOUNTPOINTS → Where it’s mounted (/, /boot, /boot/efi)

<img width="1013" height="622" alt="image" src="https://github.com/user-attachments/assets/68d456f8-8c8e-4cc1-a108-7a117bc067a3" />

RM = 0 → Not removable (EBS is persistent storage).

RO = 0 → Not read-only (you can write to it).

