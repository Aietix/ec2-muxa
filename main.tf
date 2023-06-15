provider "aws" {
  region = var.region
}

# Define an EC2 instance
resource "aws_instance" "this" {
  ami                         = var.ami_type == "amazon" ? data.aws_ami.amazon[0].id : data.aws_ami.ubuntu[0].id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.this.id]
  key_name                    = var.use_key_pair ? aws_key_pair.this[0].key_name : null
  user_data                   = fileexists("user_data.sh") ? file("user_data.sh") : null
  subnet_id                   = local.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.tags
  }
}

# Define an Elastic IP (optional)
resource "aws_eip" "this" {
  count    = var.assign_eip ? 1 : 0
  instance = aws_instance.this.id
}

# Define an SSH key pair for accessing the instance
resource "aws_key_pair" "this" {
  count      = var.use_key_pair ? 1 : 0
  key_name   = var.key_name
  public_key = file(var.public_key)
}
