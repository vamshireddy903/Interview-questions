# What Is a Helm Chart?

A Helm chart is just a package that contains:  
✔ Kubernetes YAML files  
✔ Templates  
✔ Values  
✔ Metadata  

It helps you deploy applications to Kubernetes easily.

# 📦 Helm Project (Chart) Structure

When you run:

    helm create mychart

<img width="525" height="558" alt="image" src="https://github.com/user-attachments/assets/bb6e766e-95ad-42ab-8964-958179e42b64" />

# 📝 1. Chart.yaml (MOST IMPORTANT FILE)

This file contains metadata about your Helm chart.

Example:
```
apiVersion: v2
name: mychart
description: A Helm chart for Kubernetes
version: 0.1.0
appVersion: "1.18"
```

Used for:

- chart name  
- version  
- app version  
- description  
- dependencies

# ⚙️ 2. values.yaml — (DEFAULT CONFIG FILE)

This is where you store all variables used in templates.

Example:
```
replicaCount: 2

image:
  repository: nginx
  tag: latest

```
You can override values when installing:

helm install app mychart -f custom-values.yaml .

# 📁 3. templates/ — (K8s YAML with templating)

This folder contains all Kubernetes resources (Deployment, Service, Ingress, etc.)

Example files:

- deployment.yaml  
- service.yaml  
- ingress.yaml  
- hpa.yaml  
- serviceaccount.yaml  

These files contain Go templating syntax like:

    replicas: {{ .Values.replicaCount }}

# 🧩 4. templates/_helpers.tpl (REUSABLE TEMPLATE FUNCTIONS)

This file defines helper functions such as naming conventions.

Example:
```
{{- define "mychart.fullname" -}}
{{ .Chart.Name }}-{{ .Release.Name }}
{{- end -}}
```

Used in templates:
```
metadata:
  name: {{ include "mychart.fullname" . }}
```

# 🧪 5. templates/tests/

Contains test files to check if your deployment works.

Example:

templates/tests/test-connection.yaml

This creates a pod to test if Service is accessible.

# 📦 6. charts/ (DEPENDENCIES)

This folder is used when:
```
dependencies:
  - name: redis
    version: "x.x.x"
    repository: "https://charts.bitnami.com/bitnami"
```
Helm downloads dependencies into charts/.

# 📄 7. .helmignore

Works like .gitignore.  
Files listed here will not be packaged in chart.

<img width="734" height="507" alt="image" src="https://github.com/user-attachments/assets/c34c940a-bae5-4c29-b70a-88a3dae286f3" />


# Advantages of Helm (Very Important for DevOps Interviews)

**✅ 1. Simplifies Kubernetes Deployment**

Instead of applying multiple YAML files manually:
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

Helm deploys everything in one command:

    helm install myapp .

# ✅ 2. Reusability Using Templates

Helm uses Go templates, so you don’t write repeated YAML.

Example:

    replicas: {{ .Values.replicas }}

Same template works for dev, staging, prod with only values overridden.

# ✅ 3. Versioning of Releases

You can track what version of the app/infra is deployed.

Use:
```
helm history myapp
helm rollback myapp 3
```

Rollback to ANY previous version easily.

# ✅ 4. Rollback Support (Super Useful)

If a deployment fails:

    helm rollback myapp 1

Everything goes back to the last working version automatically.

# ✅ 5. Parameterization with values.yaml

All environment-specific values are in:
```
values-dev.yaml
values-prod.yaml
```

Deploy with custom values:

helm install myapp -f values-prod.yaml

# ✅ 6. Easy Sharing and Packaging

You can package and distribute apps like apt/yum:
```
helm package mychart/
helm push mychart.tgz oci://myregistry
```

Great for organizations maintaining internal charts.

# ✅ 7. Dependency Management

If your app needs Redis or MySQL, Helm automatically manages them.
```
dependencies:
  - name: redis
    version: 17.0.1
    repository: https://charts.bitnami.com/bitnami
```

helm dependency update downloads and installs dependencies.

# ✅ 8. Declarative + Templated Approach

Helm = best of both worlds:

Declarative (like Kubernetes YAML)  
Templated (dynamic values, reusable)

# ✅ 9. Easy Upgrades

Update app version with:

    helm upgrade myapp .


Only changed resources are updated — intelligently.

# ✅ 10. Consistency Across Environments

Same chart deploys to:

- Dev  
- Stage  
- Production  
- QA  
- UAT  

Only values change.  
Ensures zero human errors.

# 11. Reduces YAML Duplication

Instead of writing 500 lines of YAML for each microservice → You parameterize and reuse the same chart.

# View complete release history

    helm history <release-name>

# helm history dev-nginx --max=2

     helm history dev-nginx --max=2
     
# o get the values used for revision 2 of your Helm release

     helm get values dev-nginx --revision 2
     
# Compare Revision 2 with Revision 1:

    helm diff revision dev-nginx 1 2

# Helm never stores changes you make inside the chart files (like editing values.yaml).

It only stores user-supplied values, meaning values passed via:
```
helm install -f file.yaml
helm install --set key=value
helm upgrade -f file.yaml
helm upgrade --set key=value
```
If you directly edit:
```
values.yaml
templates/*.yaml
```

and then run:

    helm upgrade dev-nginx .

Helm treats it as no user-supplied values, so it shows:

     helm get values dev-nginx --revision 2   
     
```
USER-SUPPLIED VALUES:
null
```

# If you modified values in values.yaml and want to see what chnages that you made in that revision then 

    helm upgrade dev-nginx . -f values.yaml


Then you wnat see chnages in that version

     helm get values dev-nginx --revision <revison number>

# Search charts in the repo

     helm search repo <repo-name> 

example:

       helm search repo bitnami

or 

     helm search repo bitnami | grep nginx

# Set replicaCount using CLI (After deploying)

      helm upgrade <release-name> <chart-name> --set replicaCount=2

# Set image repository and tag via CLI

    helm install <release name> <chart name> --set image.repository=nginx --set image.tag=1.25

# Helm Troubleshooting

**1. Dry run**

     helm install <release name> <chartname> --dry-run --debug

    helm upgrade <release name> <chartname> --dry-run --debug

**2. Values not applying(--set not working)**

Verify

    helm get values <releasename>

 **3. Debug with lint**

    helm lint <chart-name>

# USefull commands

**1. List the revisions**

    helm history <release-name>

**2. Rollback to a previoius version**

    helm rollback <release-name> revision-number

**3. Check rollback status**

     helm status <release-name>

**4 Compare two revision**

**Using diff**

      diff <(helm get manifest <release-name> --revision <revision-number>) <(helm get manifest <release-name> --revision <revision-number>)

**Using helm diff Plugin**

  Install once:

       helm plugin install
       https://github.com/databus23/helm-diff

Then

      helm diff revision <revision number> <revision number>


# See only values chnaged in a revision

    helm get values <release-name> --revision <revision-number>

