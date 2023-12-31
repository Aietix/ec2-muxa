variable "region" {
  description = "The AWS region for creating resources"
  type        = string

  validation {
    condition     = var.region != ""
    error_message = "The region variable must not be empty."
  }
}

variable "subnet_id" {
  description = "The Subnet ID to launch the instance into. If not provided, the first subnet in the default VPC will be used"
  type        = string
  default     = ""
}

variable "ami_type" {
  description = "Specify 'ubuntu' or 'amazon' to select the respective AMI."
  type        = string

  validation {
    condition     = contains(["amazon", "ubuntu"], lower(var.ami_type))
    error_message = "The ami_type must be 'amazon' or 'ubuntu'."
  }
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "assign_eip" {
  description = "Whether to assign an Elastic IP to the instance"
  type        = bool
  default     = false
}

variable "use_key_pair" {
  description = "Whether to use a SSH key pair for the instance connection"
  type        = bool
  default     = false
}

variable "public_key" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "name" {
  description = "Name to assign to resources"
  type        = string
  default     = ""
}

variable "public_ip" {
  description = "Custom argument; likely controls if a public IP should be assigned"
  type        = bool
  default     = false
}

variable "ingress" {
  description = "Ingress rules in the format 'port,protocol,cidr;port,protocol,cidr;...'"
  type        = string
  default     = ""
}

variable "egress" {
  description = "Ingress rules in the format 'port,protocol,cidr;port,protocol,cidr;...'"
  type        = string
  default     = ""
}