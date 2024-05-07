variable "project" {
 type        = string
 description = "Project Name"
 default     = "sj-dms-poc"
}

variable "env" {
 type        = string
 description = "Environemnt"
 default     = "source"
}

variable "engine" {
 type        = list(string)
 description = "engine name"
 default     = ["postgres"]
}

variable "engine_version" {
 type        = list(string)
 description = "engine version"
 default     = ["13.11"]
}


variable "identifier" {
 type        = string
 description = "identifier"
 default     = "sj-dms-poc-source"
}

variable "storage" {
 type        = string
 description = "storage"
 default     = "20"
}

variable "instance_type" {
 type        = list(string)
 description = "instance Type"
 default     = ["db.t3.micro", "db.t3.small"]
}

variable "parameter_group_name" {
 type        = string
 description = "Parameter Group Name"
 default     = "default.postgres13"
}

variable "username" {
 type        = string
 description = "username"
 sensitive   = true
}

variable "password" {
 type        = string
 description = "password"
 sensitive   = true
}
