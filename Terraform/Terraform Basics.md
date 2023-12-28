Q. What is Infrastructure as Code (IAC) ?
-------------------------------------------------
A. Infrastructure as code (IaC) tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe environment. Configuration file can be reuse and share.

Examples of IAC tools that are used in the market are: Ansible, Terraform, Cloud Formation, docker, Salt stack, Puppet
            
Q. IaC as Terraform?
----------------------------
A. Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure:  



  * Terraform can manage infrastructure on multiple cloud platforms.
  * The human-readable configuration language helps you write infrastructure code quickly.
  * Terraform's state allows you to track resource changes throughout your deployments.
  * You can commit your configurations to version control to safely collaborate on infrastructure.

Q. How to manage any infrastructure?
--------------------------------------
A. Terraform plugins called **providers** let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs). HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, and DataDog, just to name a few. 

Q. How terraform track your infrastructure changes?
----------------------------------------------------
A. Terraform keeps track of your real infrastructure in a state file know as **`terraform.tfstate`**, which acts as a source of truth for your environment. This file is only created in same directory where **`terrafrom apply`** executed successful. Terraform uses this state file to determine the changes to make to your infrastructure so that it will match your configuration.

Q. Terraform commands ?
-------------------------
* `$ terraform version` --> check terrafom version details
* `$ terraform init` --> initializing terraform 
* `$ terraform fmt` --> formating the .tf files
* `$ terraform validate` --> validating the .tf files 
* `$ terraform plan` --> dry-run the terrafrom code
* `$ terraform apply` --> applying the configuration changes 
* `$ terraform apply --auto-approve` --> autoapprove the deployment changes
* `$ terraform show` --> inspect the current state of configurations 
* `$ terraform state list` --> state the resources list
* `$ terraform output` --> print output of `output.tf` file

Q. Important file in terraform
------------------------------
* .terraform      --> post `terraform init`, it download the plugins and providers to this directory
* .terraform.lock.hcl     --> lock file for terraform setup
* terraform.tfstate   --> post `terraform appply` 
* .terraform.tfstate.lock.info --> while testing `terraform plan` and `terraform apply`, it creates and deletes it.
* terrform.tfstate.d     --> while working with workspace it creates this folder structure to store the state file.

Q. Files and its purpose
-------------------------
* main.tf	--> Main configuration file containing resource definition
* variables.tf --> Contains variable declarations
* outputs.tf --> Contains outputs from resources
* provider.tf --> Contains Provider definition
* terraform.tf --> Configure Terraform behaviour

* variable.tfvars  --> 
* terraform.tfvars  
* terraform.tfvars.json
* *.auto.tfvars

Q. Variables
-------------
Terraform variables are defined in mutiple ways,  using different .tf files like. the variable presidence is like below. 

4 Environment Variables 
3 terraform.tfvars 
2 `*.auto.tfvars` (alphabetical order)
1 -var or –var-file (command-line flags) 


Lab-1: using variables.tf with default values
----------------------------------------------
create `variables.tf` file same directory as `main.tf` file. and add the variables in the exmple shown

variables.tf
-------------
```
variable "ami" {
  default = "ami-0edab43b6fa892279"
}
variable "instance_type" {
  default = "t2.micro"
}
```
main.tf
-------------
```
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type

}
```

Lab-2: using variables.tf with out default values
-------------------------------------------------
once you run the `$ terrform apply` command the system will promt for the values to enter dynamical values. 

variables.tf
-------------
```
variable "ami" {
}
variable "instance_type" {
}
```
main.tf
-------------
```
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type

}
```

Lab-3: command line arguments to over ride the values
-----------------------------------------------------
we can pass "n" number of variables using the option -var as a command line argument.
variables.tf
-------------
```
variable "ami" {
}
variable "instance_type" {
}
```
main.tf
-------------
```
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type

}
```

`$ terraform apply -var "ami=ami-0edab43b6fa892279" -var "instance_type=t2.micro"`

Lab-4: setting as environment variables
----------------------------------------
we can export as environment varialbes.


$ export TF_VAR_instance_type="t2.micro"
$ export TF_VAR_ami="ami-0edab43b6fa892279"
$ terraform apply

