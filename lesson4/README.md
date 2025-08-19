**Terraform — EC2 (User Data, Multiple Instances, Remote State, Module)**

Krátký README pro aktuální repo s backendem (S3 + DynamoDB).


**Co projekt dělá**

User Data: nainstaluje Apache (AL2023, dnf), vytvoří /var/www/html/index.html.

Multiple Instances: vytváří 3 EC2 instance přes for_each, každá s jiným názvem a textem.

Remote State: ukládá state do S3 a používá DynamoDB pro locking.

Module: EC2 je zapouzdřena v modulu modules/ec2.


**Požadavky**

Terraform ≥ 1.6

AWS CLI s oprávněními do EC2, S3, DynamoDB

Region: us-east-1

S3 bucket: terraform-state-radimvopava-devops

DynamoDB tabulka: terraform-locks


**Struktura**
.
├─ main.tf            # volání modulu, key pair, (obsahuje i backend blok)
├─ variables.tf
├─ outputs.tf
└─ modules/
   └─ ec2/
      ├─ main.tf      # EC2 + user_data
      ├─ variables.tf
      └─ outputs.tf

**Použití**

terraform init               # při prvním spuštění / po změně backendu
nebo: terraform init -migrate-state  (při přesunu lokálního state do S3)
terraform fmt
terraform validate
terraform plan
terraform apply

**Výstupy:**

terraform output instances   # mapa: jméno -> { id, public_ip, url }
terraform output public_ips
terraform output urls
Přístup

Web: http://<PUBLIC_IP>

SSH (Amazon Linux): ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes ec2-user@<PUBLIC_IP>

**Poznámky**

Backend (S3 + DynamoDB) je již nakonfigurován v TF kódu. Pokud repo forknete, upravte názvy bucketu/tabulky a region.

Security Group musí povolit HTTP (80) a SSH (22).

**Úklid**

terraform destroy

(Remote state v S3 zůstává; smažte ho ručně jen když víte, co děláte.)