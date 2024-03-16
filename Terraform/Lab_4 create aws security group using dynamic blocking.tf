scenario-1 - create using variables
-------------------------------------------------------
variable "ingress" {
  type = set(number)
  default = [80, 443, 22, 23]
}
variable "egress" {
  type = set(number)
  default = [80, 443, 22, 23]
}
resource "aws_security_group" "dynamic_sg" {
  name = "dynamic_sg"

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.egress
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

output "time" {
  value = timestamp()
}

scenario-2.tf - create using locals 
--------------------------------------------------


locals {
  ingress=toset([80, 443, 22])
  egress=toset([80,443, 22])
  time=timestamp()
}

resource "aws_security_group" "dynamic_sg" {
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port=ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  dynamic "egress" {
    for_each = local.egress
    content {
      from_port = egress.value
      to_port = egress.value
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

}
