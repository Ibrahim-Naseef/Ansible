terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  key_name      = "my-keypair"

  tags = {
    Name = "ansible-managed-app-server"
  }

  # After the instance is up, generate an Ansible inventory file
  provisioner "local-exec" {
    command = "echo '[app]\n${self.public_ip} ansible_user=ubuntu' > inventory.ini"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}
