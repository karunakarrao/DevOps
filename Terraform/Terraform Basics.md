Terraform :
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
`count` 	--> The "count" object can only be used in "module", "resource", and "data" blocks, and only when the "count" argument is set.
`for_each`  	--> The "for_each" argument must be a MAP/SET of strings, and if you have provided a value of type List, then to convert use toset()/tomap() function


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 Q. What is Infrastructure as Code (IAC) ?
-------------------------------------------------------------------------
A. Infrastructure as code (IaC) tools, allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe environment. Configuration file can be reuse and shared.

Examples: 
 
            Configuration Management IAC tools:             Ansible, Puppet, Salt Stack
            Server templating IAC Tools:                    Docker, Vagrant, packer 
            Infrastructure Provisioning IAC Tools:          Terraform, Cloud-Formation
            
Q. IaC as Terraform?
-------------------------------------------------------------------------
A. Terraform is HashiCorp's infrastructure as code tool. Its and `opensource` IAC tool. It lets you define resources and infrastructure in a human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure.

              1. Terraform can manage infrastructure on multiple cloud platforms.
              2. The human-readable configuration language helps you write infrastructure code quickly.
              3. Terraform's state allows you to track resource changes throughout your deployments.
              4. You can commit your configurations to version control to safely collaborate on infrastructure.

Q. How to manage any infrastructure? 
-------------------------------------------------------------------------
A. Terraform plugins called `providers` let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs). HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, and DataDog, just to name a few. 

            Providers: Providers are the plug-ins that allow you to connect with different cloud providers like AWS, Azure, GCP, VM-Ware, Physical machine and more. 
            Resources: Resouces are the objects that are created on the cloud like ec2, vpc, s2  and more.      

   Note: terraform downloads the plugins known as providers in `.terraform` folder in your local directory

Q. How terraform track your infrastructure changes?
-----------------------------------------------------------------------------------------
A. Terraform keeps track of your real infrastructure in a state file know as `terraform.tfstate`, which acts as a source of truth for your environment. This file is only created in same directory where `terrafrom apply` executed successful. Terraform uses this state file to determine the changes to make to your infrastructure so that it will match your configuration. `terraform.tfstate` file is the obsalute copy of your environment. so don't edit or modify this file. if any resources missing during the apply phase this will create the missing resouces as per the `.tfstate` file defintion. so explicit editing of this file will delete resouces created.

Q. What is a provider?
------------------------------------------------------------------------------------------
Providers are the plugins that are used to  connect with different providers like (aws, azure, docker, k8s, gcp, vmware, etc..). providers are of Official/community/sponserd. most cloud providers are official one. we can accumilate multipule  providers in  a single manifest file. we can see the privider details during the `init` phase.

multipule-providers.tf
------------------------------------------------
```
resource "local_file" "pet" {
	filename = "/root/pets.txt"
	content = "We love pets!"
}

resource "random_pet" "my-pet" {
	prefix = "Mrs"
	separator = "."
	length = "1"
}
```

Q. Terraform commands ?
------------------------------------------------------------------------------------------
* `$ terraform version` 		--> check terrafom version details
* `$ terraform init` 			--> initializing terraform 
* `$ terraform fmt` 			--> formating the .tf files
* `$ terraform validate` 		--> validating the .tf files 
* `$ terraform plan` 			--> dry-run the terrafrom code
* `$ terraform apply` 			--> applying the configuration changes 
* `$ terraform apply --auto-approve` --> autoapprove the deployment changes
* `$ terraform show` 			--> inspect the current state of configurations 
* `$ terraform state list` 		--> state the resources list
* `$ terraform output` 			--> print output of `output.tf` file
* `$ terraform destroy` 		--> it will delete all the configurations

Q. Important file in terraform
-----------------------------------------------------------------------------------------
* `.terraform`              --> post `terraform init`, it download the plugins and providers to this directory
* `.terraform.lock.hcl`     --> lock file for terraform setup
* `terraform.tfstate`       	   --> post `terraform appply` 
* `.terraform.tfstate.lock.info`   --> while testing `terraform plan` and `terraform apply`, it creates and deletes it.
* `terrform.tfstate.d`             --> while working with workspace it creates this folder structure to store the state file.

