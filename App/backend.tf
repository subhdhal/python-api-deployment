terraform {
  backend "s3" {
    bucket = "my-app-py-deploy-876534"
    key    = "backend/App.tfstate"
    region = "eu-west-1"
    dynamodb_table = "my-app-py-dynamo"
  }
}