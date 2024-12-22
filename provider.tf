provider "aws" {
  region     =  var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# acm用
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}