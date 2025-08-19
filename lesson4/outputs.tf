output "instance_ids" {
  value = { for k, m in module.ec2 : k => m.id }
}

output "public_ips" {
  value = { for k, m in module.ec2 : k => m.public_ip }
}

output "names" {
  value = { for k, m in module.ec2 : k => m.name }
}

output "urls" {
  value = { for k, m in module.ec2 : k => "http://${m.public_ip}" }
}

output "instances" {
  value = {
    for k, m in module.ec2 : k => {
      id        = m.id
      name      = m.name
      public_ip = m.public_ip
      url       = "http://${m.public_ip}"
    }
  }
}