Q. Files and its purpose
-----------------------------------------------------------------------------------------
* `main.tf`	        --> Main configuration file containing resource definition
* `variables.tf`      	--> Contains variable declarations
* `outputs.tf`        	--> Contains outputs from resources
* `provider.tf`       	--> Contains Provider definition
* `terraform.tf`      	--> Configure Terraform behaviour

* `variable.tfvars`  		--> variables defined in this file need to pass explicityly using `-var-file`
* `terraform.tfvars`  		--> variables will auto load the values, doen't require to specify `-var-file`
* `terraform.tfvars.json`	--> writing in JSON 
* `*.auto.tfvars`		--> any filename with auto.tfvars will load variables automatically

----------------------------------------------------------------------------------------------
Variables
----------------------------------------------------------------------------------------------
Define variables in terraform using `variables.tf` file where you define the variables used in the `main.tf` file. it allow 3 parameters default, type, description. type and description are optinal parameters. 
	
 	1. default 		--> default value 
       	2. type			--> variable type - default type is any ( any/string/bool/number/list/map/set/object/tuple )
	3. description		--> variable description what is the use of it.
 
	string:		String
	bool: 		True / False
	number: 	Numeric
	list: 		list is collection of any type. list is indexed as 0, 1, 2, 3. Access like `var.prefix[0]`
	map: 		key-value pairs, where all keys and values are of the same type. `var.example_map["key1"]`
	set: 		collection of unique values of the same type. `var.prefix[0]`
	object: 	complex data structure with attributes of different types. `var.example_object.key1`
	tuple: 		collection of values of different types. like string, bool, number

variables.tf
---------------------------------------------

string
--------------
```
variable "filename" {
  default = "/root/my-pet.txt"			# String 
  type = string
  description =	" image used for the instance creation " 
}
```
# Note: how to access the variable in main.tf is " var.filename"

bool
--------------
```
variable "password_change" {
  default = true				# Bool
  type	= bool
}
# Note: how to access the variable in main.tf is " var.password_change"
```

Number
-------------
```
variable "length" {
  default = 1					# Number
  type	= number
}
```
# Note: how to access the variable in main.tf is " var.length"

List
--------------
```
variable "prefix" {
  default = ["Mr", "Mrs", "Sir"]		# List
  type = list
}
```
# Note: first eleiment in the list is indexed as 0, 1, 2, 3.  how to access the variable in main.tf is "var.prefix[0]" 

Set
---------------
```
variable "perfix" {
  default = ["Mr", "Mrs", "Sir"]		# set 
  type = set
}
```
# Note: set will not allow duplicates in it. if duplicates are there it will send error msg.

tuple
-----------------
```
variable kitty {
type = tuple([string, number, bool])		#tuple
default = ["cat", 7, true]
}
```
# Note: tuple is a collection of different variable types

map
---------------
```
variable "example_map" {
  type = map					# map
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}
```
# Note: Represents a collection of key-value pairs, where all keys and values are of the same type. access var.example_map["key1"]

object
-------------
```
variable "example_object" {
  type = object({				# object
    attribute1 = string
    attribute2 = number
  })
  default = {
    attribute1 = "value1"
    attribute2 = 42
  }
}
```
# Note: Represents a complex data structure with attributes of different types.

Lab-1: DEFAULT values in variable.tf file
--------------------------------------------------------------------------------------------
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
Lab-2: with out DEFAULT values in  `variable.tf` file
------------------------------------------------------------------------------------------------
once you run the `$ terrform apply` command the system will promt for the values to enter dynamical values. 

variables.tf
-------------
```
variable "ami" {}
variable "instance_type" {}
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
------------------------------------------------------------------------------------------------
we can pass "n" number of variables using the option `-var` as a command line argument.

variables.tf
-------------
```
variable "ami" {}
variable "instance_type" {}
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
------------------------------------------------------------------------------------------------
we can export as environment varialbes. just have to add `TF_VAR` as prefix to the actual variable type.

	$ export TF_VAR_instance_type="t2.micro"
	$ export TF_VAR_ami="ami-0edab43b6fa892279"
	$ terraform apply

