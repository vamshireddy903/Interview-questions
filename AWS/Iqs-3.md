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


# What is an S3 Lifecycle Policy?

An S3 Lifecycle Policy lets you automate the management of objects in your bucket.

You can:

Transition objects to cheaper storage classes (e.g., Standard → Glacier).

Expire objects automatically after a certain period.

Steps to Write a Lifecycle Policy

# 1. Define the scope

- Apply to all objects or only objects with a specific prefix or tag.

# 2. Set rules

- Transition: Move objects to another storage class after N days.

- Expiration: Delete objects after N days.

# Use Cases

**Log Management:** Archive logs after 30 days, delete after 1 year.

**Backup Data:** Move infrequently accessed data to Glacier automatically.

**Cost Optimization:** Automatically remove old files or move them to cheaper storage.

# Ways to Secure an S3 Bucket

# 1. Bucket Policies

- Use **bucket policies** to control who can access the bucket and what actions they can perform.

Example: Only allow read/write from a specific IAM user or role.  
Avoid making the bucket **public** unless necessary.

# 2. IAM Policies

Attach fine-grained IAM policies to users, groups, or roles.  
Control access at the user level rather than the bucket level.

# 3. Block Public Access

- AWS provides a “Block Public Access” feature to prevent accidental public exposure.  
- Recommended to enable this by default unless the bucket is intentionally public.

# 4. Encryption

Server-side encryption (SSE):  
SSE-S3 → AWS-managed keys  
SSE-KMS → AWS KMS-managed keys (more control & auditing)  
SSE-C → Customer-provided keys  
Client-side encryption: Encrypt data before uploading.  

# 5. Versioning

Enable versioning to protect against accidental deletion or overwrites.  
Helps recover older versions if a file is mistakenly deleted.

# 6. Logging & Monitoring

Enable S3 server access logs → track who accessed the bucket.  
CloudTrail integration → monitor API calls for auditing.

# 7. MFA Delete

Enable Multi-Factor Authentication (MFA) Delete for versioned buckets.  
Requires MFA to permanently delete objects or change the bucket versioning state.

# 8. Network-Level Security

Use VPC endpoints for S3 → restrict access to the bucket only from your VPC.  
Avoid public internet access if the bucket is private.

# 9. Object-Level Permissions

Use ACLs sparingly (prefer IAM and bucket policies).
Control read/write access to individual objects if needed.

# Best Practices Summary

Block public access unless explicitly required.  
Use IAM roles and policies for access control.  
Enable encryption (SSE-KMS preferred).  
Enable versioning and MFA delete for critical data.  
Monitor access via CloudTrail or S3 logs.  
Use VPC endpoints for private access.  

# 1. Public Subnet

A public subnet allows instances to communicate directly with the internet.

# Steps to make a subnet public:

- Attach an Internet Gateway (IGW) to your VPC
- IGW enables internet connectivity for the VPC.
- Update the subnet’s route table

Add a route like:
```
Destination: 0.0.0.0/0
Target: igw-xxxxxxxx
```

This tells AWS to send all internet traffic from the subnet to the IGW.

Assign public IPs to instances

Either enable auto-assign public IP on the subnet or assign Elastic IPs to instances manually.

✅ Result: Instances in this subnet can access the internet and receive incoming traffic from it.

# 2. Private Subnet

A private subnet is isolated from the internet. Instances cannot be accessed directly from the internet.

# Steps to make a subnet private:

- Do not attach a route to an IGW in the subnet’s route table.  
- Optional Internet Access via NAT Gateway

If instances in the private subnet need outbound internet access (for updates, API calls), create a NAT Gateway in a public subnet.

Update the private subnet’s route table:
```
Destination: 0.0.0.0/0
Target: nat-xxxxxxxx
```

✅ Result: Instances can reach the internet (outbound) but cannot be accessed from the internet (inbound).

- Web servers usually go in public subnets.
- Databases, app servers, or sensitive resources go in private subnets.

# If you install Nginx, which configuration file do you modify?

# 1. Main Configuration File

Path (Linux/Ubuntu):

    /etc/nginx/nginx.conf

This file contains global settings, such as:

- Worker processes
- Logging
- Include directives for other config files

# 2. Server/Virtual Host Configurations

On Ubuntu/Debian, Nginx uses sites-available and sites-enabled directories:
```
/etc/nginx/sites-available/
/etc/nginx/sites-enabled/
```

You create or modify a file here for your website or application. Example:

    /etc/nginx/sites-available/mywebsite


