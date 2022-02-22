provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  metadata_options {
     http_tokens = "required"
   }
  root_block_device {
      encrypted = true
  }
  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = 5
    volume_type = "gp2"
    delete_on_termination = false
    encrypted = true
  }
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
