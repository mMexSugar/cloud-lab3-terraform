variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  default = "europe-west3"
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_a_cidr" {
  type = string
}

variable "subnet_b_cidr" {
  type = string
}

variable "web_port" {
  type = number
}

variable "server_name" {
  type = string
}

variable "doc_root" {
  type = string
}