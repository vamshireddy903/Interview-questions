In Terraform, lifecycle rules control how Terraform manages resources during create, update, and destroy operations.

Lifecycle rules are written inside the resource block:
```
resource "aws_instance" "example" {
  ami           = "ami-123"
  instance_type = "t2.micro"

  lifecycle {
    # rules go here
  }
}
```

# 🟦 Types of Terraform Lifecycle Rules

 **1️⃣ create_before_destroy**

Ensures Terraform creates a new resource before destroying the old one.

**Why?**

To avoid downtime.

**Example:**
```
lifecycle {
  create_before_destroy = true
}
```

**Useful for:**
- Load balancers  
- Auto scaling launch templates  
- VPC subnets  
- DNS records

# 2️⃣ prevent_destroy

Prevents Terraform from accidentally destroying a resource.

Example:
```
lifecycle {
  prevent_destroy = true
}
```

If someone runs terraform destroy, it fails for this resource.

**Used for:**

- Production databases  
- S3 buckets  
- VPC  
- Critical IAM roles

# 3️⃣ ignore_changes

Tells Terraform to ignore certain updates in a resource — useful when AWS modifies attributes automatically.

Example:
```
lifecycle {
  ignore_changes = [
    tags,
    instance_type,
    user_data,
  ]
}
```

Terraform won't update if only these attributes change.

**Common use cases:**

- EC2 UserData (AWS often stores it in encoded form)  
- Autoscaling groups modify tags automatically  
- EKS modifies security groups  
- Lambda writes its own environment variables

# More ignore_changes Example

Example: Ignore only tags:
```
lifecycle {
  ignore_changes = [tags]
}
```
Example: Ignore all changes:
```
lifecycle {
  ignore_changes = all
}
```

# 4️⃣ replace_triggered_by (Terraform v1.2+)

Forces a resource replacement when another resource changes.

Example:
```
lifecycle {
  replace_triggered_by = [
    aws_subnet.main.id,
    aws_vpc.main
  ]
}
```

Meaning:

If VPC or Subnet changes → recreate this resource.

Useful for:

- EC2 instances  
- EBS volumes  
- Load balancers  
