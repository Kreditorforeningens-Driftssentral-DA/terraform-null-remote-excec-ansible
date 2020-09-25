terraform {
  required_version = "~> 0.13"
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "<= 2.1.2"
    }
  }
}