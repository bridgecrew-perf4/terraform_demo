# EC2 security groups
resource "aws_security_group" "sg" {
  name        = "SSH"
  description = "Open inbound 22 port"

  /*ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }*/

  tags = {
    Name = "SSH"
  }
}

resource "aws_security_group_rule" "outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  security_group_id = aws_security_group.sg.id
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  cidr_blocks = [ "0.0.0.0/0" ]
}