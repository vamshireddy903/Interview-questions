# Objective

Enable CloudTrail to capture all API activity in your AWS account and store the logs in an S3 bucket for auditing, compliance, and troubleshooting purposes.

# Step 1: Create or Enable CloudTrail

Go to the AWS Management Console → CloudTrail.

Click Trails → Create trail.

Enter a Trail name (e.g., AuditTrail).

Apply trail to all regions (recommended for account-wide tracking).

For Management events, choose All (or Read/Write as required).

Optionally enable Insights events (detect unusual API activity).

Click Next.

# Step 2: Choose/Create S3 Bucket for Logs

Under Storage location, select Create new S3 bucket or choose an existing one.

Give it a name like cloudtrail-audit-logs-<your-name>.

Enable Server-side encryption (SSE) for security.

Optionally enable S3 bucket logging to track who accesses the bucket.

Click Next.

CloudTrail will automatically create the proper bucket policy to allow delivery of logs to this bucket.

# Step 3: Configure Additional Options

Optionally configure CloudWatch Logs integration for real-time monitoring.

Click Next, then Create trail.

Your trail is now active and logs all API activity in the account.

# Step 4: Test and Verify

Perform an AWS action like creating an S3 bucket or launching an EC2 instance.

Go to your S3 bucket → navigate to the AWSLogs/<AccountID>/CloudTrail/ folder.

You should see JSON log files with details of the API calls, including:

Event time  
Event name  
User identity  
Source IP  
AWS service  
