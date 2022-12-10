provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "outline" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh-key.id
  user_data     = file("user_data.sh")

  vpc_security_group_ids = [
    "${aws_security_group.outline.id}"
  ]
  tags = {
    Name    = "outline"
    Project = "test"
  }

}
resource "null_resource" "copy_config" {
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o LogLevel=quiet -i ${var.key_folder}/key.pem ubuntu@${aws_instance.outline.public_ip}:/tmp/outline-install-details.txt ${var.config_path}/outline-install-details-${aws_instance.outline.public_ip}.txt"

  }
  provisioner "local-exec" {
    command = "cat ${var.config_path}/outline-install-details-${aws_instance.outline.public_ip}.txt"
  }
}
