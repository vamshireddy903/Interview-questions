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