Lab-5: define variables in bulk using `variable.tfvars`
-------------------------------------------------------
we can name the `variable.tfvars` with any name but extension should be with `.tfvars`. variables are automatically loaded when the files are create with name `terraform.tfvars`, `*.auto.tfvars`, `terraform.tfvars.json`, `*.auto.tfvars.json` the files are automatically loaded in the env. else we need to use argument `-var-file variable.tfvars`

variables.tf
--------------
```
variable "ami" {
}
variable "instance_type" {
}
```
main.tf
-------------
```
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type

}
```
variable.tfvars
------------------
```
ami="ami-0edab43b6fa892279"
instance_type="t2.micro"
```

$ terraform apply -var-file variables.tfvars

Output variables:
------------------
to present the output after applying the change, we can use the as below in the `main.tf` file. show the output `$ terraform apply` command

```
output "pub_ip" {
value = aws_instance.cerberus.public_ip
description = "print the public IPv4 address"
}
```

$ terraform ouput --> to show the output of the defined variables
$ terraform output pub_ip --> it will present only seleted output field

Q. Install Terraform ?
----------------------------
A. Terraform installtion package comes with only one file named as **`terraform`** which is a binary file. it is responsible to connect with all providers. Once **`terrafrom init`** is executed it will connect with terrform repository and download the appropriate plug-in. this plugins are used to configure repective providers. 

### Windows: Installtion 
-----------------------------
1. Download the terrafrom package https://www.terraform.io/downloads and extract in `C:\Program Files`. 
2. add it to environment variables using `sysdm.cpl` from `Ctrl + r` 
3. Click the Advanced system settings link.
4. Click Environment Variables. In the section System Variables find the PATH environment variable and select it. Click Edit. If the PATH environment variable does not exist, click New.
5. In the Edit System Variable window, New and specify the value of the PATH environment variable. Click OK. Close all remaining windows by clicking OK.
6. Reopen Command prompt window, and run your `C:\> terraform version`.
7. verify installtion `C:\> terraform -help` or `C:\> terraform -help plan`.

### Linux: Installtion
---------------------------
1. Download the terrafrom package https://www.terraform.io/downloads and extract in `/usr/local/bin`
2. update the PATH environment variable using `$ export PATH=$PATH:/usr/local/bin`
3. check `$ terraform version`, you will get terrafrom version details. 
4. verify installtion `$ terraform -help` or `$ terraform -help plan`.
5. we can also do it `$ touch ~/.bashrc` and `$ terraform -install-autocomplete`.

Lab-1. How to Deploy a Docker image on Windows machine using terraform?
------------------------------------------------------------------------
A. deploying a docker image using terraform, we need to first set prerequisites.
1. Download DockerDesktop and install using https://docs.docker.com/desktop/windows/install/
2. make sure the DockerDesktop is up and running. otherwise the system will not able to find the docker daemon.
3. create folder 'terraform-docker' and change into it
4. create file `main.tf` and copy the below content to it.
-------------------------------------------------------------
```
# required providers Terraform will use to provision your infrastructure.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

# A provider is a plugin that Terraform uses to create and manage your resources.

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

# Use resource blocks to define components of your infrastructure. A resource might be a physical or virtual component. Resource blocks have two strings before the block: the resource type and the resource name. In this example, the first resource type is docker_image and the name is nginx. 

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```
---------------------------------------------------------------
4. run **`terraform init`**, you will observe few plug-ins are getting downloaded
5. run **`terraform apply`**, this will create respective docker containers. 
6. to check the docker container run `C:\> docker ps`, you will see 1 container running with name **tutorial**
7. you can access the deployed container using http://localhost:8000 

### Observations: During the setup
-----------------------------------
* after executing `C:\> terrafrom init` it create a folder structure inside directory as **`.terraform`** and one file **`.terraform.lock.hcl`**
* in .terraform folder provider plug-ins are downloaded depends on the code written in main.tf file.
* running `C:\> terraform apply` this will apply the configurations defined in the .tf files are applied. this create a file **`terraform.tfstate`**.
* **`terraform.tfstate`** file will maintain the history of your configuration changes, this way terraform will track the changes.

Q. How to Remove Deployed configurations ?
-------------------------------------------
* this configuration changes can be rollback using `C:\> terraform destory` command
* this will remove all the configurations from **terraform.tfstate file**. so that terraform will have track of it

