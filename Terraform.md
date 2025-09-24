# terraform init

It sets up the working directory so Terraform can manage infrastructure. Here's exactly what it does:

# 1. Initializes the Backend

If your Terraform configuration uses a backend (e.g., S3, Azure Storage, GCS), terraform init configures it.  
Example: storing Terraform state remotely in S3 for collaboration.

# 2. Downloads Provider Plugins

Terraform works with providers (like AWS, Azure, GCP, Kubernetes) to manage resources.  
terraform init downloads the required provider plugins defined in your configuration (provider "aws" { ... }).

# 3. Sets Up Modules

If your configuration uses modules (local or remote), it downloads and prepares them.  
Example: module "vpc" { source = "terraform-aws-modules/vpc/aws" ... }

# 4. Prepares the Working Directory

Creates the .terraform/ directory to store plugins, modules, and cache.  
Checks for configuration validity (basic syntax and required files).

# 5. Optional Flags

-backend=false → Skip backend initialization.  
-reconfigure → Reinitialize backend configuration.  
-upgrade → Upgrade provider versions.

# What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool by HashiCorp.  
It allows you to define infrastructure (VMs, networks, storage, databases, Kubernetes, etc.) in code (.tf files).  
Same code can be used to create infra in AWS, Azure, GCP, Kubernetes, Docker, etc.  

# 2. Terraform Workflow

This is the heart of Terraform. You should remember this always:

Init – `terraform init`  
→ Downloads the provider plugins (like AWS, Azure).

Plan – `terraform plan`  
→ Shows what will be created/changed/destroyed.

Apply – `terraform apply`  
&rarr; Actually creates the resources.

Destroy – `terraform destroy`  
→ Deletes all infra defined in code.

👉 Think of it like: Init → Dry Run → Apply → Clean Up.

# Providers

Providers are plugins that let Terraform talk to APIs (AWS, Azure, GCP, Kubernetes, Docker, etc.).  
Example for AWS provider:
```
provider "aws" {
  region = "us-east-1"
}
```

# File Structure

Terraform uses .tf files (HCL = HashiCorp Configuration Language).

Typical structure:

main.tf        → main resources  
variables.tf   → input variables  
outputs.tf     → output values  
providers.tf   → provider configs (AWS, GCP, etc.)  
terraform.tfstate → state file (DO NOT EDIT manually)  

# Input Variables

Input variables let you pass values into Terraform instead of hardcoding them.  
Declared in variables.tf and values can be provided via terraform.tfvars

Example – variables.tf

```
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

```
Example – terraform.tfvars
```
region        = "us-west-2"
instance_type = "t3.micro"
```

Usage in main.tf

```
provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  tags = {
    Name = "EC2WithVariables"
  }
}
```
💡 Tip: Variables make your code configurable for dev, staging, prod environments.

# Output Variables

Output variables let Terraform return values after apply.  
Useful for sharing info like public IP, DNS name, or VPC ID.

Example – outputs.tf
```
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_ec2.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}
```
<img width="868" height="676" alt="image" src="https://github.com/user-attachments/assets/39a4f1d8-45e2-4a5b-aff3-419be969e0df" />

<img width="839" height="730" alt="image" src="https://github.com/user-attachments/assets/1dc34b48-db22-4d7e-ab70-bf5db84887a5" />


# 1. You have created five EC2 instances using Terraform. Now you want to delete only one specific instance without deleting the others. How will you do it?
   Let say you have creatd EC2 instances using for_each
```
 resource "aws_instance" "multiple" {
  for_each = toset(["1", "2", "3", "4", "5"])

  ami           = ""
  instance_type = ""

  tags = {
    Name = "Server-${each.value}"
  }
}
```
   <img width="692" height="701" alt="image" src="https://github.com/user-attachments/assets/fc4a8bad-352f-4fda-933b-1b1f2c67b8bb" /> 
   <img width="589" height="756" alt="image" src="https://github.com/user-attachments/assets/55dc52bf-2434-498f-9fe3-b6891a6a25b7" />
   <img width="850" height="485" alt="image" src="https://github.com/user-attachments/assets/2f914cb9-a608-4123-889b-170e970aa851" />



