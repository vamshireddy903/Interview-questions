# 1. What is EKS Architecture?

Amazon EKS (Elastic Kubernetes Service) is a fully managed Kubernetes service provided by AWS. It allows you to run Kubernetes clusters without having to install, operate, or maintain your own Kubernetes control plane. Essentially, AWS handles the heavy lifting of managing the Kubernetes infrastructure while you focus on deploying and managing your containerized applications.

# Key Points of EKS

# Managed Kubernetes Control Plane

AWS runs the Kubernetes control plane (API server, etcd database, scheduler, controllers) across multiple Availability Zones (AZs) for high availability.  
You don’t have to worry about patching or scaling the control plane.

# Worker Nodes

Your application containers run on worker nodes, which can be EC2 instances or AWS Fargate serverless compute.  
EKS integrates with AWS services like IAM, VPC, CloudWatch, and ALB/ELB.

# Networking

Uses VPC networking, allowing you to securely connect pods to your existing AWS resources.  
Supports Security Groups and Network Policies.

# Scaling

Supports Cluster Autoscaler to scale nodes up/down automatically.  
Works with Horizontal Pod Autoscaler to scale pods based on load.

# Integrations

Works with AWS tools like CloudWatch for logging, IAM for authentication, and ECR for container registry.

# Architecture components:
<img width="623" height="416" alt="image" src="https://github.com/user-attachments/assets/a99bae82-6e06-41a1-86cf-5b591f843a31" />

**Control Plane:** Managed by AWS; includes API server, etcd, and scheduler. AWS handles scaling, patching, and high availability.

**Worker Nodes:** EC2 instances or Fargate where your containers run.You manage these (if EC2) or let AWS manage (if Fargate).

**Node Groups:** A group of worker nodes managed together.

**kubectl / API Access:** You interact with the cluster via kubectl or AWS SDK/CLI.

**VPC Networking:** Each cluster resides inside a VPC for isolation.

**Add-ons:** Includes CoreDNS, VPC CNI, metrics-server, etc.

# Why Use EKS?

Reduces operational overhead of Kubernetes.  
Highly secure and scalable.  
Fully integrates with AWS ecosystem.  
Supports hybrid deployments and multi-AZ HA setups.

# 2. What is the use of CIDR?

**CIDR (Classless Inter-Domain Routing)** is used to define IP address ranges.

Helps in networking and subnetting in VPCs.

Example: 10.0.0.0/16 defines a range of IPs for your VPC.

Allows better IP allocation, routing, and segmentation.

# How to connect EC2 instance from personal laptop without public permissions?

Use AWS Systems Manager Session Manager (no public IP required).

# Steps:

Attach SSM Managed Policy to EC2 IAM Role.

Enable SSM Agent on EC2.

Connect using:

    aws ssm start-session --target <instance-id>

Alternatively, connect via VPN / Direct Connect / Bastion Host.
