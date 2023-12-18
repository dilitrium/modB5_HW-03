variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

#variable "cloud_id" {
#  description = "The cloud ID"
#  type        = string
#}

#variable "folder_id" {
#  description = "The folder ID"
#  type        = string
#}

#variable "default_zone" {
#  description = "The default zone"
#  type        = string
#  default     = "ru-cenral1-a"
#}
