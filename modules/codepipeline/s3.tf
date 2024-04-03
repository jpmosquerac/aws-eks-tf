
resource "aws_s3_bucket" "s3_bucket_codepipeline" {
  bucket = "${var.s3_bucket_name_codepipeline}-${var.aws_account}"

  force_destroy = false
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_codepipeline_boc" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_codepipeline_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_codepipeline_boc]
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket_codepipeline_versioning" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "terraform_folder" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  key    = "codepipeline/"
}