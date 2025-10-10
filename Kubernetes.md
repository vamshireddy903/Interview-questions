# Kubernetes in Production – The 10 Non-Negotiables


"Before you go live… ‘We shipped to production and… the pods were running, but nothing worked.’"
Too many teams treat Kubernetes like a dev toy — until their first 3 AM pager. These are production-grade practices built from real-world chaos.

# My pod is alive. But is it ready?

 Imagine this: You deploy. The load balancer starts sending
 traffic. Your app is booting. Users see errors. Management
 panics.
 The fix? Kubernetes gives you livenessProbe and
 readinessProbe for a reason. Don’t skip them

# 1. Liveness & Readiness Probes
 Purpose: Ensure app is not just running, but also ready.
Key YAML Snippet:

```
yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
Golden Rule: Never ship to production without both probes.
```
#  Golden Rules:
 Your app might run but still not be ready. That’s the
 point.
 Without readiness probes, Kubernetes thinks your pod
 is fine — even when it's not.
 Without liveness probes, zombie pods stay alive, silently
 failing.
 
 # Production Rule: 
 Never ship a deployment without bothprobes ever

 # 2. Resource Requests & Limits
 
 "It worked on my cluster - until it ate all the memory."
 Kubernetes nodes are shared playgrounds. Without
 boundaries, a single container can choke the system.
 
 Real Implementation:

 ```
resources:
 requests:
 cpu: "250m"
 memory: "512Mi"
 limits:
 cpu: "500m"
 memory: "1Gi"
```

 # Golden Rules:
 Requests are promises. Limits are hard stops.
 Always set both. No exceptions.
 Use performance profiling to tune them — not
 guesswork.
 
 # Production Rule: 
 No container goes to prod without defined resource limits

# 3.  3. Horizontal Pod Autoscaler (HPA)

 "Traffic spiked. The app crashed. Monitoring said it was fine."
 Manual scaling is a myth. You won’t be online every second.
 

Real Implementation:

```
 apiVersion: autoscaling/v2
 kind: HorizontalPodAutoscaler
 spec:
 minReplicas: 2
 maxReplicas: 10
 metrics:- type: Resource
 resource:
 name: cpu
 target:
 type: Utilization
 averageUtilization: 60
```

#  Golden Rules:
 Enable metrics-server
 Use CPU for simple apps, custom metrics for precision
 
# Production Rule:
 Autoscale what matters. Always

#  4. Network Policies

 "A frontend in one namespace talked to a database in another — unencrypted."
 By default, Kubernetes allows all traffic. You must explicitly lock it down.
 
 Real Implementation:
 
 ```
 apiVersion: networking.k8s.io/v1
 kind: NetworkPolicy
 spec:
 podSelector:
 matchLabels:
 role: backend
 ingress:- from:- podSelector:
 matchLabels:
 role: frontend
```

# Golden Rules:
 Default deny, then explicitly allow
 Define policies per namespace or microservice
 
# Production Rule: 
No public east-west traffic. Ever.

# Deployment strategies

# 1️⃣ Rolling Update

Definition:
A rolling update gradually replaces the old version of an application with the new version without downtime. Only a few pods are updated at a time.

# How it works:

Kubernetes updates pods incrementally.

Old pods are terminated only after new pods are running and healthy.

Users experience continuous availability.

# Pros:

No downtime.

Simple to implement in Kubernetes (kubectl set image or Deployment strategy).

# Cons:

If the new version has a bug, it may impact some users before rollback.

Example in Kubernetes:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1

