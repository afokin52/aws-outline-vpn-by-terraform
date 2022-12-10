output "external_ip" {
  value = aws_instance.outline.public_ip
}
output "ssh_connect" {
  value = "ssh -i .ssh/key.pem ubuntu@${aws_instance.outline.public_ip}"
}
