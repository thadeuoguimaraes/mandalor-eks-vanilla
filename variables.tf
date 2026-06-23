# ─────────────────────────────────────────────
# Cluster
# ─────────────────────────────────────────────

variable "project_name" {
  type        = string
  description = "Nome do projeto, usado como prefixo nos recursos"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "region" {
  type        = string
  description = "Região AWS onde os recursos serão criados"
}

variable "profile" {
  type        = string
  description = "AWS CLI profile a ser usado"
  default     = "default"
}

variable "k8s_version" {
  type        = string
  description = "Versão do Kubernetes"
  default     = "1.33"
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas a todos os recursos"
  default = {
    ManagedBy = "terraform"
  }
}

# ─────────────────────────────────────────────
# Rede — SSM Parameters
# ─────────────────────────────────────────────

variable "ssm_vpc" {
  type        = string
  description = "Caminho SSM do ID da VPC"
}

variable "ssm_public_subnets" {
  type        = list(string)
  description = "Lista de caminhos SSM das subnets públicas"
  default     = []
}

variable "ssm_private_subnets" {
  type        = list(string)
  description = "Lista de caminhos SSM das subnets privadas"
}

variable "ssm_pod_subnets" {
  type        = list(string)
  description = "Lista de caminhos SSM das subnets de pods"
  default     = []
}

# ─────────────────────────────────────────────
# Node Group Principal
# ─────────────────────────────────────────────

variable "nodes_instance_sizes" {
  type        = list(string)
  description = "Tipos de instância do node group principal"
  default     = ["t3.xlarge"]
}

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
  description = "Configurações de autoscaling do node group principal"
  default = {
    min     = 1
    max     = 5
    desired = 2
  }
}

# ─────────────────────────────────────────────
# EKS Addons
# ─────────────────────────────────────────────

variable "addon_cni_version" {
  type        = string
  description = "Versão do addon VPC CNI"
  default     = "v1.21.1-eksbuild.8"
}

variable "addon_coredns_version" {
  type        = string
  description = "Versão do addon CoreDNS"
  default     = "v1.11.4-eksbuild.33"
}

variable "addon_kubeproxy_version" {
  type        = string
  description = "Versão do addon Kube-Proxy"
  default     = "v1.33.10-eksbuild.13"
}

variable "addon_ebs_csi_version" {
  type        = string
  description = "Versão do addon AWS EBS CSI Driver"
  default     = "v1.59.0-eksbuild.1"
}