# 2. Creating multiple serves using count meta argument

Using count

- Creates N instances of a resource.  
- Index is available as count.index.  
```
     resource "aws_instance" "multiple" {
     ami=""
     instance_type = ""
    count = 5
    tags ={
    Name = "Server-${count.index}"
    } 
    }
```
  Refer: https://developer.hashicorp.com/terraform/language/meta-arguments/count   

# Using for_each

- Used when you have a map or set of strings instead of numeric count.
- Gives named instances instead of index numbers.

Example – Create EC2s with named tags:
```
variable "servers" {
  default = {
    app1 = "t2.micro"
    app2 = "t3.micro"
  }
}

resource "aws_instance" "web" {
  for_each      = var.servers
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
```

Creates two EC2s: app1 with t2.micro and app2 with t3.micro

💡 Tip:
- Use count for identical resources.  
- Use for_each when you need custom names or different attributes per resource

# What is a Module?

- A module is a folder with Terraform files that encapsulates a set of resources.  
- Reusable: You can call it multiple times with different inputs.  
- Terraform itself is built on modules; main.tf in your project is considered the root module.

# How to Create Reusable Modules  
Example: EC2 Module

# Folder structure:

modules/
└── ec2/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf


modules/ec2/variables.tf
```
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use"
}

variable "instance_name" {
  type        = string
  description = "Name tag for EC2 instance"
}
```

modules/ec2/main.tf
```
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}

```
modules/ec2/outputs.tf

```
output "instance_id" {
  value = aws_instance.this.id
}
```

# How to Use a Module

In your root module (main.tf):
```
module "web_server" {
  source        = "./modules/ec2"
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  instance_name = "WebServer1"
}
```
```
module "web_server2" {
  source        = "./modules/ec2"
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  instance_name = "WebServer2"
}
```

source can be local path, Git repo, or Terraform Registry.

Each module instance is isolated, can have different inputs.

# Using Public Modules from Terraform Registry

Terraform Registry hosts ready-made modules for AWS, Azure, GCP, Kubernetes, etc.

Example: Using AWS VPC module

```
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}
```

✅ Saves time, avoids reinventing the wheel.

# Organizing Infrastructure as Modules

Best practice: split by logical components

terraform-project/
├── main.tf         # root module
├── variables.tf
├── outputs.tf
├── modules/
│   ├── network/
│   │   └── main.tf, variables.tf, outputs.tf
│   ├── ec2/
│   │   └── main.tf, variables.tf, outputs.tf
│   └── eks/
│       └── main.tf, variables.tf, outputs.tf


Each module manages one logical component (VPC, EC2, EKS, etc.).

Makes multi-environment setup easy (dev, staging, prod) by passing different variable values.

# Handling State Drift

State drift happens when the real-world infrastructure changes outside Terraform (manual changes in AWS console, scripts, etc.).

How to detect drift:

     terraform plan

Terraform compares actual resources vs state file and shows differences.

# How to fix drift:

- Import existing resources into Terraform state:

    terraform import aws_instance.my_ec2 i-0123456789abcdef0


- Manually update configuration to match the real infra.

- Avoid manual changes — enforce IaC workflow.

💡 Tip: Use remote state (S3 + DynamoDB) for teams to prevent conflicting changes.

# Lifecycle Rules

Lifecycle rules control resource creation, update, and deletion behavior.

# a) create_before_destroy

- Creates new resource before destroying old one.  
- Useful for immutable infra or zero-downtime deployments.

```
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}
```
# b) prevent_destroy

Prevents accidental deletion of critical resources.

```
resource "aws_s3_bucket" "critical" {
  bucket = "important-bucket"

  lifecycle {
    prevent_destroy = true
  }
}
```

# Terraform with Jenkins / GitHub Actions (CI/CD)  
# a) Jenkins

Use Case: Automate provisioning infrastructure when code changes or on schedule.

