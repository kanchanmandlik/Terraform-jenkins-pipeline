# Output existing or new instance ID
output "instance_id" {

  value = length(data.aws_instances.existing.ids) > 0 ?
    data.aws_instances.existing.ids[0] :
    aws_instance.mywebserver[0].id
}
