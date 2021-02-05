provider "aws" {
  profile = var.profile
  region  = var.region
}

module "sg_ssh" {
  source = "./modules/sg"

  #sg_id = var.sg_id
}

module "test_instance" {
  source = "./modules/ec2/"

  counter = var.counter

  ami = var.ami
  instance_type = var.instance_type

  ec2-security_group_ids = [module.sg_ssh.id]

  conn_type = var.conn_type
  conn_user = var.conn_user
  ssh_private_key = var.ssh_private_key
  ssh_public_key = var.ssh_public_key

  sample_file = var.sample_file
  sample_app_data = data.template_file.sample-redis-app.rendered

}

data "template_file" "sample-redis-app" {
  template = file("assets/app.template")
  vars = {
    redis_port = aws_elasticache_cluster.redis.cache_nodes.0.port
    redis_endpoint = aws_elasticache_cluster.redis.cache_nodes.0.address
  }
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.17.0"
 
  bucket = "mvashkevich-demo-bucket"

}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-demo"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  security_group_ids = [module.sg_ssh.id]
  engine_version       = "6.x"
  port                 = 6379
}

resource "aws_s3_bucket_object" "sample_file" {
  bucket = module.s3-bucket.this_s3_bucket_id
  key = "sample_file.txt"
  source = var.sample_file
  
}

resource "aws_security_group_rule" "flask-app" {
  type = "ingress"
  from_port = 5000
  to_port = 5000
  protocol = "tcp"
  security_group_id = module.sg_ssh.id
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "redis" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = module.sg_ssh.id
  cidr_blocks = [ "0.0.0.0/0" ]
}