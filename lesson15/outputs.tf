# outputs.tf

output "instance_dns_name" {
  value = aws_instance.instance.public_dns
  description = "DNS name of the Instance"
}

# end of outputs.tf
