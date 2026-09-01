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
        stage ('Database'){
            agent {
                docker {
                    image 'mysql:8.0'
                }
            }
            steps {
                echo "Checking version"
                sh 'mysql --version'
            }
        }
        
        }
    }
```
