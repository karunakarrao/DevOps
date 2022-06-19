Q. How to setup & provision AWS environment ?
---------------------------------------------
### Prerequisites:
1. Install Terraform and update **`terraform`** binary file in the environment variables.
2. checking terraform installation, goto terminal and check **`$ terraform version`** and **`$ terraform -help`**
3. Install AWS-CLI from https://aws.amazon.com/cli/, and check aws installed successfull.
4. checking AWS Cli installtion, goto terminal **`$ aws --version`**
5. Now configure aws account details, so we can have access to AWS console
6. collect he AWS access credentials from AWS->Account->Security credentials->Accesskeys, create access keys & Secretkey
7. configure the AWS **`AccessKey & SecurityKey`** in AWS-CLI 
------------------------------------
```
$ aws configure
AWS Access Key ID [****************QDJT]: AKXXXXXXXXXXXXXFQDJT
AWS Secret Access Key [****************7wdf]: usBXXXXXXXXXXXXXXXXXXXXXxzwQ7wdf
Default region name [us-east-1]:
Default output format [text]:
$
```
--------------------------------------
```
$ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************QDJT shared-credentials-file
secret_key     ****************7wdf shared-credentials-file
    region                us-east-1      config-file    ~/.aws/config
$
```
----------------------------------------

Q. How AWS EC2 instance are created using terraform ?
------------------------------------------------------
A. deploying an EC2 instance
1. create a change to folder name **EC2-terraform** 
2. create a **`main.tf`** file and write configuration

main.tf
--------------------------------------------------
```
# 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

# the terraform version should be equal "1.2.0" or higher
  required_version = ">= 1.2.0"
}

# AWS region where the EC2 instance should get created.
provider "aws" {
  region  = "us-west-2"
}

# AWS  resouce to create EC2 instnce
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```
---------------------------------------------------

3. run **`$ terraform init`**
4. run **`$ terraform fmt`** and **`$ terraform validate`**
5. run **`$ terraform apply`** 
6. to check the status of the resources **`terraform state list`**
7. checking the resources details **`$ terraform show`**
8. destory the created instance using **`$ terraform destroy`**


Q. How to pass ami, instance_type values as variables to terrafrom main.tf?
----------------------------------------------------------------------------
1. create file called **`variables.tf`** in same directory

variables.tf
---------------------------------------------
```
variable "my_ami_type" {
      type = string
      default = "ami-830c94e3"
      }
variable "my_instance_type" {
      type = string
      default =  "t2.micro"
      }
```
---------------------------------------------

2. change the variable values in **`main.tf`** file.

### Before:
-------------------------------
```
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```
--------------------------------

### After:
-------------------------------
```
resource "aws_instance" "app_server" {
  ami           = var.my_ami_type
  instance_type = var.my_instance_type

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```
--------------------------------
3. run `$ terraform init`
4. run `$ terraform fmt` and `$ terraform validate`
5. run `$ terraform plan` and **`$ terraform apply`**
6. check `$ terraform show` and `$ terraform state list`

Q. How to output EC2 instance configuration?
----------------------------------------------
1. create file **`outputs.tf`** in same directory

outputs.tf
---------------------------------
```
ouput "my_instantce_id" {
    value = aws_instance.app_server.id
    }
output "my_instance_public_IP" {
    value = aws_instance.app_server_public_ip
    }
```
-----------------------------------
2. run `$ terraform init`
3. run `$ terraform fmt` and `$ terraform validate`
4. run `$ terraform plan` and **`$ terraform apply`**
5. check ouput **`$ terraform output`**

Q. How to cloud secure your `terraform.state` & AWS credentials using terraform cloud account?
----------------------------------------------------------------------------------------------
1. first we need to create a terraform cloud account using this link https://app.terraform.io/signup/account
2. authenticate mail confirmation sent to your registered email.
3. goto terraform cloud and create a **organization**
4. create a **workspace**, select type of workspace (varsion-control/**api-driven**/CLI-driven)and copy the workspace code in **main.tf** file.
--------------------------------------------
```
terraform {
  cloud {
    organization = "jkraob87"

    workspaces {
      name = "AWS-ec2-workspace"
    }
  }
}
```
--------------------------------------------
5. goto tab variables and specify the AWS credentials so they are secured environment variables.AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and secure it.
![image](https://user-images.githubusercontent.com/33980623/174478301-5d32a778-ba1a-4c5e-8950-b53b25ab61fe.png)
 
6. now goto your terminal and run **`$ terraform login`**, this will pop-up window which require login to terraform cloud. it generate a key.
7. use the generated **Password** and authenticate your account.
8. now run the **main.tf** file 
------------------------------------------
```
terraform {
  cloud {
    organization = "jkraob87"
    workspaces {
      name = "AWS-ec2-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = var.my_ami_type
  instance_type = var.my_instance_type

  tags = {
    Name = "updatedinstance"
  }
}

```
----------------------------------------
9. now run `$ terraform init` and `$ terraform apply`. 
10. you can we run stats in terraform cloud also.