Lab-5: define variables in bulk using `variable.tfvars`
------------------------------------------------------------------------------------------------
we can name the `variable.tfvars` with any name, but extension should be with `.tfvars`. variables are automatically loaded when the files are create with name `terraform.tfvars`, `*.auto.tfvars`, `terraform.tfvars.json`, `*.auto.tfvars.json` the files are automatically loaded in the env. else we need to use argument `-var-file variable.tfvars`. 

Note: we need to define `variable.tf` file to load values in to `main.tf` event we define it in the `.tfvars/.auto.tfvars` files. 

variables.tf
--------------
```
variable "ami" {}
variable "instance_type" {}
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
	$ terraform apply -var-file variables.tfvars	--> passing as an argument. 

----------------------------------------------------------------------------------------------
Resource Dependency 
-----------------------------------------------------------------------------------------------
using `depends_on` parameter in the resource block. will help you to achieve the sinario. once the dependent resouce block is executed, then only the dependent block gets created. 
	1. Explicit	
 	2. implicit

1. Explicit Dependency (depends_on)
------------------------------------------
```
resource "local_file" "pet" {
	filename = var.filename
	content = "My favorite pet is Mr.Cat"
	
	depends_on = [ random_pet.my-pet ]	# resouce is dependent on the output of below resouce . 
}
resource "random_pet" "my-pet" {
	prefix = var.prefix
	separator = var.separator
	length = var.length
}
```
 2. Implicit Dependency || Reference expressions
----------------------------------------------------
```
resource "local_file" "pet" {
	filename = var.filename
	content = "My favorite pet is ${random_pet.my-pet.id}"
}
resource "random_pet" "my-pet" {
	prefix = var.prefix
	separator = var.separator
	length = var.length
}
```

----------------------------------------------------------------------------------------------
Output variables:
-----------------------------------------------------------------------------------------------
to present the output after applying the change, we can use the as below in the `main.tf` file. show the output `$ terraform apply` command

```
output "pub_ip" {
value = aws_instance.cerberus.public_ip
description = "print the public IPv4 address"
}
```
	$ terraform ouput 		--> to show the output of the defined variables
	$ terraform output pub_ip 	--> it will present only seleted output field

Q.Terraform variables are defined in mutiple ways. the variable presidence is like below. 
-----------------------------------------------------------------------------------------------
	1. -var or –var-file (command-line flags) 
 	2. `*.auto.tfvars` (alphabetical order)
  	3. terraform.tfvars 
	4. Environment Variables 
 
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

Terraform commands:
------------------------------------------------------------------------
	$ terraform validate
 	$ terraform fmt
  	$ terraform show
   	$ terraform providers
    	$ terraform output
     
      	$ terraform graph
       	$ terraform graph |dot -Tsvg > graph.svg
	$ apt update
 	$ apt install graphviz -y

Immutable vs mutabule Infrastructure:
------------------------------------------------------------------------
`Mutable Infrastructure:`	In mutable infrastructure we update the cofigurations of the server from one version to next version. this require complex setup, which means need to see dependencies/os/libraries/etc to perform.

`Immutable Infrastructure:` 	In immutable infrastrucutre new resouce is created with updated changes and destroys the old one upon the successful setup. this is easy compare to mutable. 

Why terraform will destroy resource when you do any miner modifications ? 
--------------------------------------------------------------------------
This is the Default behaviour for the terraform to destroy the object, and creates the new object with the updated changes. this is also known as immutable infrastructure. by default terraform destroys the resouce first then it creates the object. this can be changes using "lifecycle rules".   

---------------------------------------------------------------------------------------------------------------
Lifecycle Rules:
---------------------------------------------------------------------------------------------------------------
To change the terraform default behaviour of "destroying the resource first then creating the resource". this can be changes using Lifecycle Rules.

main.tf
------------------------------------------------------------
```
resource "local_file" "pet-name" {
  filename = "test.txt"
  content  = "this is my pet, updated file"

  lifecycle {					# This will ensure to change the order of creating resource. 
    create_before_destroy = true
  }
}
------------------------------------------------------------
lifecycle {
	prevent_destroy	= true			# This will prevent from destroing the resource.
}
------------------------------------------------------------
lifecycle {
	ignore_changes = [ tags, ami ]		# Terraform ignore the changes 
}
------------------------------------------------------------
lifecycle {
	ignore_changes	= all 			# Terraform will ignore the changes on this resouce.
}
-------------------------------------------------------------
```

---------------------------------------------------------------------------------------------------------------
Datasources: ( Data Resources)
---------------------------------------------------------------------------------------------------------------
if you want to use the data-file from local/external filesystem into terraform, then we use the `data` block. this will allow you to load the data from an external file. datasources are not like `resource` blocks. they are used for read the data from a file. 

main.tf
---------------------------------------
```
resource "local_file" "pets" {
	filename = /root/pets.txt
	content  = data.local_file.dogs.content		
}
data "local_file" "dogs" {		# this is used to load the data from an external resouce /root/dogs.txt
	filename = /root/dogs.txt
}
```

---------------------------------------------------------------------------------------------------------------
Meta arguments: 
---------------------------------------------------------------------------------------------------------------
meta arguments can be used any block that will change the behaviour of any resource. some of the meta  arguments like

 	1. depends_on	--> 
  	2. lifecycle	--> to control the resouce  lifecycle
   	3. count	--> to create same resouces for mutipule times
    	4. for_each	--> similer to loop

variables.tf
---------------------------------------------
```
variable "filename" {
	default	= [ "/root/pet.txt", "/root/dogs.txt", "/root/fox.txt", "/root/elephant.txt ]
}
```
main.tf
---------------------------------------------
```
resource "local_file" "pets" {
	filename = var.filename[count.index]		# use count 
	count 	= 3
}
```
---------------------------------------------------------------------------------------------
count:
---------------------------------------------------------------------------------------------
```
resource "local_file" "pets"{
	filename = var.filename[count.index]
	count   =  length(var.filename)
}
```

variables.tf
----------------------------------------------------------
```
variable "users" {
    type = list(string)
    default = [ "/root/user10", "/root/user11", "/root/user12", "/root/user10"]
}
variable "content" {
    default = "password: S3cr3tP@ssw0rd"
}
```
---------------------------------------------------------------------------------------------
for_each:
---------------------------------------------------------------------------------------------
main.tf
------------------------------------------------------------
```
variable "users" {
    type = list(string)
    default = [ "/root/user10", "/root/user11", "/root/user12", "/root/user10"]
}
```
```
resource "local_sensitive_file" "sensitive-file" {
    filename = each.value			# for_each
    content = var.content
    for_each = toset(var.users)
}
```
---------------------------------------------------------------------------------------------
element:
---------------------------------------------------------------------------------------------
Terraform provides a function `element` is used  for accessing elements from a list or tuple based on their index. This function takes a list (or tuple) and an index as arguments and returns the element at the specified index in the list.

```
variable "example_list" {
  type    = list(string)
  default = ["a", "b", "c", "d", "e"]
}
output "third_element" {
  value = element(var.example_list, 2)  	# Returns "c"
}
```

---------------------------------------------------------------------------------------------------------------
Provider Version: 
---------------------------------------------------------------------------------------------------------------
Providers are the plugins for  terraform. sometimes we require to use specific version. for that goto the terraform provider documentation and use the required providers version as below. we can specify the version details like below. 
	
	1. version = "5.33.0"
 	2. version = "!= 5.33.0"	# any version other than this	
  	3. version = "> 5.33.0"		# higher version 
   	4. version = "< 5.33.0"		# lower version
    
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0" 		# specific provider version 
    }
  }
}

provider "aws" {
  # Configuration options
}
```

---------------------------------------------------------------------------------------------------------------
AWS :
---------------------------------------------------------------------------------------------------------------
Creating resources on AWS using the terraform is simple, follow the below steps.

 	1. install AWS-CLI 
  	2. configure AWS with credentials
   	3. terraform play creation for required resouces. 

1. Install AWS-CLI
------------------------------------------------------------------------------
Step-1: Download the AWS_CLI and install it on your working OS.
Step-2: run AWS version and check installed properly or not.

	$ aws --version
Step-3: create your AWS account and configure & Setup the AWS to connect with your account on AWS cloud

	$ aws configure
 
2. AWS - Terraform
------------------------------------------------------------------------------
create a aws user account and configure the access credentials as an input in the `main.tf`.  

1. Passing credentials in main.tf
-----------------------------------------------------------------
```
provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"  
}
```

2. exporting as an environment variables  `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY_ID`
-----------------------------------------------------------------
	$ export AWS_ACCESS_KEY_ID=
	$ export AWS_SECRET_ACCESS_KEY_ID=
	$ export AWS_REGION= us-west-2

3. adding credentials in `.aws/config/credentials` file.
-----------------------------------------------------------------
	[default]
	aws_access_key_id = AKIAI44QH8DHBEXAMPLE
	aws_secret_access_key = je7MtGbClwBF/2tk/h3yCo8n…

4. configure aws credentials in working directory
-----------------------------------------------------------------
when you run this below command, aws will create a folder in your users home directory `.aws/config/config` file stores the default values like `region, output farmat` and `.aws/config/credentials` file stores `accesskey & Secretkey` values. in windows it will stores inthe `C:\Users\USERNAME\.aws\credentials` path.

	$ aws configure
		AWS Access Key ID [None]:
		AWS Secret Access Key [None]:
		Default region name [None]:
		Default output format [None]:

main.tf
------------------------------------------------
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"  
}
```
------------------------------------------------------------------------------------------
Lab-1: creating AWS-IAM User "Lucy" and providing Admin Access
------------------------------------------------------------------------------------------
main.tf
------------------------------
```
resource "aws_iam_user" "admin-user" {
	name = "lucy"
	tags = {
	Description = "Technical Team Leader"
	}
}
resource "aws_iam_policy" "adminUser" {
name = "AdminUsers"
policy = <<EOF				
  {	"Version": "2012-10-17",
	"Statement": [
	         {
	             "Effect": "Allow",
	             "Action": "*",
	             "Resource": "*"
		}
	]
  }
  EOF
}
resource "aws_iam_user_policy_attachment" "lucy-admin-access" {
	user = aws_iam_user.admin-user.name
	policy_arn = aws_iam_policy.adminUser.arn
}
```

admin-policy.json
-------------------------------------------
above EOF section can be moved into a file and pass that file as `file("admin-policy.json")` in the program like below. 
```
{	"Version": "2012-10-17",
	"Statement": [
	         {
	             "Effect": "Allow",
	             "Action": "*",
	             "Resource": "*"
		}
	]
  }
