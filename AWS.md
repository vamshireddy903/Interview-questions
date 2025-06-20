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
