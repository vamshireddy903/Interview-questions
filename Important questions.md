# 1. What is Jenkins

Jenkins is open-source automation server widely used for continous integration and continuous delivery. It helps the developers to automate process of building, testing and deploying applications

# Advantages

Jenkins is completely free to use and open source.

Automates the software development lifecycle: build, test, and deploy.

Speeds up software delivery and helps catch bugs early.

Over 1,800 plugins available for integrating with tools like Git, Docker, Maven, Gradle, AWS, Kubernetes, Slack, and more.

Seamlessly integrates with Git, GitHub, Bitbucket, GitLab, and others.

Supports webhooks to trigger builds automatically on code changes.

Supports master-agent architecture.

You can set up build agents on multiple machines for parallel execution and faster builds.

Provides instant feedback on build and test results.

# 2. What is Jenkins master-agent architecture

The Master-Agent architecture in Jenkins is designed to distribute build and deployment tasks across multiple machines, improving scalability, speed, and resource utilization. This model separates the control layer (master) from the execution layer (agents), enabling flexible, scalable, and efficient pipeline execution.
# 1. Jenkins Master (Controller)

Functions:

Orchestration & Coordination: Assigns build jobs to appropriate agents based on labels, availability, and load.

User Interface: Hosts the Jenkins web UI where users configure jobs, view logs, install plugins, and manage credentials.

Configuration Storage: Stores all job configurations (config.xml), credentials, plugin data, and logs.

Job Scheduling: Determines when and how builds should run (manually triggered, cron-based, or event-driven).



# 2. Jenkins Agent (Worker/Node)

A separate machine or container that:

Executes build jobs as assigned by the master

Can be on any OS (Windows, Linux, etc.)

Connects to the master using SSH, JNLP, or Docker

![image](https://github.com/user-attachments/assets/90c06844-e3e5-40fd-81d3-969701ae6b94)

# 3 Explain CI/CD Implementation.

CI/CD stands for Continuous Integration and Continuous Delivery, and it helps automate the process of building, testing, and deploying applications in an easy and consistent way.

We use GitHub as the source code management system and Kubernetes as the target platform for deployment. Jenkins is used as the CI/CD tool, and it is integrated with GitHub through a webhook. 
Whenever a developer commits code to the Git repository, the webhook automatically triggers the Jenkins pipeline.

Here's how the pipeline works:

# CI – Continuous Integration

Whenever a developer pushes code to the GitHub repository, a webhook automatically triggers the Jenkins pipeline. The pipeline has multiple stages:

# Checkout Stage:
Jenkins pulls the latest code from the GitHub repository.

# Build and Unit Testing:
Jenkins compiles the code using tools like Maven or npm, and runs unit tests using tools like JUnit to make sure the code is working as expected.

# Code Scan:
We use SonarQube to perform static code analysis. This checks the code quality and looks for any bugs or security issues.

# Image Build:
Once the code is clean, Jenkins builds a Docker image using the Dockerfile in the project.

# Image Scan:
We scan the built image for vulnerabilities using a tool like Trivy.

# Image Push:
After verification, the image is pushed to Docker Hub (our container registry).

# CD – Continuous Delivery
As part of the Continuous Delivery (CD) phase:

After the Docker image is pushed to the container registry, the Jenkins pipeline automatically updates the Kubernetes manifest files (like deployment.yaml) with the new image tag.

These updated files are pushed to a GitOps repository (a separate Git repo that stores deployment manifests).

Argo CD continuously monitors this GitOps repo.

As soon as Argo CD sees the change:

It automatically syncs the Kubernetes cluster with the updated YAML files.

This way, the latest Docker image is deployed to the cluster.

This entire CI/CD setup helps us deliver applications faster, more reliably, and with reduced manual intervention, by integrating Jenkins for automation and Argo CD for automated deployment to Kubernetes.