Q. How to update terraform configuration file?
-----------------------------------------------
Now update the external port number of docker container. Change the **docker_container.nginx** resource under the provider block in `main.tf` by replacing the `ports.external` value of `8000 with 8080`. This update changes the port number of docker container to serve nginx server. The Docker provider knows that it cannot change the port of a container after it has been created, so Terraform will destroy the old container and create a new one.

* `$ terraform init` and `$ terraform apply` --> to apply the changes. 
* this will destroy the old container and create a new container in place 

Lab-2. How to set the container-name with defining variables?
--------------------------------------------------------------
Terraform variables allow you to write configuration that is flexible and easier to re-use. 
1. Create a new file called **`variables.tf`** in same directory.
2. write a block defining a new container_name variable. 

variables.tf
--------------------------------------
```
variable "my_container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleNginxContainer"
}
```
----------------------------------------
3. change the `main.tf` file and update the `docker_container` resouce block name field `tutorial` with `var.my_container_name`. changes as below

### from:
-------------
```
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
```
--------------
### To:
--------------
```
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.my_container_name
  ports {
    internal = 80
    external = 8080
  }
```
-----------
4. run `$ terraform init` and `$ terraform apply` there we can see the value replacement message in red color
5. we can also pass environment variables using the command line options like below to over ride the actual values.
  `$ terraform apply -var "ami=ami-0edab43b6fa892279" -var "instance_type=t2.micro"`


Lab-3. How to inspect docker container configuration using ouput.tf?
-----------------------------------------------------------------
1. create a new file named **`output.tf`** 

output: to print the output on the stdout 
------------------------------------------
terrform output command print the output of the defined variables in the stdout, so that we can have details.
```
output "my_container_id" {
      value = docker_image.nginx.id
}

output "my_image_id" {
      value = docker_container.nginx.id
}
```
----------------------------
2. run the command `$ terraform init` and `$ terraform apply` 
3. output will be displayed on the terminal
4. use **`$ terraform ouput`** to print the ouput again.




![image](https://user-images.githubusercontent.com/33980623/174418529-dbdbb647-35db-42e9-9751-86c9ed1d3f77.png)

Q. Debug : Terraform using logging
---------------------------------
Terraform provides 5 logging levels such as "info, warning, error, trace, debug". to enable this use the env variable as 

 `$ export TF_LOG=trace` --> change the logging level according to your requirement.
 `$ export TF_LOG_PATH=/tmp/terraform.log` --> to save to a different path
 
Q. Import : existing resource to terraform 
-----------------------------------------
to import the existing resource created in AWS can be maintained using the terrafrom, to do so first we need to import the existing service  to terraform state file. to do so we import the configuration.

 `$ terrform import <<resource_type>>.<<resource_name>> resource_unique_id`

 `$ terraform import aws_instance.webserver-2 i-07ddd739949287d01`

Q. Workspace : to create similer env like dev,test,uat,prod
------------------------------------------------------------
if we  have used terraform to setup the Dev, environment. we can use this for replicate the UAT, Test, prod similerly. this can be achived using the `$ terraform workspace` command. `$ terraform workspace list`

Lab-1: workspace setup for DEV, PROD environments.
---------------------------------------------------

main.tf
---------------
```
resource "aws_instance" "webserver" {
  availability_zone = var.region
  ami               = var.ami
  instance_type     = lookup(var.instance_type, terraform.workspace)    # `lookup` funtion to select value based on worksapce

  tags = {
    "Environment" = "DEV"
  }
}
```

variables.tf
------------------
```
variable "ami" {
  default = "ami-08c40ec9ead489470"
}
variable "instance_type" {
  type = map(any)
  default = {
    "DEV"  = "t2.micro"
    "PROD" = "t3.micro"
  }
}
variable "region" {
  default = "us-east-1a"
}
```
2. create the workspace for the DEV and PROD using below command
3. `$ terraform workspace create "DEV"      --> to create "DEV" workspace
4. `$ terraform workspace create "PROD"     --> to create "PROD" workspace
5. `$ terraform workspace list`     --> to list the workspaces we are working on.
6. `$ terraform workspace select "DEV"      --> to select workspace where we work on.
7. `$ terraform console`    --> will open a interactive terminal for checking the values. 
8. ![image](https://user-images.githubusercontent.com/33980623/191747996-61f77579-c7c1-47d1-a7f8-8bde5ba037e4.png)

9. `terraform apply` to apply the changes, now i working on workspace "DEV"
10. switch to the "PROD" and run the same to apply the "PROD" configuration changes
