# Лабораторна робота №3: Інфраструктура як код (Terraform)
Виконав: Циганок Максим (Варіант 12)

## Опис проєкту
Розгортання інфраструктури в Google Cloud Platform (VPC, Subnets, VM з Apache) за допомогою Terraform.

## Передумови (Prerequisites)
1. Встановлений [Terraform](https://www.terraform.io/downloads).
2. Встановлений та авторизований [Google Cloud SDK](https://cloud.google.com/sdk/docs/install).
3. Створений бакет для Backend: `gs://tf-state-lab3-tsyhanok-maksym-12`.

## Основні команди
* `terraform init` — ініціалізація та завантаження провайдерів.
* `terraform plan` — перегляд плану змін.
* `terraform apply` — застосування конфігурації.
* `terraform destroy` — видалення всіх створених ресурсів.