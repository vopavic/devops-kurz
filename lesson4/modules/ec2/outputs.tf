output "id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "name" {
  value = aws_instance.web.tags["Name"]
}
