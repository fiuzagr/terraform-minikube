// minikube
provider "minikube" {
  kubernetes_version = "v1.26.3"
}

resource "minikube_cluster" "docker" {
  driver       = "docker"
  cni          = "bridge"
  cluster_name = var.cluster_name
  addons       = concat([
    "default-storageclass",
    "storage-provisioner",
  ], var.addons)
}
