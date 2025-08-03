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

