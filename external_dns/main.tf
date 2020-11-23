terraform {
  backend "s3" {
    bucket = "s3://proj747-tf-itau"
    key    = "externaldns/terraform.tfstate"
    region = "sa-east-1"
  }
}
