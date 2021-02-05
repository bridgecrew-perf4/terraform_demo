output "instance_id" {
  description = "Sample instance ID"
  value       = module.test_instance.instance_id
}

output "private_ip" {
  description = "Sample instance type"
  value       = module.test_instance.private_ip
}

output "public_ip" {
  description = "Sample instance type"
  value       = module.test_instance.public_ip
}

output "subnet_id" {
  description = "Sample instance type"
  value       = module.test_instance.subnet_id
}