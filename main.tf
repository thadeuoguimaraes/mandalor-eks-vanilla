module "eks" {
  source = "github.com/thadeuguimaraes/mandalor-eks-module?ref=v1.0.0"

  # ── Cluster ──────────────────────────────────────────────────────────────────
  cluster_name       = var.cluster_name
  kubernetes_version = var.k8s_version

  # ── Rede (valores obtidos via SSM) ────────────────────────────────────────
  vpc_id             = data.aws_ssm_parameter.vpc.value
  private_subnet_ids = data.aws_ssm_parameter.private_subnets[*].value
  public_subnet_ids  = data.aws_ssm_parameter.public_subnets[*].value
  pod_subnet_ids     = data.aws_ssm_parameter.pod_subnets[*].value

  # ── Node Group Principal (ON_DEMAND) ──────────────────────────────────────
  enable_node_group_main         = true
  node_group_main_instance_types = var.nodes_instance_sizes
  node_group_main_scaling        = var.auto_scale_options

  # ── Node Groups Opcionais ─────────────────────────────────────────────────
  enable_node_group_spot     = false
  enable_node_group_critical = false
  enable_node_group_graviton = false

  # ── EKS Addons ────────────────────────────────────────────────────────────
  eks_addons = {
    vpc-cni = {
      version = var.addon_cni_version
    }
    coredns = {
      version = var.addon_coredns_version
    }
    kube-proxy = {
      version = var.addon_kubeproxy_version
    }
    aws-ebs-csi-driver = {
      version = var.addon_ebs_csi_version
    }
  }

  # ── Helm Charts ───────────────────────────────────────────────────────────
  enable_cluster_autoscaler = true
  enable_metrics_server     = true
  enable_kube_state_metrics = false

  # NTH é gerenciado fora do módulo (com SQS)
  enable_node_termination_handler = false

  tags = var.tags
}
