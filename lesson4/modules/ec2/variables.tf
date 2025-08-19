variable "ami" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}

variable "name" {
  type        = string
  description = "Tag Name pro instanci"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "html_text" {
  type    = string
  default = "Hello from EC2"
}

variable "tags" {
  type    = map(string)
  default = {}
}
