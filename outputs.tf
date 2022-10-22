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

output "value" {
  description = "SSMPFS value stored in SSM"
  value       = var.value
  sensitive   = true
}

output "num_blocks" {
  description = "Number of blocks in SSM used to store the value"
  value       = local.num_blocks
}

output "block_size" {
  description = "Size of each block"
  value       = var.block_size
}

output "name" {
  description = "Base name of the SSM parameter used to store the value"
  value       = var.name
}