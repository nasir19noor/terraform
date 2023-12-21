variable "project" {
 type        = string
 description = "Project Name"
 default     = "Terraform"
}

variable "dev_cidrs" {
 type        = string
 description = "cidrs dev"
 default     = "10.1.0.0/16"
}

variable "prod_cidrs" {
 type        = string
 description = "cidrs prod"
 default     = "10.2.0.0/16"
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "dev_public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
 
variable "dev_private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]
}

variable "prod_public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "prod_private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]
}