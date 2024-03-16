main.tf
-------------------------------------------------
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
resource "aws_instance" "web" {
  ami           = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.Local_key.id
}

resource "local_file" "inventory" {
  filename = "inventory.txt"
  content = templatefile("template.tpl", {
    web_public_ip  = aws_instance.web.public_ip
    web_public_dns = aws_instance.web.public_dns
  })
}


template.tpl # create template file that you are refering 
------------------------------------------
[all]
ansible_host=${web_public_ip} 
ansible_user=${web_public_dns}