```
main.tf
-------------------------------------------
```
resource "aws_iam_policy" "adminUser" {
	name = "AdminUsers"
	policy =
}
```
------------------------------------------------------------------------------------------
Lab-2: creating AWS-IAM Users in bulk 
------------------------------------------------------------------------------------------
In this lab we create bulk uses using terrafrom. 
main.tf
-------------------------------
```
resource "aws_iam_user" "users" {
  name = var.project-sapphire-users[count.index]
  count = length(var.project-sapphire-users)
}
```
variable.tf
-------------------------------
```
variable "project-sapphire-users" {
     type = list(string)
     default = [ "mary", "jack", "jill", "mack", "buzz", "mater"]
}

```
provider.tf
-------------------------------
```
provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    iam                       = "http://aws:4566"
  }
}
```
------------------------------------------------------------------------------------------
Lab-3: Creating an S3 bucket using Terraform
------------------------------------------------------------------------------------------
main.tf
--------------------------
```
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```
------------------------------------------------------------------------------------------
Lab-4: upload an item to S3 bucket using Terraform
------------------------------------------------------------------------------------------
main.tf
------------------------------------------
```
resource "aws_s3_object" "upload" {
  bucket = "pixar-studios-2020"
  key = "woody.jpg"
  source = "/root/woody.jpg"
}
```
providers.tf
------------------------------------------
```
provider "aws" {
  region                      = var.region
  s3_use_path_style = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3                       = "http://aws:4566"
  }
}
```

------------------------------------------------------------------------------------------
Lab-5: Creating a Dynamo-DB table creation
------------------------------------------------------------------------------------------
main.tf
-------------------------------------------
```
resource "aws_dynamodb_table" "project_sapphire_user_data" {
  name           = "userdata"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "N"
  }
}
```
providers.tf
---------------------------------------------
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.0"
    }
  }
}

provider "aws" {
  region                      = var.region
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb                       = "http://aws:4566"
  }
}
```

