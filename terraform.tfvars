counter = 1

region  = "eu-central-1"
profile = "default"

ami           = "ami-0a6dc7529cd559185"
instance_type = "t2.micro"

conn_type = "ssh"
conn_user = "ec2-user"

sample_file = "assets/sample_file.txt"

ssh_public_key  = "~/.ssh/id_rsa.pub"
ssh_private_key = "~/.ssh/id_rsa"

database_name = "demo-db"
db_instance_type = "db.t3.micro"