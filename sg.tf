resource "aws_security_group" "this" {
  name        = "allow_ssh_and_http"
  description = "Allow SSH and HTTP inbound traffic, all outbound traffic"

  # Use provided VPC ID or default VPC ID
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  # Allow SSH inbound traffic on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP inbound traffic on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}