resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name


  tags = merge(
    {
      Environment = var.environment
      Course      = "Terraform"
      Name        = var.name
    },
    var.tags
  )

  user_data = <<-EOF
    #!/bin/bash
    set -eux
    dnf -y update
    dnf -y install httpd
    systemctl enable --now httpd
    echo "<html><h1>${var.html_text}</h1></html>" > /var/www/html/index.html
  EOF

  user_data_replace_on_change = true
}