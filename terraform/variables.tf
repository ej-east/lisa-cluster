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

variable "tags" {
  type        = map(string)
  description = "Freeform tags to apply to all applicable resources"
  default = {
    Environment = "production"
    Project     = "lisa-cluster-proxy"
    ManagedBy   = "terraform"
  }
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "deployer_ip" {
  description = "The IP address you are deploying from"
  type        = string
}
