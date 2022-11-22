output "bucket_name" {
  value = aws_s3_bucket.archive.bucket
}

output "lambda_module_key" {
  value = aws_s3_object.lambda_module.key
}
