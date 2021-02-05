resource "aws_instance" "instance" {
    count           = var.counter

    ami             = var.ami
    instance_type   = var.instance_type
    vpc_security_group_ids = var.ec2-security_group_ids
    key_name        = aws_key_pair.mvashkevich.key_name

    user_data = file("assets/user_data.sh")
    
    tags = {
        Name = "SAMPLE_INSTANCE"
    }

    connection {
    type        = var.conn_type
    user        = var.conn_user
    host        = self.public_ip
    private_key = file(var.ssh_private_key)

    }

    provisioner "file" {
    content      = var.sample_app_data
    destination = "~/app.py"
    }

    provisioner "file" {
        source = "./assets/templates"
        destination = "~"
    }

    provisioner "remote-exec" {
    inline = ["cd ~ && nohup flask run --host=0.0.0.0 > flask.out 2>&1 &"]
    }
}