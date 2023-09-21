module "minikube" {
  source = "./modules/minikube"

  cluster_name = "unleash"
  addons = ["ingress", "ingress-dns", "dashboard"]
}

// Kubernetes
provider "kubernetes" {
  host = module.minikube.docker_host

  client_certificate     = module.minikube.docker_client_certificate
  client_key             = module.minikube.docker_client_key
  cluster_ca_certificate = module.minikube.docker_cluster_ca_certificate
}

resource "kubernetes_namespace" "unleash" {
  metadata {
    name = "unleash"
  }
}

// Helm
provider "helm" {
  kubernetes {
    host = module.minikube.docker_host

    client_certificate     = module.minikube.docker_client_certificate
    client_key             = module.minikube.docker_client_key
    cluster_ca_certificate = module.minikube.docker_cluster_ca_certificate
  }
}

// Helm Unleash
resource "helm_release" "unleash" {
  name       = "unleash"
  repository = "https://docs.getunleash.io/helm-charts"
  chart      = "unleash"
  namespace  = "unleash"

  set {
    name  = "secrets.INIT_CLIENT_API_TOKENS"
    value = "default:development.unleash-insecure-api-token"
  }
}

resource "helm_release" "unleash-edge" {
  name       = "unleash-edge"
  repository = "https://docs.getunleash.io/helm-charts"
  chart      = "unleash-edge"
  namespace  = "unleash"

  set {
    name  = "secrets.TOKENS"
    value = "default:development.unleash-insecure-api-token"
  }
}
