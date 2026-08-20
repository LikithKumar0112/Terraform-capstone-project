# Project 4.2 — ONE configuration, MANY environments via workspaces.
# terraform.workspace holds the current workspace name (dev/staging/prod).
# We use it to (a) name resources per-environment and (b) pick per-env settings,
# while each workspace keeps its OWN isolated state file automatically.

locals {
  env = terraform.workspace

  env_settings = {
    default = { versioning = false }
    dev     = { versioning = false }
    staging = { versioning = true }
    prod    = { versioning = true }
  }

  cfg = lookup(local.env_settings, local.env, local.env_settings["dev"])
}

module "storage" {
  source     = "../modules/gcs-bucket"
  name       = "${var.project_id}-ws-${local.env}-data"
  location   = var.bucket_location
  versioning = local.cfg.versioning
  labels = {
    environment = local.env
    managed_by  = "terraform"
    project     = "4-2-workspaces"
  }
}
