# EBS

EBS stands for Elastic Block Store, and it’s an AWS service that provides block-level storage for use with Amazon EC2 instances. You can think of it like a hard drive in the cloud that you can attach to your virtual machines.

Here’s a detailed breakdown:

# 1. Key Characteristics

**Block-level storage:** Data is stored in fixed-size blocks, similar to traditional disks, which makes it suitable for databases, file systems, and applications requiring low-latency access.

**Persistent:** Unlike the storage on an EC2 instance itself (instance store), EBS volumes persist even if the EC2 instance is stopped or terminated.

**Highly available:** EBS volumes are automatically replicated within an Availability Zone (AZ) to protect against hardware failure.

# Types of EBS Volumes

AWS provides different types based on performance and cost:

| Type	| Use Case	| Performance |
|-------|-----------|-------------|
| gp3 / gp2 (General Purpose SSD)	| Balanced for most workloads	| Good IOPS and throughput  |
| io2 / io1 (Provisioned IOPS SSD) |	Databases needing high IOPS	 | Very high IOPS with low latency  |
| st1 (Throughput Optimized HDD)	|Big data, logs	| High throughput,  low cost  |
| sc1 (Cold HDD)	| Infrequent access	| Cheapest, lowest performance  |

# 3. Features

Attach/Detach: You can attach an EBS volume to an EC2 instance and detach it when needed.

Resize: You can increase the size of a volume without downtime.

Snapshots: You can take point-in-time backups (snapshots) of EBS volumes, which are stored in S3.

Encryption: EBS supports encryption for security and compliance.

# 1. One EBS volume → one EC2 instance

- A single EBS volume can be attached to only one EC2 instance at a time if it’s a standard (non-multi-attach) volume.  
- **Exception:** io2 Block Express volumes support multi-attach, which allows attaching the same volume to multiple EC2 instances in the same AZ for clustered applications.  

# 2. Multiple EBS volumes → one EC2 instance

You can attach multiple EBS volumes to a single EC2 instance.  

**This is useful for:**

- Separating OS, application data, and logs  
- Increasing total storage capacity
- Optimizing IOPS by spreading workloads across multiple volumes

for more info: https://docs.aws.amazon.com/hands-on/latest/amazon-ebs-backup-and-restore-using-aws-backup/amazon-ebs-backup-and-restore-using-aws-backup.html

<img width="1868" height="872" alt="image" src="https://github.com/user-attachments/assets/607be9e3-7b5a-4f84-a5d3-4b8e240ca473" />

<img width="1742" height="642" alt="image" src="https://github.com/user-attachments/assets/a2f718ea-3f80-473a-9c8a-d146d25c1d4a" />

<img width="1756" height="1025" alt="image" src="https://github.com/user-attachments/assets/80171fef-87ff-4674-a232-819ff4616428" />

<img width="1793" height="1048" alt="image" src="https://github.com/user-attachments/assets/a1d3fa40-13dd-4706-8675-85accfeacab6" />

<img width="1819" height="1050" alt="image" src="https://github.com/user-attachments/assets/0c94087d-ea8d-4ee1-843a-63b29f55fc20" />

# Create new EBS Volume and attach to EC2

# Step 1: Create an EBS Volume

Go to the AWS Management Console → EC2.  

On the left panel, click Volumes.  

Click Create Volume.

Volume type: Choose (e.g., gp3 or gp2).

Size: Set the GB size (e.g., 10 GiB).

Availability Zone (AZ): Must match the EC2 instance’s AZ (very important).

Click Create Volume.

# Step 2: Attach the Volume to EC2

After creation, select your new Volume.

Click Actions → Attach Volume.

Select your EC2 Instance (must be in same AZ).

Choose a device name (e.g., /dev/xvdf).

Click Attach.

<img width="1479" height="755" alt="image" src="https://github.com/user-attachments/assets/d3759775-3e12-4a78-abe1-6d232ec6a65d" />

<img width="1884" height="740" alt="image" src="https://github.com/user-attachments/assets/1e992012-931f-4e79-a4fa-a12ebeeeb9bd" />

     sudo fdisk -l

It lists all disks and their partitions attached to your EC2 instance.

<img width="813" height="503" alt="image" src="https://github.com/user-attachments/assets/405160be-ba6b-4d50-b0a8-d3912075a3f6" />

- /dev/xvda → 30 GiB root disk (your OS is running here)  
- /dev/xvdk → 5 GiB new EBS volume

# 3.check if your new EBS volume has a filesystem.

     sudo file -s /dev/xvdk

<img width="727" height="656" alt="image" src="https://github.com/user-attachments/assets/e9ce2741-f8d3-492e-a59c-f98a3aa03e97" />  

my o/p  
<img width="622" height="70" alt="image" src="https://github.com/user-attachments/assets/3ab60769-da70-4fa7-8d89-bc17f7c2fa2e" />


# 4 Format the new EBS volume

     sudo mkfs -t xfs /dev/xvdk

Formats the volume with XFS filesystem so it can be mounted and used to store files.

<img width="856" height="388" alt="image" src="https://github.com/user-attachments/assets/52fddf07-8031-4b7a-b636-b364a22b2d49" />

<img width="980" height="398" alt="image" src="https://github.com/user-attachments/assets/0b267193-016c-4e0c-babb-27f545f08f7e" />

# 5. Mount the new EBS volume

```
sudo mkdir /myebs
sudo mount /dev/xvdk /myebs
```
Creates a mount point /mnt/ebs and mounts the formatted EBS volume there so files can be stored.

<img width="886" height="562" alt="image" src="https://github.com/user-attachments/assets/ed6e4afe-66c2-4c03-8b42-0dc07866536b" />

# Make EBS volume auto-mount on reboot

# Get the UUID of the volume

    sudo blkid /dev/xvdk
<img width="1144" height="65" alt="image" src="https://github.com/user-attachments/assets/9e5a6a61-3edd-4fa3-b30b-4117e40eb718" />

# Edit fstab

    sudo nano /etc/fstab
Add a output line at the end like this

UUID=7cf8f647-7231-4e9c-aa3e-bc0fe3d384f7   /myebs   xfs   defaults,nofail   0   2








