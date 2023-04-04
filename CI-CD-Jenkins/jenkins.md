Jenkins: (CD/CI)
=================

Q. What is Jenkins? 
-----------------------
Jenkins is one of the most popular automation tool, that used worldwide for continuous integration and continuous delivery and Continuous Deployment. Jenkins is a free and open-source automation tool that enables developers to package, build, integrate, and test code automatically as soon as it is committed to the source repository. it perform security checks and deploy the code.

Q. Why Jenkins?
-----------------
When working on a project with different teams, developers often face issues with different teams using different CI tools, version management, and other tools. Setting up a CI/CD toolchain for each new project will lead to certain challenges like

    * Slower Releases
    * Manual Builds
    * Non-repeatable processes
    * No Automation

Q. Why Jenkins?
-----------------
Jenkins is the solution to those challenges. its is an Open-source, 1000+ plugins, Free Paid, Enterprise. Jenkins is free and you don’t have to pay for anything. Jenkins can be hosted on a **Virtual Machine**, **container** Or even locally for development purposes. and services like below.

    * Automated builds
    * Automated Tests
    * Automated CI/CD pipelines
    * Automated deployments
    * Ability to install Jenkins locally
    * Jenkins support and Plugin

What are the practical challenges during the code development & Testng?
-----------------------------------------------------------------------
There are challenges in software development like **slower releses, manual builds, humun errors, lack of automation, non-repetable tasks**. this makes the development of the software is slower. this can be corrected with **Jenkins** which provides **automated builds, automated tests, automated CI/CD pipelines, automated deployment, installed locally and plug-ins** which makes software development faster.

Q. What is CI & CD?
----------------------
**Continuous Integration( CI )** is a process in which the code is merged from multiple contributors and added to a single repository. In simple words, CI is a process, take the code, package it, test it, done security checks and  send it to the CD for further processing. 
**Continuous Deployment( CD )** is an automated process in which the code is taken from the repository and deployed to the system.

CI/CD in simple words is a process that takes the code, package, test, done security check and deploy it to a system that can be serverless, a VM, or a container.

      * CI – Continuous Integration
      * CD – Continuous Delivery
      * CD – Continuous Deployment

Q. What are the Key process  of CI?
------------------------------------
Key Processes of Continuous Integration
      * Package the code
      * Test the code (run unit tests, integration tests, etc)
      * Run security checks against the code
      
Q. what is Continuous delivery/deployment?
--------------------------------------------
The basic difference between Continuous Delivery and Continuous Deployment is that in Continuous Delivery to deploy the code after the CI process, you have to manually trigger it via some button to deploy on the system whereas in Continuous Deployment this process is automatic with out manual intervention.

source code --> package code --> build code --> test code --> run security checks --> deploy code -->VM/Docker

Q. what are the key process of CD?
-----------------------------------
Key process of Continuous Deployment
      * Ensure you're authenticated to the system or wherever you're deploying
      * Ensure that the code that's being deployed is working as expected once it's deployed

Q. How to install Jenkins?
----------------------------
Jenkins installtion on Linux, jenkins require Java, we can follow Jenkins documentation to install it. 

    $ sudo yum install epel-release -y --> install all dependencies/repos
    $ sudo yum install java -y  --> java installtion mandate to run jenkins
    $ sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
    $ sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key  --> jenkin key for validation
    $ sudo yum install jenkins -y --> install jenkins

Jenkins installation files are availabel in **`/var/lib/jenkins/`**, in this directory we have config.xml and jobs are stored here, to start the jenkins service the configuration file are available **`/lib/systemd/system/jenkins.service`** file and change Jenkins port to 8090 by updating Environment="JENKINS_PORT=" variable value , It should look like this: Environment="JENKINS_PORT=8090"

    $ sudo vi /lib/systemd/system/jenkins.service
    $ sudo systemctl edit jenkins      --> edit Jenkins service file
    $ sudo systemctl start jenkins      --> start Jenkins service 
    $ sudo systemctl status jenkins     --> status check 
    $ sudo systemctl restart jenkins    --> restart jenkins

Q. what is the use of Jenkins plug-ins ?
-----------------------------------------
Jenkins Plugins are used in Jenkins to enhance Jenkins functionality and cater to user-specific needs. Just like how Gmail, Facebook and LinkedIn help you connect your one service to another, plugins also work the same way and allow us to connect one service to other services and work with other products.

Q. How to install a new plugin in Jenkins?
-------------------------------------------
      1. Go to Manage Jenkins -> Manager Plugins
      2. Click Available and search for the desired plugin.
      3. Select the desired plugin and Install.

Note: Few plugins may need a restart To restart Jenkins `$ sudo systemctl restart jenkins`

Q. How to Update Plugins?
--------------------------
To update any existing plugin in Jenkins
      1. Go to Manage Jenkins -> Manager Plugins
      2. Click Updates and search for the desired plugin.
      3. Select the desired plugin and Install.
Note: Few plugins may need a restart To restart Jenkins `$ sudo systemctl restart jenkins`

Q. How to Delete Plugins?
----------------------------
To delete any plugin in Jenkins
      1. Go to Manage Jenkins -> Manager Plugins
      2. Go to Installed and search for the desired plugin.
      3. Click on uninstall button for the plugin you want to delete.

Q. How to change the Jenkins default listner port?
----------------------------------------------------
by changing the **/lib/systemd/system/jenkins.service** file and edit Environment="JENKINS_PORT=8090" to desired open port. 
      * by default jenkins listen on port 8080

