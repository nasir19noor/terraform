variable "project" {
 type        = string
 description = "Project Name"
 default     = "SJ-DMS-POC"
}

variable "env" {
 type        = string
 description = "Environemnt"
 default     = "Source"
}

variable "cidrs" {
 type        = string
 description = "cidrs source"
 default     = "10.1.0.0/16"
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]
}

variable "data_subnet_cidrs" {
 type        = list(string)
 description = "Data Subnet CIDR values"
 default     = ["10.1.21.0/24", "10.1.22.0/24", "10.1.23.0/24"]
}