------------------------------------------------------------------------------
Remote State file:
------------------------------------------------------------------------------
Terraform state file maintain the realtime infrastructure in .tfstate file. this will allow us to track metadata while deleting resources, terraform will track its dependencies and delete in the required order. we can work with number of cloud providers that will imporove the performance. 

It is not recommunded to maintain the statefile in the version controll systems, because of its sensitive data. terraform will maintain state locking this will prevent from others to apply changes, but in version controll system this is not posible. if in somecase the user didn't pull  the latest changes this will effect the  system to destory the infrstructure. 

this is why we need remote backed to store the terraform file. these backends will load the latest state file when ever they need to run. remote backends like

	1. Terraform cloud
 	2. Google cloud storage
  	3. amazon s3 bucket
   	4. Azure Blob storage
    	5. Hashicarp Console
----------------------------------------------------------------------------------
Lab-1: Remote backend  with s3 & Dynamo-DB
----------------------------------------------------------------------------------
First we need to configure 2 things, after that we need Bucket name, Key to be used, Region, Dynamo-DB table. 

	1. S3 bucket for storing the state file
 	2. Dynamo-DB table will be used for state locking & consistency checks
  
terraform.tf
---------------------------------------------------------------
```
terraform {
  backend "s3" {
    key = "terraform.tfstate"
    region = "us-east-1"
    bucket = "remote-state"
    endpoint = "http://172.16.238.105:9000"
    force_path_style = true

    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
  }
}
```
main.tf
------------------------------------------------------------------
```
resource "local_file" "state" {
    filename = "/root/${var.remote-state}"
    content = "This configuration uses ${var.remote-state} state"
}
```

