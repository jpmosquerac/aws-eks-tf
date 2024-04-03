resource "aws_s3_bucket" "logs_bucket" {
  bucket        = "${var.s3_bucket_name}-${var.aws_account}-logs"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "logs_bucket_boc" {
  bucket = aws_s3_bucket.logs_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "logs_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.logs_bucket_boc]

  bucket = aws_s3_bucket.logs_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = "${var.s3_bucket_name}-${var.aws_account}"

  /*
    Note:
    Currently Terraform will not force destroy a bucket if it contains versioned files.
    All versions will have to be deleted manually first (ie. empty the bucket).
  */
  force_destroy = false

  tags = {
    Name      = "Terraform Remote State bucket"
    Env       = var.aws_environment
    Comment   = "used to store Terraform state files"
    Terraform = "True"
  }
}

resource "aws_s3_bucket_ownership_controls" "remote_state_bucket_boc" {
  bucket = aws_s3_bucket.remote_state_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "remote_state_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.remote_state_bucket_boc]

  bucket = aws_s3_bucket.remote_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "remote_state_bucket_versioning" {
  bucket = aws_s3_bucket.remote_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state_bucket_ssec" {
  bucket = aws_s3_bucket.remote_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.encryption_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "remote_state_bucket_logging" {
  bucket = aws_s3_bucket.remote_state_bucket.id

  target_bucket = aws_s3_bucket.logs_bucket.id
  target_prefix = "logs/"
}