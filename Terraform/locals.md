# locals

locals are used to define reusable values inside your Terraform configuration.

**Why do we use locals?**

- Avoid repeating values  
- Improve readability  
- Centralize naming conventions  
- Make code clean and maintainable  
- They do not create resources and do not affect state.

<img width="896" height="442" alt="image" src="https://github.com/user-attachments/assets/e531564e-62d8-49f3-95b0-37ae4cdd2cdd" />

# Real DevOps Use Cases

**1️⃣ Naming convention (most common)**
```
locals {
  project = "ecommerce"
  env     = "prod"
}

name = "${local.project}-${local.env}-alb"
```

**2️⃣ Reusing common tags**
```
locals {
  common_tags = {
    Project = "ecommerce"
    Env     = "prod"
    Owner   = "devops"
  }
}
```
```
resource "aws_instance" "web" {
  tags = local.common_tags
}
```

**3️⃣ Conditional logic**
```
locals {
  instance_type = var.env == "prod" ? "t3.large" : "t3.micro"
}
```
