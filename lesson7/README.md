# ECS Nginx Demo

## Popis
Nginx aplikace běžící na AWS ECS Fargate za Application Load Balancerem. Infrastruktura je spravována Terraformem, nasazení přes GitHub Actions.

## Architektura
- AWS ECS Fargate cluster
- 1× ECS Service (1 task) s Task Definition 256 CPU / 512 MB
- Application Load Balancer s health-check `/`
- CloudWatch Logs
- State v S3 (DynamoDB lock)

## Nasazení
1. Vytvoř S3 bucket + DynamoDB tabulku pro Terraform state (viz README / script).
2. Uprav `terraform/versions.tf` backend (bucket/region).
3. Nastav GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
4. Push do `main` odstartuje workflow.

## Lokální test
```bash
cd terraform
terraform init
terraform validate
terraform apply -auto-approve
terraform output load_balancer_url
