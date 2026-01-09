Terraform variables are used to pass input values into your configuration.

**Why do we use variables?**

- Avoid hard-coding values  
- Reuse same code in multiple environments  
- Make infrastructure configurable  
- Enable CI/CD & automation

# Basic Variable Definition
 ```
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
```

Use it like:
```
provider "aws" {
  region = var.region
}
```

# Ways to Pass Variable Values (Very Important)

**1️⃣ Default value (optional)**

    default = "ap-south-1"

**2️⃣ terraform.tfvars**
```
region = "us-east-1"
env    = "prod"
```
**3️⃣ Custom tfvars file**

    terraform apply -var-file=prod.tfvars

4️⃣ CLI
  
    terraform apply -var="region=us-west-2"

5️⃣ Environment variables

    export TF_VAR_region=ap-south-1
