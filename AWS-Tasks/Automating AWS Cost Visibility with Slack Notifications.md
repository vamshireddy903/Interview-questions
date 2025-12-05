# AWS Cost Optimization — Key Concepts & Best Practices

AWS cost optimization means using AWS resources efficiently so you pay only for what you need, without affecting performance or reliability.

# Below are the most important strategies:

**✅ 1. Right-Sizing Resources**

Most companies over-provision.
- Reduce EC2 instance sizes if CPU/Memory usage is low  
- Downsize RDS instances  
- Move from GP3 to cheaper storage if possible  

👉 Use AWS Compute Optimizer to get right-size recommendations.

**✅ 2. Use Auto Scaling**

Instead of running large instances 24/7:  
- Scale up & down automatically based on traffic  
- Great for EC2, ECS, DynamoDB, Aurora, Lambda concurrency

This avoids paying for unused resources.

**✅ 3. Choose Optimal Pricing Models**

AWS offers different cost-saving models:  
- **On-Demand** → Expensive (use only for unpredictable workload)  
- **Reserved Instances (RI)** → Up to 72% savings for 1–3 year commitment  
- **Savings Plans** → More flexible than RI
- **Spot Instances** → 90% cheaper (ideal for stateless, fault-tolerant apps)

**✅ 4. Use Serverless Where Possible**

Serverless = pay only for actual usage.

AWS Lambda

**API Gateway**    
**DynamoDB On-Demand**    
**EventBridge**    
**S3 for static hosting**   

No servers = no idle cost.

**✅ 5. Optimize Storage Costs**

**S3:**  
- Use lifecycle rules  
- Move old data → Glacier / Deep Archive  
- Enable Intelligent Tiering

**EBS:**  
- Delete unused volumes & snapshots  
- Prefer GP3 instead of GP2

**✅ 6. Use Cost Explorer & Budgets**

Enable:
- AWS Budgets (email alerts when crossing limits)  
- Cost Explorer (see where money is going)  

Tag resources for clarity:  
- Environment=Dev/Test/Prod  
- Project=XYZ  
- Owner=TeamName  

**✅ 7. Use Spot Fleets & Spot + On-Demand Mix**

For ECS/EC2 workloads:  
- Run 70–80% Spot  
- Keep 20–30% On-Demand for reliability  

Huge savings in batch workloads.

**✅ 8. Turn Off Dev/Test Resources**

Most waste happens because dev servers run 24/7.
Use:  
- Instance Scheduler  
- Lambda scripts for automatic start/stop

**✅ 9. Use Load Balancers Efficiently**  
- Delete unused target groups, ALBs, or NLBs  
- Switch to Application Load Balancer instead of classic

**✅ 10. Optimize Data Transfer Costs**

Data transfer is often hidden but expensive:  
- Use CloudFront to cache content  
- Keep services in the same AZ  
- Avoid cross-region traffic  
- Use PrivateLink/VPC Endpoints

# AWS COST OPTIMISATION USING AWS-COST-CLI

**1. Install nodejs on linux**

        https://nodejs.org/en/download

**2 Install AWS cli, AWS cost cli and configure**

    npm install -g aws-cost-cli

**Default Usage -Cost Breakdown by Service**

     aws-cost

• Retrieves total cost breakdown by service.

**Cost Summary (No Service Breakdown)**

    aws-cost --summary

• Displays total cost only, without breakdown.

**Plain Text Output (No colors/tables)**
      
       aws-cost --text

• Outputs the cost report in plain text format.

**JSON Output (For automation)**

    aws-cost --json

• Outputs the cost report in JSON format

**Send Report to Slack (Breakdown Message)**

    aws-cost --slack-token <SLACK_TOKEN> --slack-channel <CHANNEL_ID>

• Sends the cost report directly to a Slack channel.

# SLACK CONFIG

**Step 1: Create a Slack App**   

1. Go to: Slack API: Create App https://api.slack.com/apps  
2. Click: Create New App  
3. Choose: From scratch  
4. App Name: AWS Cost Notifier  
5. Select Workspace: Choose your Slack workspace.
   
**Step 2: Set Slack App Permissions**

1. In your app dashboard:  
2. Go to OAuth & Permissions.  
3. Scroll to Scopes:  
  o Under Bot Token Scopes, add:
   - chat:write → Allows the bot to post messages. 
   - chat:write.public → (Optional) Allows posting in public channels  
   - without being invited.  
   - Files:write → To be able to write to the slack channel  
    
**Step 3: Install the App in Your Workspace**

1. Still in OAuth & Permissions, click Install App to Workspace.  
2. Approve the permissions.  
3. Copy the Bot User OAuth Token:  
  o Starts with xoxb-... → You'll need this for aws-cost-cli.

**Step 4: Find Your Slack Channel ID**

1. Open Slack.  
2. Go to the channel you want to post in.  
3. Click on the channel name at the top → View channel details.  
4. Copy the Channel ID (starts with C...).

**Step 5: Test Slack Integration with aws-cost-cli**  
Run the following command:  

    aws-cost --slack-token xoxb-dcbsdvdsbvvsb --slack-channel C08UUEHEU

Invite the Bot in Slack Channel

/invite @AWS-COST-Report

**1️. Install Python & pip (if not already)**

    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv

**2️. Create a Virtual Environment (Optional but Recommended)**
```
python3 -m venv venv
source venv/bin/activate
```

**1. Install Slack SDK:**
    
    pip install slack-sdk
    
**2 Create Python Script (upload_cost_report.py):**
```
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
slack_token = "xoxb-6800278956247-8805347127382-SQIckF4laKrziI8ODyqARQRA"
client = WebClient(token=slack_token)
try:
 # Use files_upload_v2 (latest method)
 response = client.files_upload_v2(
 channel="C08PVFZV9PF",
 initial_comment="AWS Cost Report",
 file="cost-report.txt"
 )
 print("File uploaded successfully:", response)
except SlackApiError as e:
 print(f"Error uploading file: {e.response['error']}")
```
