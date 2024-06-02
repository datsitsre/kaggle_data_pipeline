terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}


provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "bucket-db-us" {
    bucket = var.s3_name 
    force_destroy = true

    tags = {
      Name      = var.tags_name
      Environment = var.tags_dev
}
}

//'''
//resource "aws_s3_bucket_object" "object-project-pipe" {
//  bucket = aws_s3_bucket.bucket-db-us.id
//  key = "drivers_new.csv"
//  source = "/mnt/c/Users/DELL/Desktop/Software/preflet/update_data/drivers_new.csv"
//  

resource "aws_s3_bucket_object" "object-project-pip" {
  for_each = fileset("${path.cwd}/../updata", "**/*.*")
  bucket = var.s3_name
  key = "${each.value}" 
  source = "${path.cwd}/../updata/${each.value}"
}  


// Configure IAM role to read-only access to s3
resource "aws_iam_role" "redshift-role-access" {
  name = "RedShiftLoadReadOnly"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

  assume_role_policy = jsonencode({
    "Version": "2012-10-17"
    Statement :[
      {
        Action = "sts:AssumeRole" 
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]

  })
  
}

//resource "aws_security_group" "secure_group_redshift" {
//  name = "security_group_redshift" 
//  ingress {
//    from_port = 0
//    to_port = 0
//    protocol = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }

 // egress {
  ////  from_port = 0
    ////to_port = 0
   // pr//otocol = "-1"
    //cidr_blocks = ["0.0.0.0/0"]
  //}
//}

resource "aws_redshift_cluster" "redshift-pipe-cluster" {
   cluster_identifier = var.redshift_identifier
  database_name      = var.redshift_database
  master_username    =  var.master-usernam
  master_password    = var.key_password
  node_type          = var.node_type
  cluster_type       = var.cluster-type
  publicly_accessible = true
  iam_roles = [aws_iam_role.redshift-role-access.arn]
 // vpc_security_group_ids = [aws_security_group.secure_group_redshift.id]

  skip_final_snapshot = true
  
}