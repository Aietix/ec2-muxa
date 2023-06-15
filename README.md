
This Terraform code allows you to create an EC2 instance on AWS with various customizable options. It provides the flexibility to choose the latest Ubuntu or Amazon Machine Image (AMI), enables SSH access using your public key, assigns an Elastic IP address, You can specify the Subnet ID to launch the instance into. Otherwise, the first subnet in the default VPC will be used.

Inbound traffic on port **22** and port **80** will be opened,  All outbound traffic is allowed by default.

You can create a **user_data.sh** file where you can add bash commands. This file will be used as a bootstrap script during EC2 instance creation.

The default user for Amazon AMI is: **ec2-user**
For Ubuntu AMI, the default user is: **ubuntu**


```
module "ec2-muxa" {
  source = "github.com/Aietix/ec2-muxa"

  region        = "us-east-1"         # AWS region
  ami_type      = "Amazon"            # 'ubuntu' or 'amazon'
  instance_type = "t2.micro"          # EC2 instance type
  subnet_id     = ""                  # The Subnet ID to launch the instance into. If not provided, the first subnet in the default VPC will be used
  assign_eip    = false               # Assign Elastic IP
  public_ip     = true                # Custom; likely controls public IP assignment
  use_key_pair  = true                # Use SSH key pair
  public_key    = "~/.ssh/id_rsa.pub" # SSH public key path on your local machine
  key_name      = "ec2-test"          # SSH key pair name
  name          = "ec2-test"          # Resource tags
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

