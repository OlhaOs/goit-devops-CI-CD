terraform {
  backend "s3" {
    bucket         = "lesson-8-terraform-state-unique-olga"
    key            = "lesson-8/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}