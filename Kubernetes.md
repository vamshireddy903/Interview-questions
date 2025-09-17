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


