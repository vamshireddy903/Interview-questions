# Why containers are not pushed to the registry, why images? What is the reason?  
Containers themselves are running instances of images; they are ephemeral and include runtime state, which may differ from one container to another. Container images are immutable snapshots of the filesystem, application code, and dependencies. Registries store images because they provide a consistent, reproducible way to launch containers. Pushing running containers is not standard practice because the container may have temporary changes that aren’t meant to be shared or reused; images ensure consistency across environments.

# You have RDS and tomorrow, I being your client, will tell you that you need to make the configuration in such a way that only one user can access the RDS at a time. How will you configure that?

To ensure only one user can access an RDS instance at a time, you can implement connection management or concurrency control:

**1.Use a single database user:** Create one dedicated user for the application and give access only to that user. Avoid giving multiple users access simultaneously.  
**2.Limit max connections:** In the RDS parameter group, set max_connections=1 for the database. This will restrict the database to accept only one connection at a time.  
**3.Application-level lock:** If multiple clients/users need access through an application, implement a mutex/locking mechanism in the application code to ensure only one session uses the database at a time.  
**4.Network-level restriction:** Configure security groups or IAM policies so that only a single known client IP can connect at a time.

This ensures strict single-user access either at the database configuration level or via application logic.

# What does -Dsonar.projectKey=sample-app mean?

It is a SonarQube configuration property that gives a unique ID to your project in SonarQube.

Break it into parts  
-D

- Used to pass a system property to Java / Maven  
- Means: define a property

sonar.projectKey

- Property name expected by SonarQube  
- It identifies the project uniquely

sample-app

- The value of the project key  
- This is the project’s unique identifier in SonarQube

  <img width="993" height="676" alt="image" src="https://github.com/user-attachments/assets/fc75bbd9-c52b-42fc-a03d-98864917d2bf" />
