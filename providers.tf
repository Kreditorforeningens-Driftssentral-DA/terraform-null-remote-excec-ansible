terraform {
  required_version = "~> 0.13.0"
  required_providers {
    null = {
      # { this line is included due to visual bug in editor, and serves no purpose }
      source = "hashicorp/null"
      version = ">= 2.1.2"
    }
  }
}
