terraform {
  backend "s3" {
    bucket         = "final-project-terraform-state-unique-olga"
    key            = "final-project/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}