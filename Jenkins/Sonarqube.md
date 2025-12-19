# Sonarqube

**1️⃣ What is SonarQube? **

SonarQube = Code Quality & Security Scanner

It checks:

- 🐞 Bugs – code that may break at runtime  
- 🔐 Vulnerabilities – security issues  
- 🧼 Code Smells – bad practices (technical debt)  
- 📊 Coverage – how much code is tested  
- 🔁 Duplications – repeated code

👉 Unlike OWASP Dependency-Check (dependency vulnerabilities),  
SonarQube scans YOUR source code.

<img width="798" height="251" alt="image" src="https://github.com/user-attachments/assets/3699afd6-3fab-43a3-9fc6-c213953fe269" />

# 3️⃣ Core SonarQube Concepts 

**🔹 Bug**

Code error that can cause failure  
Example:
```
String s = null;
s.length();   // NullPointerException
```

**🔹 Vulnerability**

Security weakness  
Example:
```
Statement stmt = conn.createStatement();
stmt.execute("SELECT * FROM users WHERE id=" + userInput);
```

(SQL Injection)

**🔹 Code Smell**

Bad design / maintainability issue  
Example:

- Long methods  
- Duplicate code  
- Hard-coded values

**🔹 Technical Debt**

Time required to fix code smells  
Example:

“5h debt” means ~5 hours to clean the code

<img width="609" height="612" alt="image" src="https://github.com/user-attachments/assets/2a8aabfd-a394-49d9-93b9-40e750a42e07" />

# Jenkinsfile Example (Maven Project)
```
stage('SonarQube Analysis') {
  environment {
    SONAR_TOKEN = credentials('sonarqube-token')
  }
  steps {
    withSonarQubeEnv('sonarqube-server') {
      sh """
        mvn sonar:sonar \
        -Dsonar.projectKey=board-game \
        -Dsonar.host.url=http://localhost:9000 \
        -Dsonar.login=$SONAR_TOKEN
      """
    }
  }
```

# Quality Gate Stage (Must have)
```
stage('Quality Gate') {
  steps {
    timeout(time: 5, unit: 'MINUTES') {
      waitForQualityGate abortPipeline: true
    }
  }
}
}
```
➡ If Quality Gate fails → pipeline fails automatically

<img width="591" height="288" alt="image" src="https://github.com/user-attachments/assets/b5d68925-7f66-461c-866f-ec2e59a1e719" />

# Steps to Implement

**1. Run sonarqube as container**

     docker run -d --name sonarqube-server -p 9000:9000 sonarqube:lts-community

**2. Access the application**

     http://localhost:9000

- username: admin  
- password: admin

**3. Install plugins in jenkins dashboard**

1. SonarQube Scanner for Jenkins  
2. Eclipse Temurin installer Plugin

**4. Configure tools**

Manage jekins -- tools

1. Jdk
2. maven
3. sonarqube

**Generate sonarqube token**

 Administration -- Security -- users -- updatetoken

 <img width="1653" height="523" alt="image" src="https://github.com/user-attachments/assets/3a6ca945-5fd4-45ce-abf3-a42fca47ee52" />

**Update crdentials in jenkins**

<img width="1103" height="784" alt="image" src="https://github.com/user-attachments/assets/91010040-a982-4951-a5e0-3ce5cb1490fd" />

**SonarQube Server Configuration**

<img width="636" height="247" alt="image" src="https://github.com/user-attachments/assets/06be8cc8-fd94-487d-b9ae-b41c29e664b2" />

<img width="1149" height="605" alt="image" src="https://github.com/user-attachments/assets/3b6782a8-dfe9-4d7c-855e-4bf5513182a0" />

 
https://github.com/jaiswaladi246/Petclinic.git
