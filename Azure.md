# Virtualization:

Virtualization is the process of creating a virtual version of something instead of using physical hardware directly.

In simple words:
👉 It lets you run multiple virtual computers (virtual machines) on a single physical computer (server) by sharing its resources (CPU, memory, storage, network).

# How it Works

There is a hypervisor (software like VMware, VirtualBox, KVM, Hyper-V) that sits between the physical hardware and the virtual machines.

The hypervisor allocates and manages hardware resources so multiple operating systems (Linux, Windows, etc.) can run simultaneously on the same machine.

# Benefits

Cost saving – fewer physical servers needed.

Resource utilization – better use of CPU, memory, storage.

Isolation – each VM is independent (crash of one doesn’t affect others).

Flexibility – quickly create, modify, or delete virtual machines.

Testing & Development – run different OS and apps safely on the same machine.

# 💡 Example:
If you have one physical server with 16 GB RAM and 8 CPU cores, virtualization allows you to create:

VM1: Ubuntu with 4 GB RAM + 2 CPU

VM2: Windows Server with 8 GB RAM + 4 CPU

VM3: CentOS with 4 GB RAM + 2 CPU

All running together on the same machine.


# 1. API (Application Programming Interface)

A way to interact with cloud services using code instead of manually using the console.

Example: Using AWS CLI or SDKs to launch an EC2 instance.

# 2. Regions

A geographical location where cloud providers have data centers.

Example: us-east-1 (Virginia), ap-south-1 (Mumbai).

# 3. Availability Zones (AZs)

Each region has multiple isolated data centers called AZs.

They are connected but separate, so if one goes down, others keep running.

# 4. Scalability

The ability to increase or decrease resources (like VMs, storage) based on demand.

Example: Adding more EC2 instances during peak traffic.

# 5. Elasticity

Auto-adjusting resources dynamically to match workload changes.

Example: Auto Scaling in AWS increases instances when traffic is high and decreases them when traffic drops.

# 6. Agility

Ability to quickly develop, test, and deploy applications in the cloud.

Example: Launching a new VM in minutes vs. days in traditional data centers.

# 7. High Availability

Ensuring services remain available with minimal downtime by using multiple AZs, load balancers, etc.

Example: Hosting a website across 3 AZs.

# 8. Fault Tolerance

The system continues working even if part of it fails.

Example: If one server crashes, traffic shifts automatically to healthy servers.

# 9. Disaster Recovery

A strategy to recover data and systems after a major failure (natural disaster, data loss).

Example: Backups in another region for quick restore.

# 10. Load Balancing

Distributes traffic across multiple servers to avoid overloading one server.

Example: AWS Elastic Load Balancer (ELB) spreads traffic across multiple EC2 instances.

# What is Azure devops
Azure DevOps is a set of services that help you manage the entire software development lifecycle (SDLC).  
It integrates CI/CD (Continuous Integration & Continuous Deployment), project tracking, version control, and testing tools.

<img width="1116" height="606" alt="image" src="https://github.com/user-attachments/assets/a21adefe-f9f2-4fe2-8651-fbb29eea7919" />

<img width="979" height="644" alt="image" src="https://github.com/user-attachments/assets/5bbae9fb-e197-488a-aa71-0d32c51f8a8e" />

<img width="1081" height="649" alt="image" src="https://github.com/user-attachments/assets/125dbe96-209b-4bda-ad74-1e8c41ed27b0" />