How to list/move/remove a resouce block from terrraform statefile perminently 
---------------------------------------------------------------------------
to remove a resouce block that we no longer need to maintain, to do so first we need to remove the block from `main.tf` file then from the state file using the `terraform state rm`.

	$ terraform state list							--> lists all resources in state file
 	$ terraform state show random_pet.super_pet_1 				--> 
  	$ terraform state mv random_pet.super_pet_1 random_pet.ultra_pet	--> change in main.tf and state file 
   	$ terrafrom state rm random_pet.ultra_pet				--> remove a resource from state file & main.tf file
     	$ terraform state pull							--> It will pull all the resouce details from the state file

AWS-EC2 instance create using Terraform
------------------------------------------------------------------------
main.tf
--------------------------------------
```
resource "aws_instance" "webserver" {		#To create an Ec2 machine 
  ami = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  tags = {
    Name = "web-1"
    description = "for testing purpose"
  }
  key_name = aws_key_pair.webserver.id
}

resource "aws_key_pair" "webserver" {		# mapping public key to connect with instance 
  key_name = "webserver-key"
  public_key = file("C:\\Users\\karun\\.ssh\\id_rsa.pub")
}
```

---------------------------------------------------------------------------------------------------------
Lab-2 : how to install nginx on the server. 
---------------------------------------------------------------------------------------------------------
main.tf
--------------------------------------
`user_data` will run only at the first boot of the server. this script will try to modify but still it will not install the nginx script.
```
resource "aws_instance" "cerberus" {
  ami = "ami-06178cf087598769c"
  instance_type = "m5.large"
  key_name = aws_key_pair.cerberus-key.id
  user_data = file("./install-nginx.sh")    
  }
resource "aws_key_pair" "cerberus-key" {
  key_name = "cerberus"
  public_key = file("/root/terraform-projects/project-cerberus/.ssh/cerberus.pub")
}
```

