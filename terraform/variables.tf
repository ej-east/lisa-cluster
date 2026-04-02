variable "tenancy_ocid" {
  type        = string
  description = "The unique identifier for your OCI tenancy."
}

variable "user_ocid" {
  type        = string
  description = "The OCID of the IAM user that Terraform will assume"
}

variable "fingerprint" {
  type        = string
  description = "The fingerprint of the private key"
}

variable "private_key_path" {
  type        = string
  description = "The path to the private key for auth"
}

variable "region" {
  type        = string
  description = "The region to target for deployment"
  default     = "us-ashburn-1"
}

