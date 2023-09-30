variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
}

variable "destination_cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
}