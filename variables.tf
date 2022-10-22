# terraform-module-ssmpfs
# Copyright (C) 2020 Nigel Gibbs
#
# This file is part of terraform-module-ssmpfs.
#
# terraform-module-ssmpfs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# terraform-module-ssmpfs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with terraform-module-ssmpfs.  If not, see <https://www.gnu.org/licenses/>.

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
