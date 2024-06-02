variable "s3_name" {
    description = "S3 bucket name"
    type = string
    default = "pipe-data-project"
}

variable "aws_region" {
    description = "AWS region"
    type    = string
    default = "us-east-2"
}

variable "tags_name" {
    description = "Tags name"
    type = string
    default = "my_project_data"
}

variable "tags_dev" {
    description = "Tag development of productions"
    type = string
    default = "Dev"
  
}

variable "redshift_identifier" {
    description = "redshift name"
    type    = string
    default = "tf-redshift-cluster"
}

variable "redshift_database" {
    description = "redshift_database"
    type = string
    default = "db_formular"
}
variable "master-usernam" {
    description = "redshift-master-username"
    type    = string
    default = "admin"
}

variable "node_type" {
    description = "The type of node used"
    type = string
    default = "dc2.large"
}

variable "cluster-type" {
    description = "The type of node used"
    type    = string
    default = "single-node"
}

variable "key_password" {
    description = "Password for redshift"
    type = string
    default = "!$%&*()-_=+[]{}<>:?aA1"

  
}