Q. Important file in Jenkins installtion?
-----------------------------------------
1. jenkins service file /etc/systemd/system/jenkins.service
2. jenkins service file also available in /lib/systemd/system/jenkins.service
3. jenkins installed files are available in /var/lib/jenkins/config.xml is the main file to take backup of.

Q. How to restart jenkins from web-ui?
----------------------------------------
we can do it by using **`jenkins-url/restart`**. this will do the job.

Q. how to use jenkins-cli?
---------------------------
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' <command>

Q. Jenkins-UI :
----------------
Jenkins Dashbaord:
   |-> New Item --> FreeStyle, pipelie, Multipipeline, 
   |-> people
   |-> Build History
   |-> Manage Jenkins
   |-> Myview
   |-> Lockable Resource
   |-> New View
   
Q. Managing Users in Jenkins:
-----------------------------
We can manage users in the jenkins and create roles for the users and restric them what they can do and what they can't do. this can be achived with a plugin known as "Role Based Authentication". this plugin allow the admin to create roles for the users and restrict their access. 

Manage Jenkins --> Manage users --> create new user --> login credentials.

Manage Jenkins --> Manage Plugin --> install Plugin--> Role based Authentication Plugin --> Manage and Assign Roles section will appear--> from here you give permissions to the users. 

Q. Managing system configuration:
---------------------------------
In system configuration section
   |-> Configure system --> Jenkins server configurations. setting paths, environments, etc.
   |-> Global Tool configuration --> Maven, JDK, information avaiable here
   |-> manage plugins   --> Install, Update, Delete plugins
   |-> manage nodes and clouds --> jenkins nodes list

Q. Install role-based authentication strategy:
-----------------------------------------------
Installing the plugin "Role-based Authorization Strategy", this allow Jenkins admin can assign roles to the users in jenkins. post install must enable RoleBased Strategy in Global Security section.

   |-> Install plugin "Role-based Authorization strategy
      |-> Goto Globalsecurity ->Authorization section
         |-> enable "RoleBased Strategy" 
            |-> Now it will show in the manage Jenkins page as "Manage and Assign roles"

Q. Assinging project based metrix Authorization strategy:
----------------------------------------------------------
this will allow user to do only the limited authorizations required for that user. for this we install plugin  "Project-based Matrix Authorization Strategy" and add the user provide required permissions what he can do. then save apply. the user can only see the given permissions with his user credentials

Q. Administering Jenkins:
-------------------------
**Backup:** 
Backing the Jenkins is full/snapshot. which files to backup? $JENKINS_HOME && config.xml && Jobs. so its mandetory to backup the JENKINS_HOME directory. Backup jenkins can be done in different ways 
   
   1. Filesystem backup 
   2. Plugin backup (ThinBackup )
   3. shell scripts that backsup. (https://github.com/sue445/jenkins-backup-script)

backup using ThinBackup plugin, goto --> Manange jenkins --> tools & Actions --> thinkbackup --> add the backup settings --> create backup.

**Restore:** 
Restore the backup that has taken from plugin ThinBackup. goto--> Thinbackup --> restore --> select restore date --> select check box "Restore Plugin" --> click restore. 
      
      $ systemctl restart jenkins
      
**Monitor:** 
we can monitor the system using the plugins such as "Prometheus and graphana" or "Datadog" or other. install plugin prometheus metrix. install Prometheus and Grafana on the same machine called jenkins-server. 

   configure Prometheus --> /etc/prometheus/prometheus.yaml --> add jenkins in Targets. as below
```
scrape_configs:
  - job_name: 'Prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'jenkins'
    metrics_path: /prometheus/
    static_configs:
      - targets: ['localhost:8085']   # -targets: ['jenkins-IP:Jenkins-listen-port']
```
restart the prometheus 

   $ systemctl restart prometheus 
   $ service prometheus restart/status/
   $ 

**Scale:**
**manage:**



Q. How to provide limited access to users role based  authentication?
-----------------------------------------------------------------------
to provide restrictions at user level, we need to install a plugin know as **Role-based Authorization Strategy** need to install 

1: Go to Manage Jenkins, then click on Manage and Assign Roles tab.
2: Click on Manage Roles button and then under the Global Roles section, input your role named developers in Role to add box, then click Add button. Now your role will be visible in matrix.
3: Then check mark the box under Read section for developers role only.
4: Now click on Save button on your bottom of the window.

Steps to assign role to the user:

1: Go to Manage Jenkins, then click on Manage and Assign Roles tab..
2: Click on Assign Roles button, then under the Global Roles section input your user named tony in User/group to add box, then click Add button. Now your user will be visible in matrix.
3: Then check mark the box under developers section for tony user only.
4: Now click on Save button on the bottom of the window.

Q. how assign project based metrix authentication?
---------------------------------------------------
1: Go to Manage Jenkins, then click on Manage Plugins tab.
2: Click on Available section and search for Matrix Authorization Strategy plugin.
3: Then mark the box check and click on Install without restart button.
4: After that click on Restart Jenkins when installation is complete and no jobs are running.

Steps to enable Project-based Matrix Authorization Strategy:

1: Go to Manage Jenkins, then click on Configure Global Security tab.
2: Select Project-based Matrix Authorization Strategy under Authorization section.
3: Click on Add User and enter user name tony. After that it will appear in the matrix.
4: Enable Read under Overall column, Build and Read under Job column for user tony.
5: Now click on Save button on your bottom of the page.
6: Login as tony user into the Jenkins server and build the job named mytest.

   
   

      
