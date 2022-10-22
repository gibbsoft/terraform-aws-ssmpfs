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