```
maxUnavailable: 1 → Only 1 pod can be down at a time.

maxSurge: 1 → At most 1 extra pod is created during update.

# 2️⃣ Canary Deployment

Definition:
A canary deployment releases the new version to a small subset of users first. Once it is verified to be stable, the deployment is rolled out to everyone.

# How it works:

Only a few pods serve traffic with the new version.

Monitor logs, metrics, and errors.

Gradually increase traffic to new pods.

# Pros:

Safer than rolling update for risky changes.

Early detection of issues with limited impact.

# Cons:

Requires traffic routing control (Ingress, Service Mesh, or Load Balancer).

Slightly more complex to implement.

# Example:

1 out of 10 pods runs version v2 while 9 run v1.

If no errors, increase v2 pods gradually until 100%.

# 3️⃣ Blue-Green Deployment

Definition:
In a blue-green deployment, two identical environments exist: blue (current) and green (new). Traffic is switched from blue to green all at once.

# How it works:

Deploy the new version to green environment.

Test it without affecting live users.

Switch traffic from blue → green (DNS, Load Balancer, or Ingress).

Keep blue environment as backup in case rollback is needed.

# Pros:

Zero downtime if configured correctly.

Easy rollback by switching traffic back to blue.

# Cons:

Requires double infrastructure (costly for large-scale apps)

<img width="907" height="348" alt="image" src="https://github.com/user-attachments/assets/29dbd2d3-69bf-49cc-ae1a-83c14c6fac30" />

# Kubernetes Service 

In Kubernetes, a Service is a method for exposing a network application in the cluster. We use a Service to make that set of Pods available on the network so that users can interact with it.

There are 3 types of Kubernetes services: ClusterIP, NodePort and LoadBalancer. The “type” property in the Service’s specification determines how the service is exposed to the network.

# Kubernetes Service Types
**ClusterIP**

ClusterIP is the default and most common service type. Kubernetes will assign a cluster-internal IP address to ClusterIP service. This makes the service only reachable within the cluster.

**NodePort**

This exposes the service outside of the cluster by adding a cluster-wide port on top of ClusterIP. We can request the service by NodeIP:NodePort.

**LoadBalancer**

This exposes the Service externally using a cloud provider’s load balancer.

# Kubernetes architecture

<img width="1084" height="594" alt="image" src="https://github.com/user-attachments/assets/b42d0f57-85c0-48bb-aba8-ddc62e428fda" />

Kubernetes distributed system follows a client-server architecture with two main components: the control plane(master node) and Data plane (Worker Nodes).

**Control Plane:**

- It is the brain of the Kubernetes cluster.
  
- The control plane acts as the central management hub for the entire Kubernetes cluster.

**Components of the Control Plane**

**1. kube-apiserver**  

- The API server is a component of the Kubernetes control plane that exposes the Kubernetes API. The API server is the front end for the Kubernetes control plane.  
- Allows users and other components to create, read, update, and delete Kubernetes resources.

**2. etcd**

A key-value store that stores all cluster data, including configuration and state

- It maintains the current status, desired state, configuration, and metadata for all Kubernetes objects.

  **What info it stores?**
  
- **Cluster Configuration and Metadata:** Nodes, Namespaces, Resource Quotas, Cluster Roles and Role Bindings (RBAC)  
- **Workloads:** Pods, Deployments, ReplicaSets, DaemonSets, StatefulSets, Jobs, and CronJobs.  
- **Services and Networking:** Services, Endpoints, Ingress, Network Policies, and ConfigMaps.  
- **Secrets and Credentials:** Secrets and Service Accounts Tokens.  
- **Persistent Storage:** Persistent Volumes (PVs), Persistent Volume Claims (PVCs), and Storage Classes.  
- **Admission Controllers:** Admission Webhooks  
- **Autoscaling Data:** Horizontal Pod Autoscalers (HPA)  
- **API Server Configuration:** API Server Discovery Info

**3. Scheduler**

The Scheduler is a component of the Kubernetes master that is responsible for selecting the best node for the pod to run on. When a pod is created, the scheduler decides which node to run it on based on resource availability, constraints, affinity and anti-affinity specifications, data locality, inter-workload interference, and deadlines.

**4. kube-cloud-controller**

 Handles background tasks such as maintaining node health, scaling, and other cluster-wide operations

 Few Controllers:
   
- Replication Controller  
- Deployment Controller  
- Node Controller:      
- Namespace Controller  
- Ingress Controller  
- and many more…

**5. Cloud-controller-manager**

Integrates Kubernetes with cloud provider-specific APIs, managing resources like load balancers, persistent volumes, and network routes within a cloud environment.

# Worker Node Components:

**kubelet:** An agent running on each Worker Node, responsible for managing Pods and their containers, communicating with the Control Plane's API server, and ensuring the containers are running as expected.

**kube-proxy:** A network proxy that maintains network rules on nodes, enabling communication between Pods and services both within and outside the cluster. It handles network address translation (NAT) and load balancing for services.


**Container Runtime:** Software responsible for running containers, such as Docker, containerd, or CRI-O. It pulls container images and executes them within Pods.

We now know about all the different components of the Kubernetes cluster. Let us take a real-world example and see how all these different components work together behind the scenes.

Let’s say you want to create a Deployment nginx with 4 replicas in your cluster. You can create the deployment easily using the command below

    kubectl create deployment --image=nginx --replicas=4

Let’s try and understand step-by-step what happens behind the scenes once you run this command.

**Step 1:** Kubectl checks the kubeconfig to determine the cluster endpoint and authentication certificates for the API Server, and sends the request to the API Server.

**Step 2:** The API Server authenticates the request and authorizes the request. The information received through this request is stored in the ETCD.

**Step 3:** The API Server sends a message to the controller manager to create the deployment.

**Step 4:** The Deployment Controller observes that no pods are running, so it tells the scheduler to schedule the pods on available nodes.

**Step 5:** The Scheduler assigns the pods to the available nodes

**Step 6:** The Kubelet creates the pods, and the container runtime ensures that the containers in the pod are running.

**Step 7:** The Scheduler sends the pod status back to the API Server, and the API Server stores this information in the ETCD

# What is a Namespace in Kubernetes?

A namespace is like a virtual cluster inside your Kubernetes cluster.   
It’s a way to divide and organize resources so multiple teams, projects, or environments can share the same cluster without interfering with each other.

# Why Namespaces Are Useful

**Isolation:**  
Resources in one namespace don’t clash with others (e.g., two apps can both have a Service named frontend — in different namespaces).

**Organization:**  
You can group resources logically — like:

- dev for development  
- staging for testing  
- prod for production  

**Access control:**  
You can apply RBAC (Role-Based Access Control) per namespace to restrict access.

**Resource limits:**  
You can set resource quotas per namespace (e.g., limit CPU/memory usage for a team).

# Common Commands


`kubectl get namespaces`                                    - Lists all namespaces

`kubectl create namespace dev`                              - Creates a new namespace called `dev`

`kubectl delete namespace dev`                              - Deletes a namespace

`kubectl get pods -n dev`                                   - Lists pods in the `dev` namespace

`kubectl apply -f app.yaml -n dev`                          - Deploys a manifest to the `dev` namespace

`kubectl config set-context --current --namespace=dev`      - Sets default namespace for your current session
