output "aws_instance-public_ip" {
    value = aws_instance.mywebserver.public_ip
}