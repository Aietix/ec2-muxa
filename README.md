
This Terraform code allows you to create an EC2 instance on AWS with various customizable options.  
- You can choose the latest Ubuntu or Amazon Machine Image (AMI).
- Enables SSH access using your public key, assigns an Elastic IP address.  
- You can specify the Subnet ID to launch the instance into. Otherwise, the first subnet in the default VPC will be used.
- Ingress and Egress rules in format "port,protocol,cidr;port,protocol,cidr".

You can create a **user_data.sh** file where you can add bash commands.  
This file will be used as a bootstrap script during EC2 instance creation.

- Amazon AMI users: **ec2-user**  
- Ubuntu AMI users: **ubuntu**




```
module "ec2-muxa" {
  source = "github.com/Aietix/ec2-muxa"

  name          = "ec2-test"                           # Resource tags
  region        = "us-east-1"                          # AWS region
  ami_type      = "Amazon"                             # 'ubuntu' or 'amazon'
  instance_type = "t2.micro"                           # EC2 instance type
  subnet_id     = ""                                   # The Subnet ID to launch the instance. If not provided, the first subnet in the default VPC will be used.
  assign_eip    = false                                # Assign Elastic IP
  public_ip     = true                                 # Custom; likely controls public IP assignment
  use_key_pair  = true                                 # Use SSH key pair
  public_key    = "~/.ssh/id_rsa.pub"                  # SSH public key path on your local machine
  ingress       = "22,tcp,0.0.0.0/0;443,tcp,0.0.0.0/0" # Ingress rules in format "port,protocol,cidr;port,protocol,cidr"
  egress        = ""                                   # Egress rules in format "port,protocol,cidr;port,protocol,cidr"
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

