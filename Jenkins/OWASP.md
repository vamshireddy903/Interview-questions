OWASP (Open Web Application Security Project), now often called the Open Worldwide Application Security Project, is a global, non-profit foundation dedicated to improving software security by providing free, open-source resources, tools, documentation, and community support for developers, businesses, and security professionals.

<img width="910" height="305" alt="image" src="https://github.com/user-attachments/assets/2ee97863-e08c-45c5-a477-21b6235f9537" />

<img width="964" height="514" alt="image" src="https://github.com/user-attachments/assets/3e64176e-ee20-4645-855e-e5974c8722a6" />

<img width="910" height="798" alt="image" src="https://github.com/user-attachments/assets/1d082224-299e-4176-99fc-00a39ab8cb98" />

<img width="676" height="435" alt="image" src="https://github.com/user-attachments/assets/6e929264-ce8d-4877-b554-2dc190ac683b" />


https://www.cloudflare.com/learning/security/threats/owasp-top-10/

# Steps to implement OWASP in pipeline

**1. Install owasp plugin**

managejenkins --- plugins --- available plugins

**2. Configure in tool section**

1. add maven
2. add jdk
3. add dependecy check

<img width="1492" height="653" alt="image" src="https://github.com/user-attachments/assets/f8502879-fc60-48e2-9106-792a5520046a" />


```
pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/spring-petclinic/spring-framework-petclinic.git'
            }
        }
        stage('Security scan') {
            steps {
                dependencyCheck additionalArguments: '--format HTML', odcInstallation: 'dp-check'
            }
        }
    }
}
```



for testing appln: https://github.com/spring-petclinic/spring-framework-petclinic.git
