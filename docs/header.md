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




