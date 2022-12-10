data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "test" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "key-ssh"
  public_key = tls_private_key.test.public_key_openssh
}

resource "local_file" "cloud_pem" {
  filename        = ".ssh/key.pem"
  content         = tls_private_key.test.private_key_pem
  file_permission = 400
}
