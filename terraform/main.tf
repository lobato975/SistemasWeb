provider "aws" {
  region = "us-east-1"
}

# Criando o bucket S3 para armazenamento de imagens
resource "aws_s3_bucket" "image_storage" {
  bucket = "pinterest-like-app-image-storage"
  acl    = "private"
}

# Criando a fila SQS para fila de eventos
resource "aws_sqs_queue" "event_queue" {
  name = "pinterest-like-app-event-queue"
}

# Criando as funções Lambda para processamento de imagens e dados
resource "aws_lambda_function" "image_upload" {
  function_name = "image_upload"
  handler       = "image_upload.handler"
  runtime       = "python3.8"

  # S3 bucket onde o código da função será armazenado
  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "image_upload.zip"
}

resource "aws_lambda_function" "image_resize" {
  function_name = "image_resize"
  handler       = "image_resize.handler"
  runtime       = "python3.8"

  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "image_resize.zip"
}

resource "aws_lambda_function" "metadata_extraction" {
  function_name = "metadata_extraction"
  handler       = "metadata_extraction.handler"
  runtime       = "python3.8"

  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "metadata_extraction.zip"
}

resource "aws_lambda_function" "categorize_content" {
  function_name = "categorize_content"
  handler       = "categorize_content.handler"
  runtime       = "python3.8"

  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "categorize_content.zip"
}

resource "aws_lambda_function" "recommendation_engine" {
  function_name = "recommendation_engine"
  handler       = "recommendation_engine.handler"
  runtime       = "python3.8"

  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "recommendation_engine.zip"
}

resource "aws_lambda_function" "notification_service" {
  function_name = "notification_service"
  handler       = "notification_service.handler"
  runtime       = "python3.8"

  s3_bucket = "pinterest-like-app-lambda-code"
  s3_key    = "notification_service.zip"
}

# Criando a base de dados para análise de usuário
resource "aws_rds_instance" "user_analytics_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "user_analytics"
  username             = "admin"
  password             = "yourpassword"
  skip_final_snapshot  = true
}