Lab-3: creating Elastic-IP 
----------------------------------------------------------------------------------
```
resource "aws_instance" "cerberus" {
  ami = "ami-06178cf087598769c"
  instance_type = "m5.large"
  key_name = aws_key_pair.cerberus-key.id
  user_data = file("./install-nginx.sh")    # user_data will run only at the first boot of the server.
  }
resource "aws_key_pair" "cerberus-key" {
  key_name = "cerberus"
  public_key = file("/root/terraform-projects/project-cerberus/.ssh/cerberus.pub")
}
resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.cerberus.id
  provisioner "local-exec" {
    command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"
  }
}
output "eip-value" {
  value = aws_eip.eip.public_ip
}
```
----------------------------------------------------------------------------------
Provisioners:
----------------------------------------------------------------------------------
Provisioners provide a way to run tasks such as commands, scripts on remote instance where terraform installed. while creating a EC2 instance we can include the provisioners block to install softwares like nginx/apache/redis/etc. specifying the provisioner block will not be sufficient to work, because it require network, security group, and local machine. this mean it require ssh connection to the machine.
to fecilitate the authentication we can use connection block. 

Note: Provisioners are not recommunded to use, instead use the resouce templates(user_data) or use the custom images that already created the nginx AMI's. how ever to get confirmation on installed softwares/scripts/commands you can use 

Provisioners are of 2 types

	1. Remote (remote_exec)	--> to run commands/scripts on newly created ec2 machines using terraform 
 	2. Local (local_exec)	--> to run scripts on local machines from where you run
  	3. file			--> to copyfile local to  remote

main.tf
--------------------------------------------
```
resource "aws_instance" "webserver" {
  ami = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  key_name = aws_key_pair.webserver.id

# this section will perform install actions on the 
  provisioner "remote-exec" {
    inline = [	"sudo apt-get update",
		"sudo apt-get install nginx -y",
    		"sudo systemctl enable nginx",
    		"sudo systemctl start nginx"  ]  
  }
  
}

# this section will use the public key to connect with ec2-machine create above "key_name"
resource "aws_key_pair" "webserver" {
  key_name = "webserver-key"
  public_key = file("C:\\Users\\karun\\.ssh\\id_rsa.pub")
}



```
-------------------------------------------------------------------------------------------
Provisioners Behaviour:
-------------------------------------------------------------------------------------------
in the above example we run the provisioners during the creation time. if we want to run the provisioners during the ec2 instance destring time we can use with when condition. 
```
provisioner "local-exec" {
    command = "echo Instance ${aws_instance.webserver.public_ip} created > /tmp/aws_instance_ip.txt"
  }
```
```
provisioner "local-exec" {
    when  = destroy
    command = "echo Instance ${aws_instance.webserver.public_ip} created > /tmp/aws_instance_ip.txt"
  }
```

----------------------------------------------------------------------------------------------------------
Taint & UnTaint:
----------------------------------------------------------------------------------------------------------
The terraform taint command is used to mark a resource managed by Terraform as "tainted," indicating that it needs to be recreated during the next apply operation. This means that Terraform will destroy the existing resource and create a new one to replace it, effectively forcing Terraform to re-provision the resource even if its configuration hasn't changed.

	$ terraform taint aws_instance.webserver
 	$ terraform untaint aws_instance. webserver

----------------------------------------------------------------------------------------------------------
Debugging in Terraform :
----------------------------------------------------------------------------------------------------------
Terraform logs are provided during the execution. but you can increase the levels. There are 5 logging levels avaiable. this can be done using the log levels. 
we can set the logging level `export TF_LOG=TRACE`, we can move the logs to a file `export TF_LOG_PATH=/tmp/tf.log`. to unset the logging use `unset TF_LOG_PATH`

 	1. info (INFO)
  	2. warning (WARN)
   	3. error (ERROR)
    	4. debug (DEBUG)
     	5. trace (TRACE)

------------------------------------------------------------------------------------------------------------
Terraform Import:
------------------------------------------------------------------------------------------------------------
In most cases the real infrastucture is already created. to use the resouce data we used `data` block. to take control of all the resouces that are created before terraform, to import thouse resouces we use the below command. `terraform import` does not support all resource types and may require manual intervention or custom scripting for complex resources.

 	$ terrafrom import <resouce_type>.<resource_name> <attribute> 	-->   this will not import the resource block directly.

step-1: create a configuration update in main.tf file with the resource details. 
step-2: run terraform import to import the resource details with terraform. then check `terraform state list`  you will find the details.

----------------------------------------------------------------------------------------------
Lab-1: Scenario-1: An AWS EC2 instance is already created using console, to bring the resource under terraform. first lets create a main.tf file with resouce details created using console. 
----------------------------------------------------------------------------------------------

