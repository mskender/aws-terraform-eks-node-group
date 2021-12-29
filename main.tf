

resource "aws_eks_node_group" "workers" {

  count = var.create_node_group ? 1:0

  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks-worker[0].arn
  subnet_ids      = var.subnet_ids

  scaling_config { 
      min_size = var.node_scaling["min_size"]
      max_size = var.node_scaling["max_size"]
      desired_size =  var.node_scaling["desired_size"]
      }

  update_config {
    max_unavailable = ( var.max_unavailable == null && var.max_unavailable_percentage == null) ? "1" : var.max_unavailable
    max_unavailable_percentage  = var.max_unavailable_percentage
  }

  instance_types = var.instance_types
  ami_type = var.ami_type
  disk_size =  var.disk_size
  capacity_type = var.capacity_type

  labels = var.labels

  dynamic "taint" {
    for_each = var.taint == null ? [] : [0]
    content {
      key = taint.value["key"]
      value = taint.value["value"]
      effect = taint.value["effect"]
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template == null ? [] : [0]
    content {
      id = launch_template.value["id"] 
      name = launch_template.value["name"]
      version = launch_template.value["version"] == null ? "latest" : aunch_template.value["version"]
    }
  }

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key_name
    source_security_group_ids  = var.ec2_security_group_ids
  }

 force_update_version = var.force_update_version
  depends_on = [
    aws_iam_role_policy_attachment.worker-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-AmazonEC2ContainerRegistryReadOnly,
  ]
}

