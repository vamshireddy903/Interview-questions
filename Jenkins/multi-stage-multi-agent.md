```
pipeline {
    agent none

    stages {
        stage('Check node Version') {
            agent {
                docker { image'node:22-alpine'}
            }
            steps {
                echo 'Checking node version'
                sh 'node --version'
            }
            }
        stage ('Security scan'){
            agent {
                docker {
                    image 'aquasec/trivy:latest'
                    args '--entrypoint=""'
                }
            }
            steps {
                echo "Running security scanning"
                sh 'trivy --version'
            }
        }
        
        }
    }
```
