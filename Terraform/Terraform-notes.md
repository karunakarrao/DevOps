Q. What is Infrastructure as Code?
-------------------------------------------------
A. Infrastructure as code (IaC) tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe environment. Configuration file can be reuse and share.

Q. What is IaC as Terraform?
----------------------------
A. Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure:
  * Terraform can manage infrastructure on multiple cloud platforms.
  * The human-readable configuration language helps you write infrastructure code quickly.
  * Terraform's state allows you to track resource changes throughout your deployments.
  * You can commit your configurations to version control to safely collaborate on infrastructure.

Q. How to manage any infrastructure?
--------------------------------------
A. Terraform plugins called **providers** let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs). HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, and DataDog, just to name a few. 

Q. How to terraform tracks your infrastructure?
------------------------------------------------
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


Q. How to install Terraform?
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
------------------------------
1. Download the terrafrom package https://www.terraform.io/downloads and extract in `/usr/local/bin`
2. update the PATH environment variable using `$ export PATH=$PATH:/usr/local/bin`
3. check `$ terraform version`, you will get terrafrom version details. 
4. verify installtion `$ terraform -help` or `$ terraform -help plan`.
5. we can also do it `$ touch ~/.bashrc` and `$ terraform -install-autocomplete`.

Q. How to Deploy a Docker image on Windows machine using terraform?
--------------------------------------------------------------------
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

Q. How to set the container-name with defining variables?
----------------------------------------------------------
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

Q. How to inspect docker container configuration using ouput.tf?
-----------------------------------------------------------------
1. create a new file named **`output.tf`** 

output.tf
--------------------------
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
5. 




![image](https://user-images.githubusercontent.com/33980623/174418529-dbdbb647-35db-42e9-9751-86c9ed1d3f77.png)

