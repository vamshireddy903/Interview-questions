# Create Cross-Account IAM Role and Test Access

#  Objective

Set up a cross-account IAM role in Account A that can be assumed by Account B, and test access to ensure correct configuration.

# Steps:
# 1. Create IAM Role in Account A (Resource Account)

Go to IAM → Roles → Create role.

Select Another AWS account.

Enter Account B’s Account ID (the account that should assume this role).

 Add an External ID for security.(eg: Projectclient1123)

Click Next.

Your aws will automatically generate trust policy which looks below
```{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::337909739111:root"
      },
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "ClientProject123"
        }
      }
    }
  ]
}
```


<img width="1915" height="803" alt="image" src="https://github.com/user-attachments/assets/4c41b47a-147a-4368-bb6b-66677599fc96" />

<img width="1899" height="854" alt="image" src="https://github.com/user-attachments/assets/11360e69-a89a-45a0-8bed-71fc5126163a" />

Save and create the role (e.g., CrossAccountS3ReadOnlyRole)

# 2. Attach Permissions Policy

Attach a policy to define what the role can do.
For example, allow read-only S3 access:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": "*"
    }
  ]
}

```

# 3. Assume Role from Account B (Caller Account)
 Using AWS CLI

Run this in Account B’s CLI session:
```
aws sts assume-role \
  --role-arn arn:aws:iam::<AccountA-ID>:role/CrossAccountRole \
  --role-session-name test-session \
  --external-id ClientProject123
```

# What this does

It asks AWS STS (Security Token Service) to give you temporary credentials by assuming a role in another account.

After running, AWS will return:

AccessKeyId

SecretAccessKey

SessionToken

These credentials are valid for a short time (default 1 hour) and let you act as that role.

Basically, it lets Account B’s user step into Account A’s role and use its permissions.

<img width="792" height="509" alt="image" src="https://github.com/user-attachments/assets/8b0ae618-c3bd-4643-ab4b-9a3bb81bae7d" />

<img width="757" height="491" alt="image" src="https://github.com/user-attachments/assets/49e279bf-e109-4d31-a725-547695de5ab8" />

Now you can export these temporary credentials and make AWS CLI calls as if you were in Account A

```
export AWS_ACCESS_KEY_ID=ASIA...
export AWS_SECRET_ACCESS_KEY=wJalr...
export AWS_SESSION_TOKEN=FQoGZXIvYXdzE...
```
# Test

# List the buckets
    aws s3 ls

  You should see the list of buckets in Account A.

  
# test listing objects from a specific bucket:

    aws s3 ls s3://your-bucket-name

# Upload file

    aws s3 cp test.txt s3://your-bucket-name/

This should throw an "Access Denied" error

# Download a Whole Bucket

If you want to download all files from a bucket or a folder in S3:

    aws s3 cp s3://my-bucket/ </path/to/download> --recursive

  # Get the object or list the objects

      aws s3 ls s3://<bucket name>

  # Create a bucket

       aws s3 mb s3://<bucket name>

  # Download a object

      aws s3 cp s3://my-bucket/example.txt .

  # Put object or upload a file

      aws s3 cp <file name> s3://<bucket name>

  # Delete a object

       aws s3 rm s3://<bucket-name>/<object-key>

 Example
# Delete a single file called example.txt from a bucket my-bucket:

     aws s3 rm s3://my-bucket/example.txt

# Delete All Files in a Bucket or Folder
To delete all objects recursively from a bucket or a folder:

    aws s3 rm s3://my-bucket/ --recursive

 # Delete an Empty Bucket
    
    aws s3 rb s3://<bucket-name>
    
rb = remove bucket

Example:
     
     aws s3 rb s3://my-bucket

# Delete a Bucket and All Its Contents
If the bucket is not empty, you can use the --force flag to delete all objects and then the bucket:

    aws s3 rb s3://my-bucket --force

This will:

Delete all objects inside the bucket.

Delete the bucket itself.
