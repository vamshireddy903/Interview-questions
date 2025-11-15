# What is Aurora Serverless?

Aurora Serverless = Database that automatically scales up and down based on workload.

**Key features:**

- No need to choose instance size  
- Auto-pause when not in use → saves cost
- Scales in seconds
- You pay only for actual usage (ACUs)

👉 Simple meaning:

“On-demand, autoscaling Aurora DB with no fixed servers.”

**When to use:**
Development, testing  
Unpredictable workloads  
Apps with inconsistent traffic  

# 2. What are Read Replicas?

Read replicas are copies of your primary database used for:

- Read scalability (more read performance)  
- Offloading heavy SELECT queries  
- Analytics/reporting workloads  

Read replicas do NOT:  
Provide high availability like Multi-AZ
Automatically failover (except Aurora)  

👉 Simple meaning:

“Extra DBs to handle read traffic.”

#  3. Failover

Failover = automatic switch from primary DB to standby/read replica when:

- Primary DB crashes  
- Network issue
- AZ failure  
- Maintenance/patching

RDS (non-Aurora):

⏳ Takes 1–2 minutes  
Switches to standby (Multi-AZ)  
Read replicas do NOT auto failover  

Aurora:

⚡ Fast failover (2–30 seconds) 
Switches to an existing reader automatically  
