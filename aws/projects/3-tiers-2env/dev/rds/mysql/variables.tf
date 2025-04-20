variable "project" {
 type        = string
 description = "Project Name"
 default     = "Terraform"
}

variable "engine" {
 type        = list(string)
 description = "engine name"
 default     = ["mysql"]
}

variable "engine_version" {
 type        = list(string)
 description = "engine version"
 default     = ["5.7"]
}


variable "identifier" {
 type        = string
 description = "identifier"
 default     = "terraformmysql"
}

variable "storage" {
 type        = string
 description = "storage"
 default     = "20"
}

variable "instance_type" {
 type        = list(string)
 description = "instance Type"
 default     = ["db.t2.micro", "db.t2.small"]
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
