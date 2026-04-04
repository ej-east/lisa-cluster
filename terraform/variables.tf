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

variable "vm_memory" {
  description = "The amount of memory you want the VM to have"
  type        = number
  default     = 4
  validation {
    error_message = "Amount of memory must be between 1-24"
    condition     = var.vm_memory >= 1 && var.vm_memory <= 24
  }
}

variable "vm_cpu" {
  description = "The number of CPU cores you want the VM to have. Must be between 1-4"
  type        = number
  default     = 1
  validation {
    error_message = "Amount of CPU cores must be between 1-4"
    condition     = var.vm_cpu >= 1 && var.vm_cpu <= 4
  }
}

variable "vm_storage" {
  description = "The amount of space you want the boot disk to have."
  type        = number
  default     = 50
  validation {
    error_message = "Amount of space must be between 50-200"
    condition     = var.vm_storage >= 50 && var.vm_storage <= 200
  }
}

variable "deployer_public_ssh_key" {
  description = "The file path to the deployer's public SSH key"
  type        = string
}
