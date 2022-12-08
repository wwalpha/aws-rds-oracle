resource "random_id" "this" {
  byte_length = 4
}

# ----------------------------------------------------------------------------------------------
# Amazon S3 (archive用)
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "archive" {
  bucket = "rds-proxy-${random_id.this.hex}"
}

# ----------------------------------------------------------------------------------------------
# Archive file - Lambda default module
# ----------------------------------------------------------------------------------------------
data "archive_file" "lambda_default" {
  type        = "zip"
  output_path = "${path.module}/dist/default.zip"

  source {
    content  = <<EOT
exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!'),
  };
  return response;
};
EOT
    filename = "index.js"
  }
}

# ----------------------------------------------------------------------------------------------
# S3 Object - Lambda module
# ----------------------------------------------------------------------------------------------
resource "aws_s3_object" "lambda_module" {
  bucket = aws_s3_bucket.archive.bucket
  key    = "lambda.zip"
  source = data.archive_file.lambda_default.output_path

  lifecycle {
    ignore_changes = [
      etag
    ]
  }
}
