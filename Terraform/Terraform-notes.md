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
A. Terraform keeps track of your real infrastructure in a state file, which acts as a source of truth for your environment. Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.

Q. How to install Terraform?
----------------------------
A. Terraform installtion file comes with a binary file named as **"terraform"**. which is responsible to connect with all providers. 


![image](https://user-images.githubusercontent.com/33980623/174418529-dbdbb647-35db-42e9-9751-86c9ed1d3f77.png)

