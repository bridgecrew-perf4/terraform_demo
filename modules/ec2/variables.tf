# instance vars
variable "counter" {}
variable "ami" {}
variable "instance_type" {}
variable "ec2-security_group_ids" {
    type = list(string)
    default = []
}

# provisioner connection vars
variable "conn_type" {}

variable "conn_user" {}

# assets
variable "sample_file" {}

# SSH keys
variable "ssh_public_key" {}

variable "ssh_private_key" {}

variable "sample_app_data" {}