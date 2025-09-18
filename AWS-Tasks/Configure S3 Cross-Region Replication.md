# 🎯 Objective

Replicate objects automatically from one S3 bucket (source) in one region to another S3 bucket (destination) in a different region.

Why This Task Matters:
Ensure data durability and availability in multi-region architectures.

Skills Covered:
Enable bucket versioning
Setup replication with IAM role
Test replication and verify bucket contents

Step-by-Step Guide:
Create two buckets in different regions with versioning
Configure replication rule and required permissions
Upload files and verify replication


# 🛠 Step-by-Step Guide
1. Create Two Buckets in Different Regions

Go to AWS Management Console → S3 → Create bucket.
<img width="1425" height="535" alt="image" src="https://github.com/user-attachments/assets/47ed9665-f2b6-423b-bee1-07d05dee9f6d" />

# 2. Enable Versioning on Both Buckets

Open each bucket → Properties → Bucket Versioning → Enable.

Replication requires versioning on both source and destination.

# Create an IAM Role for Replication

Go to AWS Console → IAM → Roles → Create role.

Trusted entity → Choose S3 (because S3 will assume this role).

Finish and name the role, e.g. s3-crr-replication-role.

# How to add the custom replication policy (console)

In IAM console, after creating the role, go to:

IAM → Roles → your-role-name → Permissions → Add permissions → Create inline policy.

Choose JSON tab.

Paste the replication policy JSON (with your bucket ARNs).

Save it.

<img width="1880" height="782" alt="image" src="https://github.com/user-attachments/assets/6f2c7a65-7993-4578-9066-0511298f1204" />

<img width="1842" height="661" alt="image" src="https://github.com/user-attachments/assets/fba203c3-8aef-4126-ad8a-b7270a73a072" />

attach below one:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::sourcebuket-in-mumbai-region-1234"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionTagging"
      ],
      "Resource": "arn:aws:s3:::sourcebuket-in-mumbai-region-1234/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Resource": "arn:aws:s3:::destination-bucket-in-n.virginia-1234/*"
    }
  ]
}
```
Now your role has:

Trust policy (S3 can assume role).

Permissions policy (role can replicate objects between buckets).

When you configure the Replication rule on the source bucket (sourcebuket-in-mumbai-region-1234), choose this role.

# 4. Configure the Replication Rule

Go to Source bucket → Management → Replication rules → Create rule.

Steps:

Name rule: replicate-to-destination

Choose replication destination bucket: destination-bucket-in-n.virginia-1234.

Select IAM Role (either auto-create or existing one).

Scope: Entire bucket (or a specific prefix/tags if needed).

Enable rule.

Save

<img width="1889" height="660" alt="image" src="https://github.com/user-attachments/assets/7552b25e-52f4-4974-b824-0284c9f99bca" />

<img width="1908" height="836" alt="image" src="https://github.com/user-attachments/assets/7140db64-81f6-4de9-91c3-b42169ed2459" />

# Verify Replication

Upload a file to the source bucket.

Wait a few minutes (replication isn’t instant).

Go to destination bucket → you should see the same object appear there.
