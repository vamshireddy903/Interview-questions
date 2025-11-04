# How can you trigger one Jenkins pipeline after another?

There are multiple ways to trigger a Jenkins pipeline after another.

- We can configure a post-build action in the first job to “Build other projects”.  
- In pipeline-as-code (Jenkinsfile), we can use the build job: command inside the post block, so the next job runs only after the first job succeeds.

**1. Using "Build other projects"**  
- In your first pipeline (say Pipeline-A):  
- Go to Post-build Actions → Build other projects  
- Add the next pipeline name (e.g. Pipeline-B).  
- This will trigger Pipeline-B automatically after Pipeline-A finishes.

<img width="1916" height="784" alt="image" src="https://github.com/user-attachments/assets/c74a0467-1a37-4502-8f80-3c0391198ed4" />


**Option 2: Using Pipeline Script (Jenkinsfile)**  
If you use a declarative pipeline:

```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
    }
    post {
        success {
            // Trigger next job
            build job: 'pipeline-B'
        }
    }
}
```
✅ Pipeline-B will start only if Pipeline-A succeeds.

**3: Using Parameterized Trigger Plugin**

You can also pass parameters from one pipeline to another:

You want Pipeline-A to trigger Pipeline-B, and also pass some parameters (like BUILD_ID, IMAGE_TAG, etc.) to it only after Pipeline-A succeeds.

**1️⃣ Prerequisite**

Make sure the **Parameterized Trigger** Plugin is installed:

- Go to **Manage Jenkins** → **Manage Plugins** → Available   
- Search for **"Parameterized Trigger Plugin"**  
- Install it (no restart required)

**2️⃣ Define parameters in Pipeline-B**

In your Pipeline-B Jenkinsfile, define the parameters section:

```
pipeline {
    agent any
    parameters {
        string(name: 'BUILD_ID', defaultValue: '', description: 'Build ID from previous pipeline')
        string(name: 'IMAGE_TAG', defaultValue: '', description: 'Image tag from previous pipeline')
    }
    stages {
        stage('Deploy') {
            steps {
                echo "Triggered from Pipeline-A"
                echo "Received BUILD_ID: ${params.BUILD_ID}"
                echo "Received IMAGE_TAG: ${params.IMAGE_TAG}"
            }
        }
    }
}
```
Jenkins automatically stores these as environment variables accessible via ${params.VARIABLE_NAME}.

**3️⃣ Trigger from Pipeline-A**

Now in your Pipeline-A Jenkinsfile:
```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo "Building application..."
            }
        }
    }
    post {
        success {
            echo "✅ Build successful — triggering Pipeline-B..."
            
            build job: 'Pipeline-B', 
            parameters: [
                string(name: 'BUILD_ID', value: env.BUILD_ID),
                string(name: 'IMAGE_TAG', value: "v1.0.${env.BUILD_NUMBER}")
            ]
        }
    }
}
```
<img width="1030" height="499" alt="image" src="https://github.com/user-attachments/assets/a6a43f0c-324b-4841-bc2a-d72973c73653" />
