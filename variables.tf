variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "ami_id" {
  description = "The id of the ami to use with the instance"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "The reference to the template file to set up the instance"
  default     = null
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = ""
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = "default"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "private_subnet_id" {
  description = "The VPC Private Subnet ID to launch in"
  type        = string
  default     = null
}

variable "public_subnet_id" {
  description = "The VPC Public Subnet ID to launch in"
  type        = string
  default     = null
}

variable "private_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "public_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch the load balancer if its not internal type"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
  type        = bool
  default     = true
}

variable "description_sg" {
    description = "The purpose of the security group"
    type        = string
    default     = "Allow TCP/8080, JNLP for jenkins master and slaves"
}

variable "vpc_id" {
    description = "The Id of the vpc where to mount the reources"
    type        = string
    default     = ""  
}

variable "rules" {
    description = "The map of list of the rules assigned to the securitu group that can access the EFS resource"
    type        = map(list(any)) 
    default     = {}
}

variable "security_group_ingress_rules" {
    description = "The name of the security group rule map must be provided here"
    type        = list(string)
    default     = [] 
}

variable "security_group_tags" {
    description = "A map of tags to add to Security Group for EFS"
    type        = map(string)
    default     = {}  
}

variable "instance_depends_on" {
    description = "A list of resources that must be created first prior the resource"
    type        = any
    default     = [] 
}














