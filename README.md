
This Terraform code allows you to create an EC2 instance on AWS with various customizable options. It provides the flexibility to choose the latest Ubuntu or Amazon Machine Image (AMI), enables SSH access using your public key, assigns an Elastic IP address, and allows for the selection of either the default VPC or a specific VPC.

Inbound traffic on port **22** and port **80** will be opened,  All outbound traffic is allowed by default.

You can create a **user_data.sh** file where you can add bash commands. This file will be used as a bootstrap script during EC2 instance creation.




```
module "ec2-muxa" {
  source = "github.com/Aietix/ec2-muxa"

  region        = "eu-central-1"      # The AWS region for creating resources
  ami_type      = "ubuntu"            # Specify 'ubuntu' or 'amazon' to select the respective AMI.
  instance_type = "t2.micro"          # the type of EC2 instance to use
  assign_eip    = false               # Whether to assign an Elastic IP to the instance
  vpc_id        = ""                  # The VPC ID to launch the instance into. If not provided, the default VPC will be used.
  use_key_pair  = true                # Whether to use a SSH key pair for the instance connection
  public_key    = "~/.ssh/id_rsa.pub" # Path to the SSH public key
  key_name      = "ec2-test"          # The name of the key pair for SSH access
  tags          = "ec2-test"          # Tags to assign to resources
}


output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = module.ec2-muxa.instance_id
}

output "instance_ip" {
  description = "Elastic IP of the EC2 instance if assigned, otherwise Public IP."
  value       = module.ec2-muxa.ip_address
}

output "linux_image" {
  description = "Type of Linux AMI used (Amazon or Ubuntu)."
  value       = module.ec2-muxa.linux_image
}
```


Here's an example of the **user_data.sh** for Ubuntu:



```
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
```

