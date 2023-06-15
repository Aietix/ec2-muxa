# Check if subnet_id is provided; if not, then fetch the default VPC's subnet ID
locals {
  is_subnet_id_provided = var.subnet_id != "" ? true : false
  ami_type              = lower(var.ami_type)
}

# Fetch the default VPC
data "aws_vpc" "default" {
  count   = local.is_subnet_id_provided ? 0 : 1
  default = true
}

# Fetch the default subnets if subnet_id is not provided
data "aws_subnets" "default" {
  count = local.is_subnet_id_provided ? 0 : 1
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default[0].id]
  }
}

# Fetch the first subnet
data "aws_subnet" "default" {
  count = local.is_subnet_id_provided ? 0 : 1
  id    = local.is_subnet_id_provided ? null : tolist(data.aws_subnets.default[0].ids)[0]
}


# Determine subnet_id to use
locals {
  subnet_id = local.is_subnet_id_provided ? var.subnet_id : data.aws_subnet.default[0].id
}


# Fetch the most recent Amazon Linux AMI if the ami_type variable is set to "amazon"
data "aws_ami" "amazon" {
  count = local.ami_type == "amazon" ? 1 : 0

  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


# Fetch the most recent Ubuntu AMI if the ami_type variable is set to "ubuntu"
data "aws_ami" "ubuntu" {
  count       = local.ami_type == "ubuntu" ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
