# How to Run Jenkins Pipelines in Parallel

There are two main cases:

**Case 1: Run multiple stages parallelly (within the same pipeline)**

✅ In your Jenkinsfile, you can use the parallel directive.

```
pipeline {
    agent any
    stages {
        stage('Build & Test in Parallel') {
            parallel {
                stage('Build') {
                    steps {
                        echo "Running build..."
                    }
                }
                stage('Unit Tests') {
                    steps {
                        echo "Running unit tests..."
                        sh 'mvn test'
                    }
                }
                stage('Code Scan') {
                    steps {
                        echo "Running SonarQube analysis..."
                    }
                }
            }
        }
    }
}
```

# Explanation:
- All stages under parallel will execute at the same time on different executors (if available).  
- Useful when you want to speed up CI, e.g., build + test + scan simultaneously.

# Case 2: Run multiple pipelines parallelly (independent jobs)

✅ You can use a **“parent orchestration pipeline”** that triggers multiple jobs in parallel:

```
  pipeline {
    agent any
    stages {
        stage('Run Multiple Pipelines') {
            parallel {
                stage('Service A') {
                    steps {
                        build job: 'Pipeline-A'
                    }
                }
                stage('Service B') {
                    steps {
                        build job: 'Pipeline-B'
                    }
                }
                stage('Service C') {
                    steps {
                        build job: 'Pipeline-C'
                    }
                }
            }
        }
    }
}
```
1. Pipeline-A

```
pipeline {
    agent any

    stages {
        stage('Pipeline-A') {
            steps {
                echo 'Hello from Pipeline -A'
            }
        }
    }
}
```

2. Pipeline B

```
pipeline {
    agent any

    stages {
        stage('Pipeline-B) {
            steps {
                echo 'Hello from Pipeline -B'
            }
        }
    }
}
```
3. Pipeline-C

```
pipeline {
    agent any

    stages {
        stage('Pipeline-C') {
            steps {
                echo 'Hello from Pipeline -C'
            }
        }
    }
}
```
**Explanation:**  
- Jenkins will start Pipeline-A, Pipeline-B, and Pipeline-C at the same time.  
- Perfect for microservices architecture where each service can build and test independently.

# Using failFast true

- If you want Jenkins to immediately stop all other parallel branches when one fails,  
- you can add the failFast: true option like this:

```
stage('Parallel Jobs') {
    parallel failFast: true, 
    branches: [
        "Build": {
            echo "Running Build..."
            sleep 5
        },
        "Test": {
            echo "Running Tests..."
            error("❌ Test failed!")
        },
        "Deploy": {
            echo "Deploying..."
            sleep 10
        }
    ]
}
```
🧠 How it works

- The moment one branch fails (e.g. "Test"),  
- Jenkins immediately cancels the remaining running branches (Build, Deploy).  
- The pipeline then marks the overall status as failed.

**What happens if one parallel stage fails in Jenkins?**

By default, Jenkins marks the whole pipeline as failed but allows other parallel branches to finish.
However, if we specify failFast: true inside the parallel block, Jenkins stops all other branches immediately after one branch fails.
