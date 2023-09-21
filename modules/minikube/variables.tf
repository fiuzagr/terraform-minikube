variable "cluster_name" {
  description = "Name of the cluster. Must be unique."
  type        = string
}

variable "addons" {
  description = "Minikube addons list."
  type        = list(string)
  default     = []
}
