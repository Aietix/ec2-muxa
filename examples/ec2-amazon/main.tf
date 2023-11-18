module "ec2-muxa" {
  source        = "../../"
  name          = var.name
  region        = var.region
  ami_type      = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  assign_eip    = var.assign_eip
  public_ip     = var.public_ip
  use_key_pair  = var.use_key_pair
  public_key    = var.public_key
  ingress       = var.ingress
  egress        = var.egress
}