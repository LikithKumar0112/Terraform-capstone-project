# Project 4.1 — Terraform Modules, Outputs & State

Demonstrates reusable **modules**, **output variables**, and the **state file**.

## What it builds
Two reusable modules (`../modules/gcs-bucket`, `../modules/network`) are called from
`main.tf` to create a GCS bucket and a VPC + subnet.

## Run it
```bash
gcloud auth application-default login          # one-time auth
cp terraform.tfvars.example terraform.tfvars   # then edit project_id

terraform init          # Task: initialise, download the google provider
terraform plan          # preview
terraform apply         # Task 5: create the infrastructure

terraform output        # Task 4: see the exposed output values
```

## Inspect the state (Task 6)
```bash
terraform state list                 # every resource Terraform tracks
terraform show                       # full state, human-readable
cat terraform.tfstate | less         # the raw JSON state file
```

## Modify & re-apply (Task 7)
Edit something (e.g. add a label in `main.tf`), then:
```bash
terraform plan     # Terraform shows the diff it detected
terraform apply    # it updates only what changed, and updates the state
```

## Deliverable screenshots
1. Project structure (`tree` or file explorer)
2. Module configuration (`main.tf` + `modules/`)
3. `terraform output` values
4. `terraform state list` / the state file
5. `terraform apply` after a config change (the diff)

## Elevate
- Rename `backend-gcs.tf.example` → `backend.tf` to store state remotely in GCS.
- Add more modules / variables / outputs.

## Clean up
```bash
terraform destroy
```
