variable "create_role" {
  description = "True to create the role, false otherwise. Defaults to true."
  type = bool
  default = true
}

variable "role_name" {
  description = "Name of the role to create. Default is EC2DomainJoin"
  type = string
  default = "EC2DomainJoin"
}

variable "create_document" {
  description = "True to create the SSM document, false otherwise. Defaults to true."
  type = bool
  default = true
}

variable "document_name" {
  description = "Name of the document to create. Default is EC2DomainJoin"
  type = string
  default = "EC2DomainJoin"
}

variable "directory_id" {
  description = "ID of the AWS managed AD directory."
  type = string
  default = ""
}

variable "directory_name" {
  description = "Name of the AWS managed AD directory."
  type = string
  default = ""
}

variable "dns_ip_addresses" {
  description = "IP addresses of the AWS managed AD directory."
  type = list(string)
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
