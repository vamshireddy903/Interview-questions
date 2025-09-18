# VPC Peering

VPC peering allows two VPCs to communicate with each other as if they are on the same network, using private IP addresses. This is useful when you have separate VPCs in the same or different AWS accounts and want resources to communicate without going through the public internet.

# Key points:

**Peering is one-to-one**. If you want multiple VPCs connected, you need multiple peering connections or use a Transit Gateway.  
Traffic is private and never traverses the internet.  
Peering works across regions (inter-region) or within the same region (intra-region).  

<img width="845" height="345" alt="image" src="https://github.com/user-attachments/assets/86bd0297-6653-4ffb-834e-6d7c8ad337d0" />

for more info: https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html

# Why This Task Matters: 
Learn secure, scalable connectivity between isolated networks. 

# Skills Covered: 
Create VPC peering connection  
Modify route tables to enable traffic  
Test connectivity between VPCs  

# Step-by-Step Guide:  
Request VPC peering from VPC A to B  
Update route tables and security groups  
Verify communication via ping or other tools
