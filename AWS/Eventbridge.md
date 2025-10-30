# Amazon EventBridge :

Amazon EventBridge is a serverless event bus service from AWS that helps you connect different AWS services, your own applications, or SaaS applications using events.

Think of it like a “smart event router” — it listens for events from different sources (like EC2, S3, Lambda, etc.) and automatically triggers actions (like running a Lambda, Step Function, or sending a message to SNS/SQS).

🧠 Simple Definition:

EventBridge is a service that lets AWS resources and your applications communicate asynchronously using events.

# ⚙️ Example Use Cases

**1. Trigger Lambda on EC2 Start/Stop**  
- EventBridge listens for EC2 state change events.  
- When an instance stops → EventBridge triggers a Lambda → Lambda sends Slack/Email alert.

**2. Schedule Tasks**  
- Use EventBridge rules as cron jobs to run Lambdas every hour/day/etc.  
- Example: run cleanup job every midnight.

**3. CI/CD Notifications**  
- When a CodePipeline fails → EventBridge detects the event → sends message to SNS or Slack.  

**4. Integrate Multiple Services**
- Example: When an S3 file is uploaded, trigger a Lambda that writes metadata to DynamoDB.

  <img width="917" height="410" alt="image" src="https://github.com/user-attachments/assets/65ceaedf-7fea-45f4-876b-d20882512915" />

  <img width="588" height="400" alt="image" src="https://github.com/user-attachments/assets/46fe6a4e-acd2-4a10-abae-570139c8d2a8" />

# Task

**configure an email notification when an EC2 event (like start, stop, terminate) occurs — without writing any code — using Amazon EventBridge + Amazon SNS.**

**🪄 Goal**

Get an email alert whenever an EC2 instance stops or terminates.

**🧭 Step-by-Step Setup**

# Step 1️⃣: Create an SNS Topic

**1.** Go to **Amazon SNS Console** → **Topics** → **Create topic**

**2.** Choose:  
- **Type:** Standard  
- **Name:** ec2-alerts-topic  
**3** Click **Create topic**  
**4.** Inside the topic, click **Create subscription**  
- **Protocol:** Email  
- **Endpoint:** your email address  
**5.** Check your inbox → Confirm the subscription (click the confirmation link).

# Step 2️⃣: Create an EventBridge Rule

**1.** Go to **Amazon EventBridge** Console  
**2.** Click Rules → Create rule  
**3.** Give it a name like EC2StopNotification   
**4.** Under **Event source,** select:  
**- Event Source:** AWS events or Event pattern
**- Event pattern:** AWS services → **EC2** → **EC2 Instance State**-**change Notification**

**5.** In **Event pattern preview**, you’ll see something like:
```
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["stopped", "terminated"]
  }
}
```

This means the rule triggers when an instance **stops** or **terminates**.

**6.** Click **Next**

# Step 3️⃣: Add Target

**1.** In Select **target type**, choose **SNS topic**  
**2.** Select the SNS topic you created earlier (ec2-alerts-topic)  
**3.** Click **Next** → **Next** → **Create rule**

# Step 4️⃣: Test It

- Stop or terminate any EC2 instance.  
- Within a few seconds, you’ll receive an email notification from SNS 🎉