Typical Jenkins Pipeline:

```
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
```

✅ Benefits: automated, repeatable infra, integrates with source control and approvals.

# b) GitHub Actions

Similar flow in YAML .github/workflows/terraform.yml:

```
name: Terraform CI/CD

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
      - name: Terraform Init
        run: terraform init
      - name: Terraform Plan
        run: terraform plan
      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
```

✅ Benefits: Integrates with Git, allows PR-based plan approvals, runs on cloud-hosted runners.
  
 # Terraform + Kubernetes (EKS, Helm Provider)

Terraform can provision Kubernetes clusters and deploy workloads.

# a) EKS Cluster

```
provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.28"
  subnets         = ["subnet-123", "subnet-456"]
  vpc_id          = "vpc-123"
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}
```
# b) Helm Provider

Terraform can install Helm charts in EKS:

```
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "13.2.0"
  namespace  = "default"
}
```
✅ This allows full GitOps-style deployments with Terraform managing both infra (EKS) and apps (Helm charts).

# Code Modularization & DRY (Don’t Repeat Yourself)

- Split your Terraform code into logical modules: network, compute, storage, Kubernetes, etc.  
- Avoid repeating similar resources; use modules, variables, and for_each/count.

Example:
Instead of writing 3 EC2 resources manually, use a module with for_each:

```
module "web_server" {
  source        = "./modules/ec2"
  for_each      = var.servers
  ami_id        = each.value.ami
  instance_type = each.value.type
  instance_name = each.key
}
```

#  Benefits:

- Easier maintenance  
- Reusable across environments (dev/staging/prod)
- Cleaner, readable code

#  Store Secrets Securely

- Never store sensitive info in .tfvars or Git.  
- Use secure storage like:  
   - AWS SSM Parameter Store or AWS Secrets Manager  
   - HashiCorp Vault

Example – Fetch secret from SSM:

```
data "aws_ssm_parameter" "db_password" {
  name = "/prod/db/password"
  with_decryption = true
}
```
```
resource "aws_db_instance" "mydb" {
  identifier = "mydb"
  password   = data.aws_ssm_parameter.db_password.value
}
```

# Benefits:

- Secrets are encrypted at rest  
- No hardcoding sensitive info in repo

# Naming Conventions & Tagging

- Use consistent naming conventions for:  
   - Resources: env-type-purpose (e.g., prod-ec2-web01)
   - Variables: vpc_cidr, instance_type
   - Outputs: vpc_id, public_ip

Tags Example:

```
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name        = "webserver-1"
    Environment = "dev"
    Owner       = "devops-team"
  }
}
```

# Benefits:

- Easier resource identification in AWS console  
- Enables cost tracking & automation

# Version Pinning for Providers & Modules

Always pin provider versions and module versions to avoid breaking changes in future Terraform updates.

Example – Provider version pinning:

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.0"
}

```
# Module version pinning:

```
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"
  name    = "my-vpc"
  cidr    = "10.0.0.0/16"
}
```

# Benefits:

- Prevents breaking changes when Terraform updates
- Ensures consistent builds across environments

💡 Summary of Best Practices

- Modularize code, use DRY principle
- Store secrets securely, never in Git or tfvars
- Use consistent naming & tagging for resources
- Pin provider and module versions

# 3. You want to launch an EC2 instance using a Terraform-created SSH key pair. How will you achieve this securely and ensure you can SSH into the instance later?

```
# Generate the private key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


#Uplod the public key to AWS
resource "aws_key_pair" "TF_key" {
  key_name   = "TF-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

#save the private key to file
 resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "key-pair.pem"
}

# Launch the ec2 using the key pair
resource "aws_instance" "my_ec2" {
    ami= "ami-0f918f7e67a3323f0"
    instance_type ="t2.micro"
    key_name= aws_key_pair.TF_key.key_name

tags = {
 Name ="My-EC2"
 
}
}
```
Reference: https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
           https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
           https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file.html

<img width="1159" height="313" alt="image" src="https://github.com/user-attachments/assets/a69f8d8c-3abc-4299-b119-c13d27bf73f0" />

# 4. In Terraform, how do you make sure one resource is created only after another one is successfully created?

Terraform automatically creates an implicit dependency between resources when one resource refers to another (e.g., using resource.attribute).
But if there's no direct reference, and you still want to control the order, you can use depends_on.

```# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-terraform-1234"
}

