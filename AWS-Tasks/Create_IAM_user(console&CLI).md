# Create IAM User with Console & CLI Access

Category: IAM (Users, Groups, Roles, Policies)
Difficulty: Easy
Estimated Time: 20–30 mins

Why This Task Matters:
Secure and manage cloud access effectively using IAM best practices.

Skills Covered:
Create IAM users and groups
Configure console and programmatic access
Implement least privilege principle

Step-by-Step Guide:
Create IAM user with both console and CLI/API access.
Attach policy with minimal required permissions.
Test login and CLI access with new credentials.


# Step 1: Sign in to AWS Management Console

Open the AWS Management Console

Sign in with your root or admin IAM account.

# Step 2: Create a New IAM User

Navigate to IAM → Users → Add users.

Enter a User name (e.g., devops-user).

Under Select AWS access type:

Check AWS Management Console access.

Optionally, set a Custom password or let AWS auto-generate.

Check User must create a new password at next sign-in (optional but recommended for security).

Check Programmatic access (for CLI/API access).

# Step 3: Set Permissions

Choose Attach existing policies directly or Add user to group.

Apply the principle of least privilege:

Start with minimal permissions required.

For learning/testing, you can attach AdministratorAccess temporarily (but avoid in production).

Recommended: Create a custom policy with only needed permissions.
```
{
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListBuckets",
      "Effect": "Allow",
      "Action": ["s3:ListAllMyBuckets"],
      "Resource": "*"
    },
    {
      "Sid": "ListBucketObjects",
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Sid": "ReadObjects",
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::*/*"
    }
  ]
}

```
# What this does:

This prevents creating/deleting buckets or uploading/deleting objects.

User can see all buckets and objects.

# Step 4: Review and Create User

Review user details, access types, and permissions.

Click Create user.

Note down:

Console login URL

Username

Password (if auto-generated)

Access key ID & Secret access key (for CLI/API)

# Step 5: Test Access
Console Access

Open the IAM user login URL.

Log in with the new username and password.

Verify you can only access permitted services.
<img width="1862" height="887" alt="image" src="https://github.com/user-attachments/assets/b9493bd1-b164-4e4b-99ee-033a49a4d2f1" />
<img width="1920" height="853" alt="image" src="https://github.com/user-attachments/assets/49d97870-b862-4f46-8268-5acd16b9643f" />

CLI Access

Install and configure AWS CLI if not already installed:

aws configure


Enter:

Access Key ID

Secret Access Key

Default region (e.g., us-east-1)

Default output format (e.g., json)
<img width="1885" height="557" alt="image" src="https://github.com/user-attachments/assets/1a5b3edd-e911-4f7a-a82c-a61ae7383fc1" />

# Creating IAM user through AWS CLI
===================================================================================

# Step 1: Create the IAM User

     aws iam create-user --user-name test
     
# Step 2: Create Console Login Credentials
```
aws iam create-login-profile \
    --user-name devops-user \
    --password 'YourTempPassword123!' \
    --password-reset-required
```

--password-reset-required forces the user to change the password on first login.

# Step 3: Create Access Keys for CLI

    aws iam create-access-key --user-name Test

  <img width="711" height="343" alt="image" src="https://github.com/user-attachments/assets/3eb99804-3c5b-46bf-8497-0f49816605ce" />

# Step 4: Create a Minimal Policy

For example, S3 read-only acces

create a sudo vim s3-read-only.json and paste below policy
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListBuckets",
      "Effect": "Allow",
      "Action": ["s3:ListAllMyBuckets"],
      "Resource": "*"
    },
    {
      "Sid": "ListBucketObjects",
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Sid": "ReadObjects",
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::*/*"
    }
  ]
}

```

# Step 5: Attach the Policy
```
 Attach as an inline policy to the user

aws iam put-user-policy \
  --user-name Test \
  --policy-name S3ReadOnlyPolicy \
  --policy-document file://s3-ready-only.json

```
# Step 6: Test Access

CLI
aws configure
# Enter Access Key ID, Secret Access Key, default region, output format


Test:

# Should succeed
    aws s3 ls

# Should fail (AccessDenied)
    aws s3 mb s3://test-bucket
<img width="1894" height="208" alt="image" src="https://github.com/user-attachments/assets/874492a2-e31f-4945-bb54-063e2d0425d5" />
