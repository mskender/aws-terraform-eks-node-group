variable "create_node_group" {
    type = bool
    default = false
    description = "Whether to create a EKS node group"
}

variable "cluster_name" {
    type = string
    description = "EKS cluster name to associate woker node group with"
}

variable "node_group_name" {
    type = string
    description = "Worker node group name."
}

variable node_scaling {
    type = object({
        max_size = number
        min_size = number
        desired_size = number 
    })
    default = {
        max_size = 1
        min_size = 1
        desired_size = 1
    }
    description = "Worker node autoscaling group scaling constraints"
}

variable "subnet_ids" {
    type = list(string)
    description = "A list of subnet ID's to spawn the worker nodes in"
}

variable "max_unavailable" {
    description = "Max unavailable workers during node group update"
    type = string
    default = null
}

variable "max_unavailable_percentage" {
    description = "Max unavailable percentage of workers during node group update"
    type = string
    default = null
}

variable instance_types {
    type = list(string )
    default = ["t3.medium"]
    description = "Type of worker node instance"
}

variable ami_type {
    type = string
    default = "AL2_x86_64"
    description = "AMI type for worker nodes. Consult documentation on valid values."
}

variable disk_size {
    type = string
    default =  "30"
    description = "Disk size in GB to provision for worker nodes."
}

variable capacity_type {
    type = string
    default =  "ON_DEMAND"
    description = "Instance capacity type: [ON_DEMAND|SPOT]"
}

variable taint {
    type = list(object({
        key = string
        value = string
        effect = string
    }))
    default = []
    description = "A taint block (or multiple taint blocks) to be applied to the node group."
}

variable labels {
    type = map(any)
    default = null
    description = "A map of label = value pars to label the node groups with."
}

variable launch_template {
    type = list(object ({
        id = string
        name = string
        version = string
    }))
    default = []
    description = "Optionally, launch node group from a launch template - name (or id, not both ) and version required. Can use keyword 'latest' for version or assign null to use latest template version."
}
 
variable ec2_ssh_key_name {
    type = string
    default = null
    description = "SSH key name for accessing nodes"
}

variable ec2_security_group_ids {
    type = list(string)
    default = null
    description = "Security Group ID's to allow ingress to node group instances. If omitted, TCP/22 will be allowed from 0/0 if SSH key name is specified."
}
  
variable force_update_version {
    type = bool
    default = false
    description = "Whether to force version update if pods cannot be drained."
}

