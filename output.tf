output "instance_id" {
  value = length(data.aws_instances.existing.ids) > 0 ? data.aws_instances.existing.ids[0] : aws_instance.mywebserver[0].id
}

output "public_ip" {
  value = length(data.aws_instances.existing.ids) > 0 ? data.aws_instance.existing_server[0].public_ip : aws_instance.mywebserver[0].public_ip
}
