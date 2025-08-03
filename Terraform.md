# 1. You have created five EC2 instances using Terraform. Now you want to delete only one specific instance without deleting the others. How will you do it?
   Let say you have creatd EC2 instances using for_each
   
   <img width="692" height="701" alt="image" src="https://github.com/user-attachments/assets/fc4a8bad-352f-4fda-933b-1b1f2c67b8bb" />
   <img width="589" height="756" alt="image" src="https://github.com/user-attachments/assets/55dc52bf-2434-498f-9fe3-b6891a6a25b7" />
   <img width="850" height="485" alt="image" src="https://github.com/user-attachments/assets/2f914cb9-a608-4123-889b-170e970aa851" />



# 2. Creating multiple serves using count meta argument

     resource "aws_instance" "multiple" {
     ami=""
     instance_type = ""
    count = 5
    tags ={
    Name = "Server-${count.index}"
    } 
    }

 Refer: https://developer.hashicorp.com/terraform/language/meta-arguments/count   
 
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


