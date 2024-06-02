output "module_path" {
    value = path.cwd
}
output "key_password" {
    value = var.key_password
}

output "tf_redshift_id" {
    value = var.redshift_identifier
}

output "tf_database" {
    value = var.redshift_database
}