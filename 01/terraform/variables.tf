variable "credentials" {
  description = "My Credentials"
  default     = "./.auth/gc-creds.json"
}


variable "project" {
  description = "Project"
  default     = "dtc-de-course-447007"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "ny_taxi"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-de-zoomcamp"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}