# Create an EC2 instance that should launch only after the S3 bucket
resource "aws_instance" "my_ec2" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  depends_on    = [aws_s3_bucket.my_bucket]

  tags = {
    Name = "My-EC2"
  }
}
```
<img width="1014" height="257" alt="image" src="https://github.com/user-attachments/assets/4a98a70e-8862-4745-935a-a30ebe924248" />

# 5 Write a terraform code to create the RDS 

```
resource "aws_db_instance" "My_rds" {

    engine = "mysql"
    engine_version = "8.0"
    allocated_storage = "10"
    storage_type = "gp2"
    instance_class = "db.t3.micro"
    db_name = "mydb"
    username = "admin"
    password = "password123"
    skip_final_snapshot = true
    publicly_accessible = true
}
```

#  What is Remote Backend in Terraform?
A backend in Terraform defines how and where Terraform stores its state file (terraform.tfstate).

By default, Terraform stores the state locally on your machine.

✅ Remote backend stores the state file in a remote location like:
AWS S3

Terraform Cloud

Azure Blob Storage

Google Cloud Storage


# 🔒 Why Remote Backends Are Important:
Collaboration – Teams can share the same state file.

Safety – Keeps state out of local machines (less risk of loss).

Versioning – Some backends (like S3) support versioning and recovery.

Locking – Prevents multiple users from applying changes at the same time (see next section).

# 🔐 What is State Locking in Terraform?
State locking is a mechanism that ensures:

Only one person or process can change the state file at a time.

✅ Purpose:
Prevent race conditions when two people try to run terraform apply at the same time.

Avoid corrupted or inconsistent infrastructure changes.

```
# Create a S3 bucket

resource "aws_s3_bucket" "bucket" {
    bucket = "aws-s3my-bucketing6752"  

}

#Encryption at rest
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

#Creating DynamoDB table

resource "aws_dynamodb_table" "table" {
  name         = "Dynamo-db-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```
# Backend

```
terraform {
  backend "s3" {
    bucket = "aws-s3my-bucketing6752"
    dynamodb_table = "Dynamo-db-state-locking"
    key = "statelocking/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
        
  }
}
```

# 1. terraform init -migrate-state
🔄 Purpose:
Used when you're changing backends (e.g., from local to S3) and want to move the existing state to the new backend.

🧠 What It Does:
Migrates your existing terraform.tfstate from the current backend (e.g., local) to the new one (e.g., S3).

Keeps your infrastructure state consistent during the move.

📦 Use Case:

 ```
# You updated your backend config:
terraform {
  backend "s3" {
    bucket = "my-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
```

 Then run

         terraform init -migrate-state
# ✅ 2. terraform init -reconfigure
🔄 Purpose:
Used when you want to reinitialize the backend without migrating state.

🧠 What It Does:
Re-initializes Terraform from scratch

Accepts the current backend config as-is

Does not attempt to move existing state (unlike -migrate-state)

📦 Use Case:
You deleted or changed the backend config (e.g., removed S3 backend)

Or you just want to reset the backend setup

# ✅ 3. terraform refresh
🔄 Purpose:
Used to update your Terraform state file to match the real infrastructure.

🧠 What It Does:
Queries cloud providers (e.g., AWS, Azure) for the current status of your resources

Updates terraform.tfstate with latest real-world data

Does not apply changes or alter .tf files

📦 Use Case:
Infra was changed outside Terraform

You need to detect drift or recover accurate state

🆕 Newer Alternative:

    terraform apply -refresh-only

<img width="1108" height="719" alt="image" src="https://github.com/user-attachments/assets/e27e0748-1ea8-4b56-9def-8a1c8a860f59" />

