
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

# Data pro servery (může být i ve variables.tf)
locals {
  servers = {
    server1 = "Ahoj z prvního serveru"
    server2 = "Nazdar z druhého serveru"
    server3 = "Čau z třetího serveru"
  }
}

module "ec2" {
  source   = "./modules/ec2"
  for_each = local.servers

  ami           = "ami-0de716d6197524dd9"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  name        = each.key
  environment = "dev"
  html_text   = each.value

  # volitelné extra tagy
  tags = {
    Owner = "randy"
  }
}
