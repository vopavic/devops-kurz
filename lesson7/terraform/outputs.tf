output "load_balancer_dns" {
  description = "DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "load_balancer_url" {
  description = "URL of the load balancer"
  value       = "http://${aws_lb.main.dns_name}"
}
