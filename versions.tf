terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    unleash = {
      source = "philips-labs/unleash"
    }
  }
}
