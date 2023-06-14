output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.this.id
}

output "ip_address" {
  description = "Elastic IP of the EC2 instance if assigned, otherwise Public IP."
  value       = length(aws_eip.this) > 0 ? aws_eip.this[0].public_ip : aws_instance.this.public_ip
}

output "linux_image" {
  description = "Type of Linux AMI used (Amazon or Ubuntu)."
  value       = var.ami_type == "amazon" ? "Amazon Linux AMI used" : "Ubuntu Linux AMI used"
}
