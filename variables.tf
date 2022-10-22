variable "name" {
  description = "SSM Parameter name"
  type        = string
}

variable "type" {
  type    = string
  default = "SecureString"
}

variable "block_size" {
  description = "Max size of each block of data"
  type        = number
  default     = 4096
}

variable "value" {
  description = "Value to store in SSM Parameter"
  type        = string
}

variable "format" {
  description = "Format of parameter name in SSM Parameter"
  type        = string
  default     = "%s/%s-of-%s"
}

variable "disable_number_when_single_block" {
  description = "Disable format name with count when only one block is used"
  type        = bool
  default     = true
}
