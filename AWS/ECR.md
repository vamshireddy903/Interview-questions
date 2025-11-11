# What is Amazon ECR?  
Amazon Elastic Container Registry (ECR) is a fully managed container image registry by AWS — similar to Docker Hub, but more secure and integrated with AWS.

You use it to store, manage, and pull/push Docker images used by ECS, EKS, or other Kubernetes clusters.

# ⚙️ How ECR fits into a DevOps pipeline

Here’s the real-world flow 👇

Developer pushes code → GitHub

Jenkins or GitHub Actions → builds a Docker image

Image is tagged and pushed → to ECR

ECS / EKS pulls that image from ECR → to run your containerized app

<img width="1011" height="522" alt="image" src="https://github.com/user-attachments/assets/1f5dee49-bbcb-4e88-ae4d-0ee79fdec0c7" />

# 🧩 Basic ECR Workflow  
**1️⃣ Create a Repository**

You create a private or public ECR repository to store your images.

      aws ecr create-repository --repository-name my-app-repo

**2️⃣ Authenticate Docker to ECR**  
You log in so Docker can push/pull images:

    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com

**3️⃣ Build and Tag Docker Image** 

    docker build -t my-app .
    docker tag my-app:latest <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/my-app-repo:latest

**4️⃣ Push Image to ECR**

    docker push <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/my-app-repo:latest

**5️⃣ Pull Image for Deployment**

From ECS, EKS, or anywhere:

    docker pull <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/my-app-repo:latest

# Get the repo name

     aws ecr describe-repositories --query "repositories[0].repositoryName" --output text

# To delete the repo

    aws ecr delete-repository --repository-name <repo-name>
