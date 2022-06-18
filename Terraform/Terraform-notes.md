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
A. Terraform keeps track of your real infrastructure in a state file know as `terraform.tfstate`, which acts as a source of truth for your environment. This file is only created in same directory where `terrafrom apply` executed successful. Terraform uses this state file to determine the changes to make to your infrastructure so that it will match your configuration.

Q. How to install Terraform?
----------------------------
A. Terraform installtion package comes with only one file named as `terraform` which is a binary file. it is responsible to connect with all providers. Once `terrafrom init` is executed it will connect with terrform repository and download the appropriate plug-in. this plugins are used to configure repective providers. 

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

Q. How to Deploy a Docker image on Windows machine?
----------------------------------------------------
A. deploying a docker image using terraform, we need to first set prerequisites.
1. Download DockerDesktop and install using https://docs.docker.com/desktop/windows/install/
2. create folder 'terraform-docker' and change into it
3. create file `main.tf` and copy the below content to it.
-------------------------------------------------------------
```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

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
4. run `terraform init`, you will observe few plug-ins are getting downloaded
5. run ` terraform apply`, this will create respective docker containers. 
6. to check the docker container run `C:\> docker ps`, you will see 1 container running with name **tutorial**




![image](https://user-images.githubusercontent.com/33980623/174418529-dbdbb647-35db-42e9-9751-86c9ed1d3f77.png)

