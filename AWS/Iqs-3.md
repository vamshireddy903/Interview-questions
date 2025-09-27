# What is an AMI (Amazon Machine Image)?

An AMI (Amazon Machine Image) is a pre-configured template that contains the information required to launch an EC2 instance.  
It defines the software environment (OS + applications + configurations)

# Components of an AMI

**Root Volume Template**

- The operating system (Linux, Windows, etc.), application server, and any pre-installed applications.

**Launch Permissions**

- Control which AWS accounts can use this AMI to launch instances.

**Block Device Mapping**

- Defines which storage volumes (EBS or instance store) attach to the instance at launch.

# Key Points

AMIs are region-specific (but can be copied across regions).

You can choose:

**AWS-provided AMIs** (Amazon Linux, Ubuntu, Windows, etc.)

**Marketplace AMIs** (pre-configured with software like WordPress, Jenkins, etc.)

**Custom AMIs**(your own, with specific apps/configurations).

Helps in scaling: launch multiple identical instances quickly.

# Use Cases

**Custom environments:** Create your own AMI after configuring EC2 (install apps, patches, security settings).

**Disaster recovery:** AMI ensures you can recreate the same environment if an instance fails.

**Scaling applications:** Quickly launch multiple identical servers for load balancing or auto scaling.

# What are Instance Types in EC2?

Instance types define the hardware configuration of your EC2 instance.  
They determine CPU, memory (RAM), storage type, and networking capacity.  
AWS offers many instance families, each optimized for different workloads.

# Different EC2 Instance Families & When to Use Them

# General Purpose

Balanced CPU, memory, and networking.  
Examples:  
t3, t4g → low-cost burstable workloads.  
m5, m6g → balanced for apps needing steady performance.

**Use cases:** Web servers, dev/test environments, small/medium databases.

# Compute Optimized

High CPU-to-memory ratio.  
Examples: c5, c6g.

**Use cases:** High-performance computing, batch processing, gaming servers, video encoding.

# Memory Optimized 

High memory (RAM) for memory-intensive apps.  
Examples:  
r5, r6g → in-memory caching (Redis, Memcached).  
x1, x2 → large SAP HANA, in-memory analytics.  

**Use cases:** Databases, real-time big data analytics, caching.

# Storage Optimized 

High disk throughput and IOPS.  

Examples:  
i3, i4 → low-latency SSD storage.  
d2, h1 → high HDD storage.  

**Use cases**: Data warehouses, Hadoop, Elasticsearch, high-transaction DBs.

# Accelerated Computing 

Use GPUs or custom chips for high-performance computing.

Examples:

p3, p4 → machine learning training.  
g4, g5 → ML inference, graphics rendering.
inf1, trn1 → AWS chips for ML acceleration.  

**Use cases:** AI/ML, deep learning, video rendering, simulations.

<img width="1093" height="575" alt="image" src="https://github.com/user-attachments/assets/045cf0c1-0043-496d-83e0-fcde24bdb7dd" />

# Explain different s3 storage classes

Amazon S3 offers different storage classes to help you optimize cost, durability, and access speed based on how frequently you need the data and how long you want to keep it


# S3 Storage Classes Overview
|Storage Class |	Durability / Availability |	Access Pattern	| Cost	| Use Cases|
|--------------|----------------------------|-----------------|-------|----------|
|S3 Standard	|99.999999999% durability, 99.99% availability	|Frequently accessed|	High	|Websites, apps, dynamic content, active data|
|S3 Standard-IA (Infrequent Access)|	Same durability as Standard, 99.9% availability	|Accessed less frequently, but needs instant access	|Lower than Standard, plus retrieval fee	|Backups, disaster recovery, long-term storage|
|S3 One Zone-IA	|99.999999999% durability, in one AZ, 99.5% availability|	Less frequently accessed, can tolerate AZ loss|	Cheaper than Standard-IA	Secondary | backups, non-critical data
|S3 Intelligent-Tiering	|99.999999999% durability|	Automatically moves objects between frequent/infrequent tiers based on access	|Pay for what you use	|Unknown or changing access patterns|
|S3 Glacier Instant Retrieval	|99.999999999% durability	| Archive data, immediate retrieval|	Low	|Long-term archives needing occasional instant access|
|S3 Glacier Flexible Retrieval	|99.999999999% durability	|Archive, retrieval within minutes to hours|	Very low	|Long-term archives, compliance, infrequent access|
|S3 Glacier Deep Archive	|99.999999999% durability|	Retrieval within 12 hours|	Cheapest| Compliance, rarely accessed data, long-term retention|
