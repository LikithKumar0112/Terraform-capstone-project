# Reusable module: a single Google Cloud Storage bucket.
# Kept generic so the root configs (4.1, 4.2, 4.3) can create many buckets
# from the same building block — this is the whole point of "modules".
resource "google_storage_bucket" "this" {
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning
  }

  labels = var.labels
}
