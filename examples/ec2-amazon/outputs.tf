output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2-muxa.instance_id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2-muxa.ip_address
}