step-1: add the resouce information in main.tf file.

main.tf
---------------------------------
```
resource "aws_instance" "single-web" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
}
```

step-2: import the resouce using the terraform import command. 

	$ terraform import aws_instance.single-web i-0d2208c6358e84cab

step-3: check your resources are added to your terraform file. 

	$ terraform state list 

 ----------------------------------------------------------------------------------------------
Lab-2: Scenario-2: In Bulk An AWS EC2 instance is already created using console, to bring the resource under terraform.
----------------------------------------------------------------------------------------------

import.tf
---------------------------------------------
```
import {
  id = "i-0516a1c33cd29f163"
  to = aws_instance.web1
}
import {
  id = "i-0dae31784e91ab40d"
  to = aws_instance.web2
}
import {
  id = "i-0f821272162c34665"
  to = aws_instance.web3
}
```
generate.tf
----------------------------
```
resource "aws_instance" "web3" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
}
resource "aws_instance" "web1" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
}
resource "aws_instance" "web2" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
}
```

$ terraform init 
$ terraform apply
$ terraform state list 
 
-------------------------------------------------------------------------------------------------------------------------
Terraform Modules:
-------------------------------------------------------------------------------------------------------------------------
Terraform modules are used to reuse the code, this will imporve the reusability of the code. 

main.tf
---------------------------------
#creating and iam using the predefined modules provided by the terraform. create use `max`
```
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.28.0"
  # insert the 1 required variable here
  name  = "max"
  create_iam_user_login_profile = false
  create_iam_access_key =false
}
```


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

-------------------------------------------------------------------------------------------------------------------------------------------------
Lab-1: How to create IAM Users and Groups using Terraform ?
-------------------------------------------------------------------------------------------------------------------------------------------------
providers.tf
-------------------
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # access_key = "AKIAUNKMGRYLZG6RTUPM"
  # secret_key = "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"  
}
```
main.tf
-------------------
```# create user Shiva
resource "aws_iam_user" "shiva" {    
  name = "shiva"                    
}
```
```# create bulk users defined
resource "aws_iam_user" "New-users-2024" {
  name = var.new-users[count.index]
  count = length(var.new-users)
}
```
```# create group Developers and shiv user to that group and add policy
resource "aws_iam_group" "Developers" {
  name = "Developers" 
}
resource "aws_iam_group_policy" "Dev-group-policy" {
  group = aws_iam_group.Developers.name
  policy = file("Dev-group-policy.json")
}

resource "aws_iam_user" "shiva" {
  name = "shiva"
}
resource "aws_iam_user_group_membership" "Dev-group" {
  user = aws_iam_user.shiva.name
  groups = [ aws_iam_group_policy.Dev-group-policy.group ]
}
```
variables.tf
-------------------
```
variable "new-users" {
  default = ["Rama", "Seetha", "Hanuma"]
  type = list(string)
}
```

---------------------------------------------------------------------------------------------------------
Locals
---------------------------------------------------------------------------------------------------------
In Terraform, locals is a construct that allows you to define local values within your configuration. These values are computed during the Terraform execution and can be referenced elsewhere within the same configuration. Locals are useful for simplifying complex expressions, avoiding repetition, and improving readability of your Terraform code.

Note: Local values are created by a `locals` block, but you reference them as attributes on an object named `local`. Make sure to leave off the "s" when referencing a local value!

Example-1
-----------------------------------
```
locals {
  vpc_name        = "my_vpc"		  # Define local values
  subnet_cidr     = "10.0.1.0/24"
  instance_count  = 3
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = local.vpc_name		# Use local value for VPC name
  }
}
```

Example-2
-----------------------------------
```
locals {
  public_subnets_cidr = distinct(var.public_subnets_cidr)
  private_subnets_cidr = distinct(var.private_subnets_cidr)
}

resource "aws_subnet" "public-subnets" {
  count             = length(local.public_subnets_cidr)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(local.public_subnets_cidr, count.index)	# To avoid  the duplicates  in public_subnet use "distinct"
  availability_zone = element(var.azs, count.index)
}
```

---------------------------------------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------------------------------------
useful functions when writing the code.

	1. upper
 	2. lower
  	3. distinct
