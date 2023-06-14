variable "region" {
  description = "The AWS region for creating resources"
  type        = string
  default     = "eu-central-1"
}

variable "subnet_id" {
  description = "The Subnet ID to launch the instance into. If not provided, the first subnet in the default VPC will be used"
  type        = string
  default     = ""
}

variable "ami_type" {
  description = "Specify 'ubuntu' or 'amazon' to select the respective AMI."
  type        = string
  default     = "ubuntu"
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "assign_eip" {
  description = "Whether to assign an Elastic IP to the instance"
  type        = bool
  default     = true
}

variable "use_key_pair" {
  description = "Whether to use a SSH key pair for the instance connection"
  type        = bool
  default     = true
}

variable "public_key" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
  description = "The name of the key pair for SSH access"
  type        = string
  default     = "ec2-test"
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = string
  default     = "ec2-test"
}
