# enkins Architecture Explained

Jenkins follows a Master–Agent (Controller–Node) architecture.

**1. Jenkins Controller (Master)**

The Controller is the brain of Jenkins.

**Responsibilities:**
- Stores Jenkins configuration, build history, plugins, and job definitions  
- Manages and schedules jobs  
- Sends build tasks to agents  
- Monitors the agents  
- Provides the web UI  
- Handles credential management, plugin management, and project orchestration

**2. Jenkins Agent (Node)**

Agents are worker machines where actual builds run.

**Roles:**
- Execute builds assigned by controller
- Can run on Linux, Windows, Containers, Kubernetes pods, etc.
- Reduce load from controller

**Advantage of using agents:**
- Distributes workload  
- Avoids overloading Jenkins master  
- Allows multiple OS and environments  

**Types of agents:**

**Static Agents** – permanently connected  
**Dynamic Agents** – created on-demand using:

- Kubernetes plugin (pods)  
- AWS EC2 plugin  
- Docker agents

<img width="639" height="286" alt="image" src="https://github.com/user-attachments/assets/2ea60e05-5b21-498d-ba9d-7d4d64cfc451" />

<img width="814" height="666" alt="image" src="https://github.com/user-attachments/assets/43619a65-7860-4bdd-9c8c-442225ae3659" />

# How to Add a Jenkins Agent

**1. Create two EC2 instance( Controller and agent)**

 - Install jenkins, docker and java on controller server

**2 install Java on agent server**

       sudo apt update
       sudo apt install fontconfig openjdk-21-jre
       java -version
   

