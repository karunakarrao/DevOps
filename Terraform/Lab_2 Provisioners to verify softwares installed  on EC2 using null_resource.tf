
# Downloading  AWS plugins 
provider "aws" {
  region = "us-east-1"
}

# Adding Local key to access EC2  instance
resource "aws_key_pair" "Local_key" {
  key_name   = "Local_key1"
  public_key = file("C:\\Users\\karun\\.ssh\\id_rsa.pub")
}

# creating EC2 instance and mapping Local key
resource "aws_instance" "aws_instance_for_rds" {
  ami           = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.Local_key.id
}

# creating null_resouce to install softwares using a shell script
resource "null_resource" "testing" {
  count = 1
  triggers = {                                  # trigger when there is a change is script.sh
    script_hash = md5(file("script.sh"))    
  }

  provisioner "file" {                          # copy script to EC2 machine
    source      = "script.sh"
    destination = "/tmp/script.sh"

  }

  provisioner "remote-exec" {                   # run script on EC2 machine
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {                                  # providing private key to establish connection with EC2 to run script
    type        = "ssh"
    host        = aws_instance.aws_instance_for_rds.public_ip
    user        = "ubuntu"
    private_key = file("C:\\Users\\karun\\.ssh\\id_rsa")
    timeout     = "4m"
  }

  provisioner "remote-exec" {                   # extract nginx  version once done
    inline = [
      "nginx -v",
      "cat /tmp/my-name"
    ]
  }
}
