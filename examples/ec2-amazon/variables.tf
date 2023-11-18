variable "name" {
  description = "Resource Name"
  type        = string
  default     = "ec2-test"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_type" {
  description = "'ubuntu' or 'amazon'"
  type        = string
  default     = "Amazon"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The Subnet ID to launch the instance. If not provided, the first subnet in the default VPC will be used."
  type        = string
  default     = ""
}

variable "assign_eip" {
  description = "Assign Elastic IP"
  type        = bool
  default     = false
}

variable "public_ip" {
  description = "Custom; likely controls public IP assignment"
  type        = bool
  default     = true
}

variable "use_key_pair" {
  description = "Use SSH key pair"
  type        = bool
  default     = true
}

variable "public_key" {
  description = "SSH public key path on your local machine"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ingress" {
  description = "Ingress rules in format 'port,protocol,cidr;port,protocol,cidr'"
  type        = string
  default     = "22,tcp,0.0.0.0/0;443,tcp,0.0.0.0/0"
}

variable "egress" {
  description = "Egress rules in format 'port,protocol,cidr;port,protocol,cidr'"
  type        = string
  default     = "0-65535,tcp,0.0.0.0/0;0-65535,udp,0.0.0.0/0"
}
