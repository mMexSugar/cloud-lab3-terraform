terraform {
  backend "gcs" {
    bucket = "tf-state-lab3-tsyhanok-maksym-12"
    prefix = "env/dev" # Відповідає шаблону env/dev/var-12.tfstate
  }
}