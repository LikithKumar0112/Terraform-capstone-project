# Project 4.3 — Infrastructure Automation with Terraform + Jenkins

A Jenkins CI/CD pipeline that runs Terraform to provision cloud infrastructure
automatically when code is pushed.

## 1. Run Jenkins locally (Docker)
```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

# initial admin password:
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
Open http://localhost:8080, install suggested plugins (+ the "Pipeline" and
"Credentials" plugins).

## 2. Install Terraform inside the Jenkins container
```bash
docker exec -u root jenkins bash -c '
  apt-get update && apt-get install -y gnupg software-properties-common curl unzip &&
  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg &&
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list &&
  apt-get update && apt-get install -y terraform'
```

## 3. Add the GCP credential
- Create a GCP service account with permission to manage the resources, download
  its JSON key.
- Jenkins → Manage Jenkins → Credentials → add a **Secret file** with ID
  `gcp-sa-key` (the Jenkinsfile references this exact ID).

## 4. Create the pipeline job
- New Item → **Pipeline** → "Pipeline script from SCM" → Git → your repo URL.
- Script path: `project-4.3-jenkins/Jenkinsfile`.
- Enable a build trigger (webhook, or "Poll SCM" `H/2 * * * *`) so pushes
  auto-run the pipeline (Task 5).

## 5. Run it
Push a change (or click "Build Now"). Watch the stages: Checkout → Init → Plan →
Approval → Apply. Approve at the gate; Terraform provisions the bucket.

## Deliverable screenshots
1. Terraform repo (this folder in Git)
2. Jenkins pipeline configuration
3. Pipeline execution stages (the stage view)
4. Infrastructure created (bucket in GCP console)
5. Terraform execution logs inside the Jenkins build console
