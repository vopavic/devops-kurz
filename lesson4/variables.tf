variable "test" {
  description = "A test variable"
  type        = string
  default     = "default_value"
}

variable "servers" {
  description = "Jména serverů a jejich uvítací text"
  type        = map(string)
  default = {
    server1 = "Ahoj z prvního serveru"
    server2 = "Nazdar z druhého serveru"
    server3 = "Čau z třetího serveru"
  }
}