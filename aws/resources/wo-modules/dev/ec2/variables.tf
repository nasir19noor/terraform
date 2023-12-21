variable "project" {
 type        = string
 description = "Project Name"
 default     = "Terraform"
}

variable "ami-amazon" {
 type        = list(string)
 description = "AMI AWS Linux [2023, 2]"
 default     = ["ami-0e4b5d31e60aa0acd", "ami-012eebfcf9af751bd"]
}

variable "ami-ubuntu" {
 type        = list(string)
 description = "AMI Ubuntu [22.04, 20.04]"
 default     = ["ami-078c1149d8ad719a7", "ami-03caf91bb3d81b843"]
}

variable "ami-windows" {
 type        = list(string)
 description = "AMI Windows [2022 base, 2019 base]"
 default     = ["ami-0c1e9ce55ec62e2a3", "ami-00eccbd482f9df67b"]
}

variable "instance_type" {
 type        = list(string)
 description = "instance Type"
 default     = ["t2.micro", "t2.small"]
}