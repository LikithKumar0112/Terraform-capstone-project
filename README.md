# Terraform Capstone — Infrastructure as Code (Projects 4.1 – 4.4)

Four projects taking Terraform from reusable modules to a full CI/CD pipeline,
plus Kubernetes monitoring — targeting **Google Cloud (GCP)**.

| Project | Title | Folder | Core skill |
|---------|-------|--------|-----------|
| 4.1 | Modules, Outputs & State | `project-4.1-modules/` | Reusable modules, outputs, state file |
| 4.2 | Multiple Environments | `project-4.2-workspaces/` | `terraform workspace` (dev/staging/prod) |
| 4.3 | Terraform + Jenkins | `project-4.3-jenkins/` | CI/CD pipeline for IaC |
| 4.4 | Prometheus + Grafana | `project-4.4-monitoring/` | Kubernetes monitoring |

```
Terraform/
├── modules/                 # shared reusable modules
│   ├── gcs-bucket/          #   a GCS bucket
│   └── network/             #   a VPC + subnet
├── project-4.1-modules/     # uses the modules, exposes outputs, inspect state
├── project-4.2-workspaces/  # same config across dev/staging/prod workspaces
├── project-4.3-jenkins/     # Jenkinsfile + terraform/ provisioned by CI/CD
└── project-4.4-monitoring/  # kube-prometheus-stack on a local kind cluster
```

## Design choices
- **GCP** (continuity with the K8s capstone; `gcloud auth application-default login` for auth).
- **Lightweight resources** (GCS buckets, VPC) — free/near-free, and they avoid the
  SSD quota limits hit during the K8s project. The Terraform *concepts* are identical
  whether the resource is a bucket or a VM.
- **Remote state** in a GCS bucket is provided as an elevate step (`backend-gcs.tf.example`).
- **4.4 runs on a local `kind` cluster** — free, and keeps monitoring off the cloud bill.

## Prerequisites
```bash
# Terraform, gcloud, kubectl, helm, kind, docker
gcloud auth application-default login
gcloud config set project <YOUR_PROJECT_ID>
```

## Order to work through
Each folder has its own README with exact commands and the deliverable
screenshots to capture. Start with **4.1**, then **4.2**, **4.3**, **4.4**.

> Note: the manual's index lists 4.3 as "Ansible / Dynamic Inventory", but every
> 4.3 detail page describes **Terraform + Jenkins** — this repo follows the
> detailed task pages. Confirm with your cohort if unsure.
