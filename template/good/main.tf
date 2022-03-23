resource "aws_instance" "two" {
    ami           = "ami-005e54dee72cc1d00"
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
}