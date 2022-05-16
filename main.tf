provider "aws" {
  region = var.aws_region
}

resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content         = tls_private_key.main.private_key_pem
  filename        = "${var.key_name}.pem"
  file_permission = 600
}

resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = tls_private_key.main.public_key_openssh
}
