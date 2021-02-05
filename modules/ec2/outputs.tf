output "instance_id" {
  description = "Sample instance type"
  value       = aws_instance.instance.*.id
}

output "private_ip" {
  description = "Sample instance type"
  value       = aws_instance.instance.*.private_ip
}

output "public_ip" {
  description = "Sample instance type"
  value       = aws_instance.instance.*.public_ip
}

output "subnet_id" {
  value = aws_instance.instance.0.subnet_id
}