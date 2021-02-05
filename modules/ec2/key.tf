resource "aws_key_pair" "mvashkevich" {
  key_name   = "mvashkevich_key"
  public_key = file(var.ssh_public_key)
}

