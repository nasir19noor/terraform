variable "project" {
 type        = string
 description = "Project Name"
 default     = "terraform"
}

variable "env" {
 type        = string
 description = "Environemnt"
 default     = "prod"
}

variable "cidrs" {
 type        = string
 description = "cidrs prod"
 default     = "10.2.0.0/16"
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]
}

variable "data_subnet_cidrs" {
 type        = list(string)
 description = "Data Subnet CIDR values"
 default     = ["10.2.21.0/24", "10.2.22.0/24", "10.2.23.0/24"]
}