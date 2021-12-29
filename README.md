# EKS Ingress Nginx module for AWS

WARNING: Still in progress, so bound to change often! Do not use this in production (yet)!

## Description

This is a simple module for creating and attaching an EKS node group to existing EKS cluster.

## Examples

An example using an eks module to provision a cluster (https://github.com/mskender/aws-terraform-eks):
```
module "k8s" {
    region = "eu-west-1"
    source = "github.com/mskender/aws-terraform-eks"
    cluster_name = local.cluster_name
    eks_subnet_ids = module.network.public_subnets.*.id
    
    write_kube_config = true
    kube_config_location = local.kubeconfig_loc
    export_kube_config = false
    shellrc_file = "~/.customization"
}

```

Providers are aliased so the location of kube config file is not checked until eks cluster is created and config dumped via "k8s" module in example above:
```
provider kubectl {
    alias = "eks"
    config_path = local.kubeconfig_loc
    
}
provider helm {
    alias = "eks"
    kubernetes{
        config_path = local.kubeconfig_loc
    }
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.eks-worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.eks-worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | AMI type for worker nodes. Consult documentation on valid values. | `string` | `"AL2_x86_64"` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Instance capacity type: [ON\_DEMAND\|SPOT] | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name to associate woker node group with | `string` | n/a | yes |
| <a name="input_create_node_group"></a> [create\_node\_group](#input\_create\_node\_group) | Whether to create a EKS node group | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GB to provision for worker nodes. | `string` | `"30"` | no |
| <a name="input_ec2_security_group_ids"></a> [ec2\_security\_group\_ids](#input\_ec2\_security\_group\_ids) | Security Group ID's to allow ingress to node group instances. If omitted, TCP/22 will be allowed from 0/0 if SSH key name is specified. | `list(string)` | `null` | no |
| <a name="input_ec2_ssh_key_name"></a> [ec2\_ssh\_key\_name](#input\_ec2\_ssh\_key\_name) | SSH key name for accessing nodes | `string` | `null` | no |
| <a name="input_force_update_version"></a> [force\_update\_version](#input\_force\_update\_version) | Whether to force version update if pods cannot be drained. | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Type of worker node instance | `list(string )` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of label = value pars to label the node groups with. | `map(any)` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Optionally, launch node group from a launch template - name (or id, not both ) and version required. Can use keyword 'latest' for version or assign null to use latest template version. | <pre>object ({<br>        id = string<br>        name = string<br>        version = string<br>    })</pre> | `null` | no |
| <a name="input_max_unavailable"></a> [max\_unavailable](#input\_max\_unavailable) | Max unavailable workers during node group update | `string` | `null` | no |
| <a name="input_max_unavailable_percentage"></a> [max\_unavailable\_percentage](#input\_max\_unavailable\_percentage) | Max unavailable percentage of workers during node group update | `string` | `null` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | Worker node group name. | `string` | n/a | yes |
| <a name="input_node_scaling"></a> [node\_scaling](#input\_node\_scaling) | Worker node autoscaling group scaling constraints | <pre>object({<br>        max_size = number<br>        min_size = number<br>        desired_size = number <br>    })</pre> | <pre>{<br>  "desired_size": 1,<br>  "max_size": 1,<br>  "min_size": 1<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ID's to spawn the worker nodes in | `list(string)` | n/a | yes |
| <a name="input_taint"></a> [taint](#input\_taint) | A taint block (or multiple taint blocks) to be applied to the node group. | <pre>object({<br>        key = string<br>        value = string<br>        effect = string<br>    })</pre> | `null` | no |

## Outputs

No outputs.