Then create a symbolic link in sites-enabled:

    sudo ln -s /etc/nginx/sites-available/mywebsite /etc/nginx/sites-enabled/

3. Reload Nginx After Changes

       sudo nginx -t       # Test configuration
       sudo systemctl reload nginx

#  How do you make an application Highly Available?

# 1. Use Multiple Availability Zones (AZs)

- Deploy your application across at least two AZs in a region.
- Ensures that if one AZ goes down, the other can still serve traffic.

Example:

EC2 instances in AZ-1 and AZ-2.

# 2. Load Balancing

Use an Elastic Load Balancer (ELB) to distribute incoming traffic across multiple instances/AZs.

Benefits:
- Prevents a single instance from being overloaded.
- Automatically directs traffic to healthy instances.

# 3. Auto Scaling

- Set up Auto Scaling Groups to automatically:
- Launch new instances if demand increases.
- Replace failed instances automatically.

# 4. Database High Availability

- Use managed database services with HA features:
- RDS Multi-AZ deployments for automatic failover.
- DynamoDB for multi-region replication.

# 5. Use Health Checks

- ELBs perform health checks to route traffic only to healthy instances.
- Auto Scaling uses health checks to replace unhealthy instances.

# 6. Decouple Components

- Use SQS, SNS, or event-driven architectures to decouple services.
- Reduces single points of failure.

# 7. Use Multi-Region Deployment (Optional for Critical Apps)

- Deploy the application in multiple AWS regions.
- Useful for disaster recovery and regional outages.

Shortcut / Interview-Friendly Answer

High availability = multiple AZs + load balancing + auto scaling + database failover + decoupled architecture.

# Explain a 3-Tier Architecture. How would you set it up for a banking application?

# What is 3-Tier Architecture?

A 3-Tier Architecture is a common design pattern that separates an application into three layers:

# Presentation Tier (Frontend)

- Handles user interface and client interaction.
- Example: Web browser, mobile app, or API gateway.

# Application Tier (Business Logic / Backend)

- Processes business logic, validates transactions, communicates with the database.

Example: Java Spring Boot app, Node.js, Python Flask/Django.

# Data Tier (Database)

- Stores and manages persistent data.

Example: RDS (MySQL/PostgreSQL), DynamoDB, or Oracle DB.

# 2. How It Works

Client → Presentation Tier → Application Tier → Data Tier

Each tier can scale independently and be secured separately.

Decoupling tiers improves availability, scalability, and security.

# 3. Setting Up a 3-Tier Architecture for a Banking Application (AWS Example)

#A. Presentation Tier

AWS Services:

- Amazon CloudFront (CDN for static content)
- S3 (host static web assets like HTML, CSS, JS)
- ALB (Application Load Balancer) to route traffic to backend instances

**Setup:**

- Place ALB in public subnets of multiple AZs for HA.
- Ensure HTTPS via SSL/TLS certificates.

# B. Application Tier

AWS Services:

- EC2 Auto Scaling Group or ECS/EKS (containers)
- Security Groups to restrict access to only allow traffic from ALB

**Setup:**

- Deploy backend servers in private subnets across multiple AZs.
- Use Auto Scaling to handle variable load.
- Use VPC endpoints for private communication with AWS services.

C. Data Tier

AWS Services:

- RDS (Multi-AZ) for relational DB
- DynamoDB for key-value or NoSQL data
- Enable encryption at rest using KMS
- Enable automated backups and snapshots

**Setup:**

- Place databases in private subnets.
- Only allow access from the application tier (SGs).
- Use read replicas for scaling read-heavy operations.

# 4. Security & Best Practices

- VPC with public and private subnets.
- Security Groups & NACLs to restrict traffic flow.
- MFA & IAM roles for access control.
- Encryption for data in transit (TLS) and at rest (KMS).
- Monitoring & logging via CloudWatch, CloudTrail.

# 5. Optional Enhancements

- Caching Layer: AWS ElastiCache (Redis/Memcached) between app and DB for faster reads.
- Message Queue: AWS SQS for decoupling transaction requests.
- Disaster Recovery: Multi-region replication for critical banking data.
- Shortcut / Interview-Friendly Summary

3-Tier Architecture = Presentation (frontend) → Application (backend) → Data (database).
In AWS, public subnets for frontend, private subnets for backend & database, load balancers, Auto Scaling, RDS Multi-AZ, and strict security policies ensure HA, scalability, and security for a banking app.
