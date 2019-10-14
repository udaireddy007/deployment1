resource "aws_s3_bucket" "aws_s3_bucket_test" {
  bucket = "bucket-name--${var.env}"
  acl    = "private"

  tags = {
    Name        = "anyname"
    Environment = "${var.env}"
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
