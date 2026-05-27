# ── Cluster ────────────────────────────────────────────────────────────────────

output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint da API do cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Versão do Kubernetes"
  value       = module.eks.cluster_version
}

output "cluster_arn" {
  description = "ARN do cluster EKS"
  value       = module.eks.cluster_arn
}

output "cluster_security_group_id" {
  description = "ID do security group do cluster"
  value       = module.eks.cluster_security_group_id
}

# ── OIDC ───────────────────────────────────────────────────────────────────────

output "oidc_provider_arn" {
  description = "ARN do OIDC provider (para criar IRSA roles)"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "URL do OIDC provider"
  value       = module.eks.oidc_provider_url
}

# ── IAM ────────────────────────────────────────────────────────────────────────

output "node_role_arn" {
  description = "ARN da IAM role dos worker nodes"
  value       = module.eks.node_role_arn
}

output "cluster_autoscaler_role_arn" {
  description = "ARN da IAM role do Cluster Autoscaler"
  value       = module.eks.cluster_autoscaler_role_arn
}

# ── KMS ────────────────────────────────────────────────────────────────────────

output "kms_key_arn" {
  description = "ARN da KMS key para encriptação de secrets"
  value       = module.eks.kms_key_arn
}

# ── Rede — SSM ─────────────────────────────────────────────────────────────────

output "vpc_id" {
  description = "ID da VPC"
  value       = data.aws_ssm_parameter.vpc.value
  sensitive   = true
}

output "private_subnets" {
  description = "IDs das subnets privadas"
  value       = data.aws_ssm_parameter.private_subnets[*].value
  sensitive   = true
}
