Red Hat Ansible Engine Implementation:
--------------------------------------

Q. What is Ansible?
--------------------------------------------
Ansible is an Open source configuration management and orchestration utility.  Ansible Automates and standardizes configuration of remote hosts and virtual machines. we can start and shutdown of applications. we can Performs rolling updates with zero downtime. it built on **Python**. it support Vagrant and Jenkins.

Q. What are Ansible Limitations?
--------------------------------------------
Ansible cannot audit changes made by other users on system. **we can't determine who made change to a file.** it does not perform initial minimal installation of system. it does not track changes made to files on system. and its does not track which user or process made changes. To track changes, use version control system or Linux® Auditing System

Q. Ansible Architecture?
--------------------------------------------
there are two types of machines in Ansible architecture
1. control node (Ansible-master) --> Ansible installed and maintained on Ansible-master. It must be linux OS.
2. managed hosts (Ansible-Workers) --> Ansible-worker nodes can be linux / Windows.
	
System administrators login to Ansible-Master and launch Ansible playbook on a specify target host to hosts. Ansible uses **SSH** as network transport to communicate with managed hosts. Modules refer in playbook copied to managed hosts and delete once the task is completed. Core modules perform most system administration tasks Users can write custom modules if needed.

Q. What are Ansible-Master Components?
--------------------------------------------
**Ansible configuration:** Ansible installtion comes with ansible config file `ansible.cfg` located in `/etc/ansible` directory. all ansible settings avaiable here. to override the default values we need to use environment variables (or) we can update the file. 

**Host inventory:** This is a text file, ansible-worker nodes added here. we can devide them into groups for specific tasks.

**Core modules:** Ansible installtion comes with default/core modules. over 400 modules are built to perform various tasks on ansible worker nodes.

**Custom modules:** Ansible allow to use & create custom modules to perform a specific functionality in ansible. they written in python, Add custom modules to Ansible library

**Playbooks:** Ansible playbooks are written in YAML. each task to perform one operation on Ansible-worker node. this task are exicuted in sequential order. playbook tasks use modules with arguments and exicutes on managed hosts

**Connection plug-ins:** Ansible communicate with remote hosts/cloud-hosts using native SSH (default) or Paramiko SSH or local. Paramiko is Python implementation of OpenSSH for Red Hat Enterprise Linux 5 and 6. Ansible supports passwords for SSH authentication. Most common practice: Use SSH user keys to access managed hosts

**Plug-ins:** Extend Ansible’s functionality Examples: Email notifications and logging

Q. what are Ansible-Master Requirements?
--------------------------------------------
	1) Must have Python 2.6 or 2.7 installed
	2) Ansible-master runs on Linux, macOS, any BSD-based UNIX system
	3) Windows not currently supported for Ansible-Master.
	4) On Red Hat Enterprise Linux 6 or 7, ansible package and dependencies must be installed
 
Q. What are Ansible-Managed Host Requirements?
--------------------------------------------
	1. Ansible-worker nodes must install SSH and configured. and it should allow incoming connections from ansible-master. 
	2. install Python 2.4 or later
	3. python-simplejson package must be installed on Red Hat Enterprise Linux 5 managed hosts
	
Note: python=simplejson is Not required on Red Hat Enterprise Linux 6 and 7 managed hosts. Python 2.5 and newer versions provide functionality by default.

Q. What are ansible Use Cases ?
--------------------------------------------
	1) Configuration management
		-> Deploy and manipulate remote host’s configuration files
		-> Use static files or create files on fly using templates
	2) Multi-node deployment tool
		-> Use playbooks to define applications installed and configured on remote machines
		-> Apply playbook to multiple machines, building them in consistent manner
		-> Orchestrate multi-node applications with Ansible rules
	3) Remote task execution
		-> Example: Specify ad hoc commands on command line
		-> Causes Ansible to execute commands on remote hosts

**Red Hat JBoss® Middleware:**

-> Ansible can discover Red Hat JBoss Middleware versions and reconcile subscriptions
-> Ansible supports managed hosts running Windows
-> Red Hat JBoss Middleware products can be deployed consistently, regardless of target machine operating systems
-> Ansible can also deploy and manage Red Hat JBoss Middleware applications
-> All Red Hat JBoss Middleware configurations are centrally stored on Ansible control node

**Red Hat OpenShift®:**

-> Ansible can manage software development life cycle for applications deployed into Red Hat OpenShift Container Platform
-> OpenShift Container Platform 3.1 provides:
	-> Ansible software for Red Hat Enterprise Linux
	-> Playbooks for provisioning and managing applications

**Red Hat Satellite:**

-> Ansible can supplement functionality provided by Red Hat Satellite
-> Deploy Satellite agents to existing servers in datacenter
-> Discover and manage software subscriptions on Red Hat Satellite clients
-> Perform post-install configuration of hosts provisioned by Red Hat Satellite

Q. what are Ansible Orchestration Methods?
--------------------------------------------
Ansible commonly used to finish provisioning application servers

-> Example: Write playbook to perform these steps on newly installed base system:
		-> Configure software repositories
		-> Install application
		-> Tune configuration files
		-> (Optional) Download content from version control system
		-> Open required service ports in firewall
		-> Start relevant services
		-> Test application and confirm it is functioning

Q. what is ansible plugin local?
--------------------------------------------
Ansible plugin "local" is an another connection plug-in for Linux applications. it use to manage Ansible-Master locally, without SSH
	Common uses:
	-> When writing playbooks that interface with cloud services or other API
	-> When Ansible is invoked locally by cron job

Q. What is winrm and docker:
--------------------------------------------
winrm: Allows Windows machines  as managed hosts.
docker: Allows Ansible to treat Docker containers as managed hosts without using SSH. this feature introduced in Ansible 2

 Note: `pywinrm` Python module must be installed on Linux control node to support `winrm`

Q. How can we change Ansible Configuration Settings?
-----------------------------------------------------
Ansible will look for ansible configurations in the below order, we can use `$ ansible-config view` utility to see all configuration settings and their defaults.

	1st) ANSIBLE_CONFIG (environment variable, if set)
	2nd) ansible.cfg (in current directory)
	3rd) ~/.ansible.cfg (in home directory)
	4th) /etc/ansible/ansible.cfg
	
Q. What are Ansible Prerequisites?
--------------------------------------------
Ansible-Master: Ansible uses agentless architecture. Differs from other configuration management utilities like Puppet, Chef. 
	
 	1. Software installs on Ansible-master 
		Only requirement: Python version 2.6 or later 
			# yum list python
			  python.x86_64	2.7.5-34.el7	installed

Managed Hosts: No special Ansible agent needed on ansible-worker nodes. 
	1. Require Python 2.4 or later
	2. Python prior to 2.5, also requires python-simplejson
	3. Control node communicates with managed hosts over network
		-> Multiple options available
		-> SSH connection used by default
	4. Ansible normally connects to managed hosts using same username running Ansible on Ansible-Master.
		-> SSH sessions require authentication at initiation of each connection
		-> Password authentication for each connection becomes unwieldy as number of managed hosts increases
		-> Key-based authentication preferable in enterprise environments

**Q. How Ansible uses SSH Key-Based Authentication?**
---------------------------------------------------------
To authenticate ssh logins without password, use public key authentication. SSH lets users authenticate using private/public key scheme.
	Two keys generated: private and public
	
	1. Private key file used as authentication credential. and it Must be kept secret and secure
	2. Public key file is shared with uses to verify private key. it does not need to be secret.
	-> SSH server with public key issues challenge
		-> System with private key answers
		-> Possession of private key used to complete authentication
			
**Q. How to generate SSH-Keys and uses ?**
---------------------------------------------------------
ssh-keygen: 
To generate keys, use ssh-keygen: $ ssh-keygen 
	1. Private key: ~/.ssh/id_rsa
	2. Public key: ~/.ssh/id_rsa.pub
by Default SSH keys stored in .ssh/ directory of user’s home directory. File permissions on private key allow:
	-> Read/write access to user who owns file
	-> Octal 0600
File permissions on public key allow:
	-> All system users read access
	-> Only file owner write access
	-> Octal 0644

ssh-copy-id: 
Before using key-based authentication, need to copy public key to destination system i.e. Ansible-Worker.
To do this, use ssh-copy-id:
	
	$ ssh-copy-id user@managedhost-ip

After copying key, use key-based authentication to authenticate SSH connections to host

**Q. How to see the ansible Modules ?**
---------------------------------------------------------
To see modules available on Ansible-Master, run ansible-doc with -l option. Modules installed under `/usr/lib/python2.7/site-packages/ansible/modules`
	
	$ ansible-doc -l	--> to list all the default modules available 
	$ ansible-doc yum	--> detail doc for a module yum/firewalld/service/copy 
	$ ansible-doc -s yum 	--> synapsys

**Q. Types of Module comes with ansible?**
---------------------------------------------------------
Core modules: These modules are Included with Ansible. Written and maintained by Ansible Engineering Team. Integral to basic foundations of Ansible distribution. 
Used for common tasks. Always available

Network modules: Currently included with Ansible. Written and maintained by Ansible Network Team. If categorized as Certified or Community, not maintained by Ansible

Certified modules: Part of a future planned program currently in development

Community modules: Included as a convenience. Submitted and maintained by Ansible community.Not maintained by Ansible.

**Q. Anisble Module Categories:**
---------------------------------------------------------
	-> Cloud
	-> Clustering
	-> Commands
	-> Database
	-> Files
	-> Inventory
	-> Messaging
	-> Monitoring
	-> Network
	-> Notification
	-> Packaging
	-> Source Control
	-> System
	-> Utilities
	-> Web Infrastructure
	-> Windows

Modules avaibale in Ansible-Master locally: /usr/lib/python2.7/site-packages/ansible/modules

	$ ansible-doc yum	--> module documentation
	$ ansible-doc -s yum	--> To display sinapsis of a module

To call modules as part of ad-hoc command, use ansible "-m " specifies which module to use
Example: Use ping to test connectivity to all managed hosts:

	$ ansible all -m ping -i inventory.txt
	$ ansible web1 -m command -a "uptime" -i inventory.txt

call modules in playbooks as part of task

Example: Invoke yum module Arguments: Package name and desired state
---------------------------------------------------------------------
```
---
- name: install using yum module
  hosts: all
  tasks:
	- name: Install a package postfix
	  yum:
	    name: postfix
	    state: latest
 ```  
-------------------------------------------------------------------
To call modules from Python scripts, use Ansible Python API
	-> Not supported in case of failures
	-> Can import API into application to leverage Ansible system deployment and configuration

**Q. Ansible Ad-Hoc Commands**

 Ansible lets you run on-demand tasks on managed hosts using ad-hoc commands. Most basic operations you can perform using ad-hoc.  To perform ad-hoc commands, run "ansible" command in Ansible-Master node and specify operations. each command can perform only once operation. multiple operations require  series of commands. 
 
 example:
 	$ ansible -m ping all -i inventory
	$ ansible localhost -m ping 
	$ ansible all -m ping -i inventory

Syntax: ad-hoc command
	$ ansible hosts -m module -a arguments -i inventory

 /etc/ansible/hosts : default inventory file is created --> To specify alternative inventory, use -i

Note: we can use Ansible-Master can include itself as managed host. To define Ansible-master as managed-host, add Ansible-master name, its IP address, localhost name, or IP address 127.0.0.1 to inventory

**Q. ad-hoc with Modules and Arguments?**
	
	 -m --> to specify a module to run on inventory hosts
	 -a --> arguments passed to module.  If multiple arguments needed, use as below with space.
	 -o --> option generates just one line of output for each operation performed
	 
	$ ansible hosts pattern -m module -a 'argument1 argument2 argument3' [-i inventory]
examples:
	$ ansible web1 -m command -a uptime
	$ ansible db1 -m ping
	$ ansible localhost -m copy -a "src=~/src1/file1 dest=~/dest1"
	

**Q. uses of Module: Shell ?**
	
"command" module lets you quickly run remote commands on managed hosts. Not processed by shell on managed hosts. Cannot access shell environment variables. Cannot perform shell operations. To run commands that require shell processing, use shell module. Pass commands to run as arguments to module. Ansible runs command remotelyshell commands processed through shell ans we Can use shell environment variables.

Connection Settings:
After reading parameters, Ansible makes connections to managed host. 
	Default: Connections initiated with SSH
Defined by remote_user setting under [defaults] section in /etc/ansible/ansible.cfg:
		# default user to use for playbooks if user is not specified
		# (/usr/bin/ansible will use current user as default)
		# remote_user = root

Remote Operations:
Default: remote_user parameter commented out in /etc/ansible/ansible.cfg. With parameter undefined, commands connect to managed hosts using same remote user account as one on Ansible-Master running command. After making SSH connection to managed host, specified module performs operation. After operation completed, output displayed on Ansible-Master. Operation restricted by limits on permissions of remote user who initiated it

**Q. what is Privilege Escalation:**

After connecting to managed host, Ansible can switch to another user before executing operation. Example: Using sudo, can run ad hoc command with root privilege
	-> Only if connection to managed host authenticated by nonprivileged remote user
	-> Settings to enable privilege escalation located under [privilege_escalation] section of ansible.cfg:
		#become=True
		#become_method=sudo
		#become_user=root
		#become_ask_pass=False

**Q. how to Enabling Privilege Escalation?**

Privilege escalation not enabled by default, To enable, uncomment become parameter and define as True in ansible.cfg file.
	become=True
	
Enabling privilege escalation makes become_method, become_user, and become_ask_pass parameters available. Applies even if commented out in /etc/ansible/ansible.cfg

Predefined internally within Ansible. Predefined values:
	become_method=sudo
	become_user=root
	become_ask_pass=False

**Q. Command Line Options for ansible?**

Configure settings for remote host connections and privilege escalation in /etc/ansible/ansible.cfg. 
Alternative: Define using options in ad hoc commands. Command line options take precedence over configuration file settings
	-> inventory -i
	-> remote-user -u
	-> become --become, -b
	-> become_method --become-method
	-> become_user --become-user
	-> become_ask_pass --ask-become-pass, -K

Obtaining Current Setting Values:-
----------------------------------
-> Before configuring privilege escalation settings using options, can determine currently defined values
-> To do so, consult output of ansible --help:
	[student@controlnode ~]$ ansible --help
	...output omitted...
	  -b, --become		run operations with become (nopasswd implied)
	  --become-method=BECOME_METHOD
			privilege escalation method to use (default=sudo),
			valid choices: [ sudo | su | pbrun | pfexec | runas |
			doas ]
	  --become-user=BECOME_USER
	...output omitted...
	  -u REMOTE_USER, --user=REMOTE_USER
			connect as this user (default=None)

===============================================================================================================
LAB-1: Ansbile-master setup with worker nodes using Ad-hoc commands.
===============================================================================================================

Ansible Setup and Ad Hoc Command Lab:
In this lab, you set up and configure the Ansible-master server for managing remote hosts. You install the required packages on the Ansible-master server, create a user and set up SSH private keys. Then you test connecting to remote hosts. Finally, you run ad hoc commands to manage the remote hosts.

Goals:-
--------
	-> Install Red Hat Ansible Engine
	-> Create a user on the remote hosts
	-> Test connectivity to the remote hosts
	-> Explore ad hoc commands

1. Connect to Environment:-
---------------------------
-> Connect to an ansible-master host using ssh command 
	
	$ ssh <username>@<hostname>
	  Enter the password: 
	  
	$ ssh devops@192.168.1.10

2. Configure Ansible Controller:-
---------------------------------
You use a "devops" user on the Ansible-Master, and generate an SSH key pair for the user "devops". The "devops" user is used to run all of the Ansible CLI commands to manage the remote hosts.

2.1. Install Ansible:-
----------------------
-> Install ansible on Linux machine as below

	$ sudo yum/dnf install ansible --> Linux based OS
	$ sudo pip install ansible --> Non yum based OS
	$ sudo apt-get install ansible --> Debian/Ubuntu based OS

2.2. Generate SSH Key Pair:-
----------------------------
Generate an SSH key pair for the devops user
	$ ssh-keygen -N '' -f ~/.ssh/id_rsa

Verify that the SSH key was successfully created	
	$ ls -ltr ~/.ssh

3. Set Up Remote Hosts:-
------------------------
3.1. Explore Environment:-
--------------------------
set up the remote hosts: create "devops" user on all of the remote hosts and copy its public key to each host.

-> As the devops user, explore the remote hosts in control node:
	$ ansible all --list-hosts
	(or)
	$ ansible all --list

-> To test the connectivity with remote host using ping module
	$ ansible -m ping all
	(or)
	$ ansible all -m ping

3.2. Create User and Set Up SSH Keys for Remote Host:
------------------------------------------------------
In this section, you create the user and set up the SSH keys for the devops user on the remote hosts.

-> Create the devops user on the remote hosts using the Ansible user module
	$ ansible all -m user -a "name=devops" -b 
	(or)
	$ ansible -m user -a "name=devops" -b all

-> Display the SSH public key for the devops user	
	$ cat ~/.ssh/id_rsa.pub

-> To Add the SSH key to the authorized keys for "devops" user, making sure to replace the value of the SSH public key with the one that you just displayed
	$ ansible all -m authorized_key -a "user=devops state=present key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiR9HQUu8OUr7k8oe+odfvVQgdMNVsHM+dV0oNQnqG+Unv5PSf7GVkp1JwCroF4wIdjKKvEJ8qJqAbxoY3gEcfrSTR9e9p3zeydHIY2svENGmSNjlX28tMe9uisA9KfIEqe013MuIsplGV7YhXAV0YyCCuJ+OMDr+iEmsmVTza/MLzd9iQxYffLwrV+yY+VUilpS12ns/gmDR8ijO5b0sxdHk8Umk77h8Q1bXE8gyue3cnc1c9Sdzpm4UVNhp9ZcqZCqepUBQOszEvllWxrIw+mktzMdn8INgYhiUBzFQxS/92Qh9prB33F3TdOjin4d/Z/tV2lsNN8HVexXswmoF3 devops@bastion.0926.internal'" -b 

-> To Remove the SSH key from authorized_key file use change the state=present to state=removed/absent which will remove the entry from the file.
	$ ansible all -m authorized_key -a "user=devops state=absent key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiR9HQUu8OUr7k8oe+odfvVQgdMNVsHM+dV0oNQnqG+Unv5PSf7GVkp1JwCroF4wIdjKKvEJ8qJqAbxoY3gEcfrSTR9e9p3zeydHIY2svENGmSNjlX28tMe9uisA9KfIEqe013MuIsplGV7YhXAV0YyCCuJ+OMDr+iEmsmVTza/MLzd9iQxYffLwrV+yY+VUilpS12ns/gmDR8ijO5b0sxdHk8Umk77h8Q1bXE8gyue3cnc1c9Sdzpm4UVNhp9ZcqZCqepUBQOszEvllWxrIw+mktzMdn8INgYhiUBzFQxS/92Qh9prB33F3TdOjin4d/Z/tV2lsNN8HVexXswmoF3 devops@bastion.0926.internal'" -b

-> The contents of /home/devops/.ssh/id_rsa.pub is used as the value of the parameter "key" for "authorized_key" Ansible module.

-> Configure sudo on the remote host for privileged escalation for the "devops" user by adding in /etc/sudoers file	
	$ ansible all -m lineinfile -a "dest=/etc/sudoers state=present line='devops ALL=(ALL) NOPASSWD: ALL'" -b

-> Verify the connection to the remote hosts from bastion as the devops user, starting with the app1 server
	$ export GUID=`hostname | awk -F"." '{print $2}'`

	$ ssh <hostname>
	(or)
	$ ssh devops@appdb1.0926.internal

4. Explore Ad Hoc Commands:-
----------------------------
After you have successfully configured the Ansible Controller and remote hosts, you can run Ansible ad hoc commands and playbooks as the "devops" user 
from "Ansible_master" without being prompted for the password.

You configure ansible.cfg and the static inventory needed to complete this lab. You use "-u" to specify the "devops" user and "--private-key" to specify the private key.

1. Verify remote user:
	
	$ ansible all -m command -a whoami

The command is expected to show "ec2-user" because it is using the default ansible.cfg and the SSH keys defined in the default /etc/ansible/hosts static inventory.

2. Create a directory called "ansible_implementation" as your working directory for all future labs and an "ansible.cfg" file with a [defaults] 
section for specifying user-specific settings

	$ mkdir ansible_implementation
	$ cd ansible_implementation/
	$ cat << EOF > ansible.cfg
	[defaults]
	inventory = /home/devops/ansible_implementation/hosts
	remote_user = devops
	private_key_file = /home/devops/.ssh/id_rsa
	host_key_checking = false
	EOF

3. Create /home/devops/ansible_implementation/hosts as the static inventory, which contains the hostnames of all of the remote hosts
	
	$ export GUID=`hostname | awk -F"." '{print $2}'`
	$ cat << EOF > /home/devops/ansible_implementation/hosts
	frontend1.${GUID}.internal
	appdb1.${GUID}.internal
	app1.${GUID}.internal
	app2.${GUID}.internal
	EOF
	
4. Verify the remote user

	$ ansible all -a whoami

5. testing the connectivity 
	
	$ ansible all -m ping

6. identify the user account used by Ansible to perform operations on managed hosts
		
	$ ansible localhost -m command -a 'id'

7. to display the contents of the /etc/motd file on all managed hosts as the devops user
	
	$ ansible all -m command -a "cat /etc/motd" 

8. copy module and the devops account to change the contents of the /etc/motd file to include the message "Managed by Ansible" on all of the remote hosts	

	$ ansible all -m copy -a 'content="Managed by Ansible \n" dest=/etc/motd'
	
Error: Expect the ad hoc command to fail due to insufficient permissions

9. Create the /etc/motd file on all of the hosts, but this time, escalate the root user’s privileges using -b or --become

	$ ansible all -m copy -a 'content="Managed by Ansible\n" dest=/etc/motd' -b

10. Execute an ad hoc command to verify the changes to /etc/motd on all of the remote hosts

	$ ansible all -m command -a 'cat /etc/motd' --become

===================================================================================================================
Your First Playbook:-
---------------------

Inventories:-
-------------
Host inventory file defines hosts managed by Ansible. Hosts may belong to group specify in [ ].  
	1. Typically used to identify host’s role in datacenter
	2. Host can be member of more than one group
   Two ways to define host inventories:
	-> Static host inventory defined by text file
	-> Dynamic host inventory generated from outside providers

Q. what is a Static Host Inventory? 
Static host inventory defined in INI-like text file. Each section in file defines a host group. One line for each managed host
Host entries define how Ansible communicates with managed host. Include transport and user account information. 
	-> Default location for host inventory file: /etc/ansible/hosts
	-> ansible* commands use different host inventory file when used with 
		--inventory PATHNAME
	 	(or)
		-i PATHNAME for short

Example:
-> Host inventory defines two host groups: webservers and db-servers
-> SSH on web2.example.com configured to listen on port 1234
-> Ansible must log in to host as ftaylor

------------------------------------------------------------------------------------------
	[webservers]
	localhost  ansible_connection=local
	web1.example.com
	web2.example.com:1234 	ansible_connection=ssh ansible_user=ftaylor
	192.168.3.7

	[db-servers]
	web1.example.com
	db1.example.com
----------------------------------------------------------------------------------------------

Groups of Groups:-
-------------------
-> Host inventories can include groups of host groups
-> To do this, use :children suffix
-> Example: Create new group nwcapitols that includes all hosts from olympia and salem groups
----------------------------------------------------------------------------------------------
	[olympia]
	washington1.example.com
	washington2.example.com
	
	[salem]
	oregon01.example.com
	oregon02.example.com
	
	[nwcapitols:children]
	olympia
	salem
-----------------------------------------------------------------------------------------------

Ranges:-
--------
-> To simplify host inventories, specify ranges in host names or IP addresses
	-> Supports numeric and alphabetic ranges

-> Range syntax: [START:END]
-> Ranges match all values between START and END

Examples:-
----------
-> 192.168.[1:5].[0:255]: All IP addresses in 192.168.1.0/24 through 192.168.5.0/24 networks

-> server[01:20].example.com: All hosts named server01.example.com through server20.example.com

Leading Zeros:-
---------------
-> Include or remove leading zeros for numeric ranges
	-> Example: Simplify olympia and salem group definitions by using ranges:

	[olympia]
	washington[1:2].example.com
	
	[salem]
	oregon[01:02].example.com

Playbook Variables:-
--------------------
we can define variables in inventory.txt file, as below. if the variables are specific to a single host, or to a group of hosts
	
1. Variable are specific to a single host. on web1 we are installing "httpd" on web2 we are installing "tomcat"
	[web]
	web1 ansible_host=172.20.1.100 ansible_ssh_pass=Passw0rd ansible_user=root webserver=httpd
	web2 ansible_host=172.20.1.101 ansible_ssh_pass=Passw0rd ansible_user=root webserver=tomcat

2. Defining variables for a specific group. to do so [group-name:vars]. this means variables defined in vars section 
	[web]
	web1 ansible_host=172.20.1.100 ansible_ssh_pass=Passw0rd ansible_user=root 
	web2 ansible_host=172.20.1.101 ansible_ssh_pass=Passw0rd ansible_user=root 

	[web:vars] 	# syntax to define group variables [group-name:vars]
	webserver=httpd

2. Dynamic Host Inventory:
---------------------------
Host inventory information can be dynamically generated.
	-> Public and private cloud providers
	-> Cobbler system information
	-> LDAP database
	-> Configuration management database (CMDB)
-> Ansible includes scripts that handle dynamic host, group, and variable information from common providers
	-> Examples: Amazon EC2, Cobbler, Rackspace Cloud, OpenStack®
-> For cloud providers, authentication and access information must be defined in files that scripts can access
-> Default: Ansible provides text-based inventory format

Defines hosts to be managed:-
-----------------------------
-> For large infrastructures, system information usually maintained in multiple inventory system solution
	-> Examples: Cobbler, Zabbix
-> Ansible uses scripts to support external inventories
-> Retrieve hosts information via method used by external inventory
	-> Example: RESTful APIs
-> Also uses scripts to retrieve inventories from cloud and virtualization solutions
-> Provide dynamic way to create and delete hosts
	-> Example: Red Hat OpenStack Platform	

Supported Platforms:-
---------------------
Ansible GitHub site: https://github.com/ansible/ansible/tree/devel/contrib/inventory
-> Contains scripts that support retrieving hosts information for many platforms:

Platform Type:-
---------------
-> Private cloud platforms : Red Hat OpenStack Platform
-> Public cloud platforms : Rackspace Cloud, AWS, Google Compute Engine
-> Virtualization platforms : oVirt (upstream of Red Hat Virtualization)
-> Platform-as-a-Service solutions : OpenShift
-> Life-cycle management tools : Spacewalk (upstream of Red Hat Satellite)
-> Hosting providers : Digital Ocean, Linode

-> Each platform script has different requirements
	-> Example: Cloud credentials for Red Hat OpenStack Platform
-> For specific requirements, see "Developing Dynamic Inventory Sources" in Ansible documentation
	

3. YAML Overview:-
-------------------
Ansible Playbooks written in YAML language. Need understanding of YAML syntax basics. YAML designed to represent data structures in easy-to-write, human-readable format
	Examples: Lists, associative arrays
-> Abandons enclosure syntax used to structure data hierarchy in other languages
	Examples: Brackets, braces, open/close tags
-> Uses outline indentation to maintain data hierarchy structures

YAML File Syntax:-
-------------------
-> Optional document markers:
	-> Start of document: ---
	-> End of document: ...

Strings:-
---------
-> No requirement to enclose strings in quotation marks
-> Even if string contains spaces
-> Optional: Enclose string in single or double quotation marks
	Examples:
	this is a string
	'this is another string'
	"this is yet another a string"

Multiline String Methods:-
--------------------------
Use |:-
---------
-> Preserves line returns within string:
	include_newlines: |
         	Example Company
        	123 Main Street
        	Atlanta, GA 30303
Use > :-
---------
-> Converts line returns to spaces
-> Removes leading white spaces in lines
-> Use to break long strings at space characters
-> Spanning multiple lines promotes better readability
	fold_newlines: >
          	This is
          	a very long,
          	long, long, long
          	sentence.

Lists:-
--------
-> Lists in YAML = arrays in other languages
-> To represent list, precede each item with - followed by space:
	---
  	- red
  	- green
  	- blue

-> Optional: Express lists in inline format
-> Enclose list items between square brackets
-> To separate items, use , followed by space:
	---
	fruits:
  		[red, green, blue]

Comments: #
-----------

Examples:
	# This is a YAML comment
	some data # This is also a YAML comment

Syntax Verification:-
---------------------
-> Syntax errors in playbook cause execution to fail
-> Best practice: Verify YAML syntax in playbook prior to execution
-> To read playbook YAML file using Python, use command similar to:
	[student@demo ~] python -c 'import yaml, sys; print yaml.load(sys.stdin)' < myyaml.yml

--syntax-check :
-----------------
YAML Lint: Online YAML syntax verification tools available
	Example: YAML Lint website: http://yamllint.com/

--syntax-check :
	$ ansible-playbook --syntax-check myyaml.yml

4. Playbooks and Ad Hoc Commands:-
----------------------------------
Playbooks:-
-----------
-> Playbooks: Files that describe configurations or steps to implement on managed hosts
-> More flexible and powerful configuration management and deployment than ad hoc commands
-> Turn complex operations into mundane routines with predictable and successful outcomes
-> Written in simple, human-readable YAML format
-> Syntax easier to write and understand than other configuration management tool languages

Plays, Tasks, and Hosts:-
-------------------------
-> Sports playbook analogy:
	-> Contains collection of plays
	-> Each has different patterns for execution
-> Ansible Playbooks also contain plays
	-> Each defines set of operations to perform on set of managed hosts
	-> Operations called tasks
	-> Managed hosts referred to as hosts
-> To perform tasks, invoke Ansible modules and pass arguments to accomplish operation
-> Order of contents within playbook matters
	-> Plays and tasks executed in order presented

Multiple Plays:-
----------------
-> Playbook can contain one or more plays
-> Play applies set of tasks to set of hosts
-> Multiple plays required when:
-> One set of tasks performed on one set of hosts
-> Different set of tasks performed on different set of hosts

Playbook Creation:-
-------------------
-> Start playbook YAML file with document separator: ---
	-> Optional
	-> Playbook executes properly with or without marker
-> Terminate playbook file with document terminator: ...
	-> Also optional
	-> When terminator not used, end of file serves as end of playbook

Plays and Attributes:-
----------------------
-> Within playbook file, plays expressed in list
	-> Each defined using dictionary data structure
	-> Each starts with - followed by space
-> Within play, can define various attributes
	-> Attribute definitions consist of name followed by :, space, value:

Name Attribute:-
-----------------
-> Gives descriptive label to play
-> Optional but recommended
-> Especially useful in playbook with multiple plays
	name: my first play

Hosts Attribute:-
-----------------
-> Defines set of managed hosts on which to perform tasks
-> Integral component to play
-> Must be defined in every play
-> To define, use host pattern to reference hosts in inventory:
	hosts: managedhost.example.com

User Attribute:-
-----------------
-> Playbook tasks executed through network connection to managed hosts
-> User account used for execution depends on parameters in /etc/ansible/ansible.cfg
-> To define user to execute task, use remote_user
	-> If privilege escalation enabled, other parameters such as become_user can have impact
-> To overwrite user from configuration file and define different user, use user
	user: remoteuser

Privilege Escalation Attribute:-
---------------------------------
-> Attributes define privilege escalation parameters within playbook
-> To enable/disable privilege escalation, use become boolean
-> Takes effect regardless of how escalation is defined in configuration file
	become: yes/no

-> To define privilege escalation method for specific play, use become_method
-> Example: Use sudo for privilege escalation:
	become_method: sudo

-> To define user account to use for privilege escalation within specific play, use become_user:
	become_user: privileged_user

Tasks Attribute:-
------------------
-> Use to define operations to execute on managed hosts
-> Defined as list of dictionaries
-> Each task composed of set of key/value pairs
-> Example: tasks list consisting of single task
	-> First item entry defines task name
	-> Second invokes service module and supplies arguments as values:
	tasks:
	     -	name: first task
		service: name=httpd enabled=true

-> Hyphen in first entry marks beginning of list of task attributes
-> Second entry indented to same level as first
-> Conveys that both attributes refer to same parent task

Multiple Tasks:-
-----------------
-> For multiple tasks, repeat same syntax for each:

	tasks:
   	  - name: first task
      	    service: name=httpd enabled=true

    	  - name: second task
            service: name=sshd enabled=true

          - name: last task
            service: name=sshd enabled=true

Example: Writing a Playbook:-
----------------------------
---
  # This is a simple playbook with a single play
  - name: a simple play
    host: managedhost.example.com
    user: remoteuser
    become: yes
    become_method: sudo
    become_user: root
    tasks:
    - name: first task
      service: name=httpd enabled=true
    - name: second task
      service: name=sshd enabled=true
...
-------------------------------

Example: Multiline Formatting:-
-------------------------------
Single-line format:-
---------------------

tasks:
    - name: first task
      service: name=httpd enabled=true state=started

Multiline format:-
------------------

tasks:
    - name: first task
      service: 
      	name: httpd
        enabled: true	# Will enable httpd as a service.
        state: started

Blocks:-
------------
In some Complex playbooks may contain long list of tasks. we use this Some tasks related to perticular functionality.
	Blocks: Alternative method of task organization

in high level it Use to group related tasks. this will improves readability.

Examples: Block Formatting:-
-----------------------------
tasks:
    - name: first task
      yum: name=httpd state=latest
    - name: second task
      yum: name=sshd enabled=openssh-server state=latest
    - name: third task
      service: name=httpd enabled=true state=started
    - name: fourth task
      service: name=sshd enabled=true state=started
tasks:
    - block:
      - name: first package task
        yum: name=httpd state=latest
      - name: second package task
        yum: name=sshd enabled=openssh-server state=latest
    - service:
      - name: first service task
        service: name=httpd enabled=true state=started
      - name: second service task
        service: name=sshd enabled=true state=started
	
------------------------------

Example: Playbook with Multiple Plays
---------------------------------------
---
  # This is a simple playbook with two plays

  - name: first play
    host: web.example.com
    tasks:
    - name: first task
      service: name=httpd enabled=true

  - name: second play
    host: database.example.com
    tasks:
    - name: first task
      service: name=mariadb enabled=true

...
-----------------------------------------

Playbook Execution:
--------------------
-> To execute playbooks, use ansible-playbook
-> Run on control node
-> Pass name of playbook to be executed as argument
-> Output shows play and tasks being executed
-> Also reports results of each task executed

Example: Playbook Execution:-
-----------------------------
[student@controlnode ~]$ cat webserver.yml
  ---
  - name: play to setup web server
    hosts: servera.lab.example.com
    tasks:
    - name: latest httpd version installed
      yum:
        name: httpd
        state: latest
  ...

  [student@controlnode ~]$ ansible-playbook webserver.yml

  PLAY [play to setup web server] ************************************************

  TASK [setup] *******************************************************************
  ok: [servera.lab.example.com]

  TASK [latest httpd version installed] ******************************************
  ok: [servera.lab.example.com]

  PLAY RECAP *********************************************************************
  servera.lab.example.com : ok=2 changed=0 unreachable=0 failed=0

-------------------------------

Name Attribute:-
----------------
-> Output demonstrates why name useful for plays and tasks in playbook
-> name value displayed in output
-> Facilitates monitoring of playbook execution progress
	-> Especially for playbooks with multiple plays and tasks

-> Example: Successful playbook syntax verification:

	$ ansible-playbook --syntax-check webserver.yml

Dry Run: -C
------------
-> ansible-playbook also offers -C option
-> When run with -C:
-> Ansible does not make changes on managed hosts
-> Instead reports what changes would occur if playbook is executed

$ ansible-playbook -C webserver.yml

  PLAY [play to setup web server] ************************************************

  TASK [setup] *******************************************************************
  ok: [servera.lab.example.com]

  TASK [latest httpd version installed] ******************************************
  changed: [servera.lab.example.com]

  PLAY RECAP *********************************************************************
  servera.lab.example.com : ok=2 changed=1 unreachable=0 failed=0

Step-by-Step Execution: --step
------------------------------
-> ansible-playbook offers --step option
-> When run with --step, Ansible steps through each playbook task
-> Before executing task, Ansible prompts for input
-> Options:
	y: Execute task
	n: Skip task
	c: Exit step-by-step and execute remaining tasks without further interaction

Facts:-
-------
-> Facts: Variables automatically discovered by Ansible from managed host
-> Pulled by setup module
-> Contain information stored into reusable variables
-> Part of playbooks as:
	-> Conditionals
	-> Loops
	-> Any dynamic statement that depends on managed host value
Examples:
	-> Server can be restarted depending on current kernel version
	-> MySQL configuration file can be customized depending on available memory
	-> Users can be created depending on host name

Using Facts:-
--------------
-> Facts can be part of blocks, loops, conditionals, etc.
-> Virtually no limits on their use
-> Provide convenient way to:
-> Retrieve managed host state
-> Decide action to take based on state
-> Useful to create dynamic groups of hosts that match criteria

Facts provide information about:
--------------------------------
-> Host name
-> Kernel version
-> Network interfaces
-> IP addresses
-> Operating system version
-> Environment variables
-> Number of CPUs
-> Available/free memory
-> Available disk space
-> Custom Facts
-> Cached Facts

$ ansible demo1.example.com -m setup --> to gather the facts 

Use in Playbooks: 
-> Fact output returned in JSON
-> Values stored in Python dictionary
-> To retrieve value, browse dictionaries
-> Use of facts from managed host in playbook:

-> Hostname : {{ ansible_hostname }}
-> Main IPv4 address (based on routing) : {{ ansible_default_ipv4.address }}
-> Main disk first partition size (based on disk name: vda, vdb, etc.) : {{ ansible_devices.vda.partitions.vda1.size }}
-> DNS servers : {{ ansible_dns.nameservers }}
-> kernel version : {{ ansible_kernel }}

Variable Values:
----------------
-> When using fact, Ansible dynamically swaps in value for variable name:

---
- hosts: all
  tasks:
  - name: Prints various Ansible facts
    debug:
      msg: The default IPv4 address of {{ ansible_fqdn }} is {{ ansible_default_ipv4.address }}

Sample Output:
--------------
Ansible:
-> Queries managed host
-> Uses system information to dynamically update variable:

[user@demo ~]$ ansible-playbook playbook.yml
PLAY ***********************************************************************

TASK [setup] ***************************************************************
ok: [demo1.example.com]

TASK [Prints various Ansible facts] ****************************************

ok: [demo1.example.com] => {
    "msg": "The default IPv4 address of demo1.example.com is
            172.25.250.10"
}

PLAY RECAP *****************************************************************
demo1.example.com : ok=2 changed=0 unreachable=0 failed=0

-> Also can use facts to create dynamic groups of hosts that match criteria

Filters:-
-----------
-> To have only some facts returned, use filters
-> Examples: Only retrieve information about:
	Network cards
	Disks
	Users

-> Limit results when gathering managed host facts
-> Facts returned in JSON-nested structure
-> Therefore, can filter various levels
-> To use filters, pass expression as argument: -a 'filter=EXPRESSION'

Example: Filters:-
-------------------
[user@demo ~]$ ansible demo1.example.com -m setup -a 'filter=ansible_eth0'
demo1.lab.example.com | SUCCESS => {
    "ansible_facts": {
        "ansible_eth0": {
            "active": true,
            "device": "eth0",
            "ipv4": {
                "address": "172.25.250.10",
                "broadcast": "172.25.250.255",
                "netmask": "255.255.255.0",
                "network": "172.25.250.0"
            },
            "ipv6": [
                {
                    "address": "fe80::5054:ff:fe00:fa0a",
                    "prefix": "64",
                    "scope": "link"
                }
            ],
            "macaddress": "52:54:00:00:fa:0a",
            "module": "virtio_net",
            "mtu": 1500,
            "pciid": "virtio0",
            "promisc": false,
            "type": "ether"
        }
    },
    "changed": false
}
---------------------

Disabling Facts:
----------------
-> Disable facts for managed hosts if managing large number of servers
-> To disable facts, set gather_facts to no in playbook:

---
- hosts: large_farm
  gather_facts: no

Custom Facts:-
-------------
custom facts are the facts defined by the user depends on the requirement. Create and push custom facts to managed hosts. once they are pushed they are Integrated and read by setup. Save custom facts file in `/etc/ansible/facts.d` directory with file extentions `.fact` this is for Ansible to find facts.
Example: uses of custome facts.
		-> System value based on custom script
		-> Value based on program execution

custom.fact
----------------------------------------
[packages]
web_package = httpd
db_package = mariadb-server

[users]
user1 = joe
user2 = jane
----------------------------------------

-> Help ensure successful installation and retrieval of custom facts:
-------------------------------
[user@demo ~]$ ansible demo1.example.com -m setup -a 'filter=ansible_local'
demo1.lab.example.com | SUCCESS => {
    "ansible_facts": {
        "ansible_local": {
            "custom": {
                "packages": {
                    "db_package": "mariadb-server",
                    "web_package": "httpd"
                },
                "users": {
                    "user1": "joe",
                    "user2": "jane"
                }
            }
        }
    },
    "changed": false
}
--------------------------------

Playbooks
Used in same way as default facts:

---
- hosts: all
  tasks:
  - name: Prints various Ansible facts
    debug:
      msg: The package to install on {{ ansible_fqdn }} is {{ ansible_local.custom.packages.web_package }}

[user@demo ~]$ ansible-playbook playbook.yml
PLAY ***********************************************************************

TASK [setup] ***************************************************************
ok: [demo1.example.com]

TASK [Prints various Ansible facts] ****************************************
ok: [demo1.example.com] => {
    "msg": "The package to install on demo1.example.com is httpd"
}

PLAY RECAP *****************************************************************
demo1.example.com : ok=2 changed=0 unreachable=0 failed=0

----------------------------------
==================================================================================
Lab-2: -
==================================================================================

Static Inventory and Playbook Lab
1. Connect to Environment
2. Configure Static Inventory to Add Host Groups
3. Write Playbook to Verify Connectivity
4. Set Up Static Inventory to Use Inventory Variables
5. Write, Deploy, and Test Playbook
6. Evaluate Your Progress
7. Clean Up Environment

------------------------------------------------------
Static Inventory and Playbook Lab:-
-----------------------------------
-> In this lab, you set up and configure a static inventory to group managed remote hosts according to their role. Then you test the connection to the remote hosts
using a host group. Finally, you write a playbook to set up an Apache web server with static content.

Goals:-
--------
1. Configure a static inventory to add managed hosts in groups
2. Write a playbook to check connectivity using a host group
3. Set up a static inventory to use inventory variables
4. Write a playbook to deploy an Apache web server to the hosts in the "webservers" host group

1. Connect to Environment:
-----------------------------
	$ ssh user@hostname

2. Configure Static Inventory to Add Host Groups:
-------------------------------------------------
-> In this section, you configure a static inventory and add managed hosts to the hosts file, grouped by their roles:
-> Append the host groups to the end of the "/home/devops/ansible_implementation/hosts" static inventory file

	$ export GUID=`hostname | awk -F"." '{print $2}'`
	$ cd ~/ansible_implementation
	$ cat << EOF >> /home/devops/ansible_implementation/hosts
	[lb]
	frontend1.${GUID}.internal

	[webservers]
	app1.${GUID}.internal
	app2.${GUID}.internal

	[db]
	appdb1.${GUID}.internal

	EOF

3. Write Playbook to Verify Connectivity:
-----------------------------------------
-> In this section, you write a playbook that uses the ping module to verify the connection to the managed hosts in the webservers host group.

	$ cat << EOF > check_webservers.yml
	- hosts: webservers
	  tasks:
	  - name: Check connectivity
	    ping:
	EOF

-> Use --syntax-check to verify the syntax of your playbook

	$ ansible-playbook --syntax-check check_webservers.yml

-> Use --check to perform a dry run of the playbook

	$ ansible-playbook --check check_webservers.yml

-> Run the playbook
	
	$ ansible-playbook check_webservers.yml

-> Note that the play in the playbook is running on "app1 and app2" as both of the systems are member of the "webservers" host group.

4. Set Up Static Inventory to Use Inventory Variables:
------------------------------------------------------
-> In this section, you configure the hosts inventory file to use an inventory variable so that you do not have to include -u and --private-key options to specify the remote user and private key.

	cat << EOF >> /home/devops/ansible_implementation/hosts
	[webservers:vars]
	ansible_user = devops
	ansible_ssh_private_key_file = /home/devops/.ssh/id_rsa
	EOF

Run the check_webservers.yml playbook again without specifying any options:
	
	$ ansible-playbook check_webservers.yml

5. Write, Deploy, and Test Playbook:-
-------------------------------------
In this section, you write a playbook to deploy an Apache web server on the webservers host group using the yum, service, and copy modules.

Write a playbook to deploy the Apache (HTTPD) web server—but this time, rather than specifying the "--become or -b" option for privileged escalation, use become: yes in your playbook

---------------
$ cat << EOF > /home/devops/ansible_implementation/deploy_apache.yml
- hosts: webservers
  become: yes
  tasks:
  - name: Install httpd package
    yum:
      name: httpd
      state: latest
  - name: Enable and start httpd service
    service:
       name: httpd
       state: started
       enabled: yes
  - name: Create index.html file for hosting static content
    copy:
      content: "Hoorraaayyy!!! My first playbook ran successfully"
      dest: /var/www/html/index.html
EOF
-----------------
-> To check the playbook syntax errors: $ ansible-playbook --syntax-check deploy_apache.yml
-> To check the playbook on remote hosts: $ ansible-playbook deploy_apache.yml --check

-> Run/Execute the playbook:
	$ ansible-playbook deploy_apache.yml

-> Verify that you are able to access the web page on the app1 host
	$ curl http://app1.${GUID}.internal

-> Verify that you are able to access the web page on the app2 host
	$ curl http://app2.${GUID}.internal

============================================================================================

Lab-3: facts 
============================================================================================
1. Ansible managed hosts information:
-------------------------------------
[lb]
frontend1.0926.internal

[webservers]
app1.0926.internal
app2.0926.internal

[db]
appdb1.0926.internal

[webservers:vars]
ansible_user = devops
ansible_ssh_private_key_file = /home/devops/.ssh/id_rsa

----------

2. Gather Facts:
----------------
-> Using the Ansible setup module, run an ad hoc command to retrieve the facts for all of the servers in the db group:
-> The output displays all of the facts gathered for appdb1 server in JSON format

	$ cd ~/ansible_implementation
	$ ansible db -m setup

-> Review the variables displayed.
-> Filter the facts matching the "ansible_user" expression and append a wildcard to match all of the facts starting with "ansible_user"

	$ ansible db.com -m setup -a "filter=ansible_user*"

3. Create Custom Facts:
-----------------------
-> In this section, you set custom facts for the managed hosts in the webservers host group.
-> Create a fact file named custom.fact with the following content

	$ cat << EOF > custom.fact
	[general]
	package = httpd
	service = httpd
	state = started
	EOF

-> This defines the package to install and the service to start on app1 and app2.
-> Create a setup_facts.yml playbook to create the /etc/ansible/facts.d remote directory and save the custom.fact file to it

-------------------------------------
$ cat << EOF > setup_facts.yml
- name: Install remote facts
  hosts: webservers
  become: yes
  vars:
    remote_dir: /etc/ansible/facts.d
    facts_file: custom.fact
  tasks:
  - name: Create the remote directory
    file:
      state: directory
      recurse: yes
      path: "{{ remote_dir }}"
  - name: Install the new facts
    copy:
      src: "{{ facts_file }}"
      dest: "{{ remote_dir }}"
EOF
-------------------------------------

Run the playbook: $ ansible-playbook setup_facts.yml

-> Using the setup module, run an ad hoc command to display only the ansible_local section, which contains user-defined facts
	
	$ ansible webservers -m setup -a 'filter=ansible_local'

4. Use Facts to Configure Web Servers:
--------------------------------------
-> In this section, you write a playbook that uses both default and user-defined facts to configure the webservers host group, and make sure that all of the tasks are defined.

-> Create the first task, which installs the httpd package, using the user fact for the name of the package.

-> Create another task that uses the custom fact to start the httpd service

--------------------
$ cat << EOF > setup_facts_httpd.yml
- name: Install Apache and starts the service
  hosts: webservers
  become: yes
  tasks:
  - name: Install the required package
    yum:
      name: "{{ ansible_local.custom.general.package }}"
      state: latest

  - name: Start the service
    service:
      name: "{{ ansible_local.custom.general.service }}"
      state: "{{ ansible_local.custom.general.state }}"
EOF
-----------------
->  Run the playbook:

	$ ansible-playbook setup_facts_httpd.yml

-> Use an ad hoc command to determine whether the httpd service is running on webservers
	
	$ ansible webservers -m command -a " systemctl status httpd "

-----------------------------------------------------------
Question 1 : How do you make Ansible pick up a custom module without adding that custom module in the standard module installation path?
Name the module 'library' and place it in the same directory as the playbook
Create a library directory in the standard module path and place the module there
Create a "library" directory in the same directory as the playbook and place the custom module there
Place the module in the default system module path

Question 2: Which command enables you to identify the parameters that a module accepts?
ansible -m module_name --show-paramters
ansible-playbook --show-doc module_name
ansible-doc module_name
ansibledoc module_name

Question 3: In which order do tasks execute inside plays or roles?
Assigned importance
Alphabetical order, based on role name
Opportunistically based on availability of resources on the target host
One at a time, against all machines matched by the host pattern

Question 4: Tasks must be written with parameters using either "key=value" or "key: value".
TRUE
FALSE

Question 5: Under which circumstances should plays be named?
When more than one play exists in a playbook, or when a more friendly grouping of output is desired
Plays must always be named
When starting at a named play with the --start-at-play command line option
Never; only tasks can be named

Question 6: The following directory can be used to include custom modules in task lists in a role:
modules
files
alt
library

Question 7: Which command would you execute to run an ad hoc task against an Ansible managed host?
ansible
ansible-vault
ansible-ad hoc
ansible-playbook

Question 8 : The following describes Ansible Playbooks:
A collection of Ansible modules
The language by which Ansible orchestrates, configures, administers, or deploys systems
It is written in Python
None of the above

Question 9 : Which of the following best describes Ansible facts?
Ansible does not use facts
Things that are discovered about remote nodes
The source of truth
User-defined variables

---------------------------------

Loops, Variables, and Return Values:-
------------------------------------

Topics:-

1. Variables Overview:
----------------------
Variables are used for Reusing content in playbooks helps reduce errors.
-> Variable: String or number that gets assigned value
-> When variable is invoked, Ansible replaces with value
-> Lets you reuse information across:
	Playbooks
	Inventory files
	Tasks and roles
	Jinja2 template files

-> Use variables to define:
	Users
	Packages
	Services
	Files
	Archives

-> Variable Names Must start with letter
-> Valid characters include letters, numbers, underscores

Examples:
---------------------------
Invalid		| Valid
------------------------------
web server	: web_server
remote.file	: remote_file
1st file	: file_1, file1
remoteserver$1	: remote_server_1, remote_server1

Array Example: users array:-
---------------------------

users:
  bjones:
    first_name: Bob
    last_name: Jones
    home_dir: /users/bjones
  acook:
    first_name: Anne
    last_name: Cook
    home_dir: /users/acook

Accessing Variables in the yaml file:-
----------------------------------
-> To access users "Bob" :  users.bjones.first_name
-> to access /users/bjones : users.acook.home_dir

Alternative method for accessing users:

-> To access users "Bob" : users['bjones']['first_name']
-> to access /users/bjones : users['acook']['home_dir']

Ad Hoc Commands:-
------------------
-> To pass variables as arguments for ad hoc commands, use -a
	-> Allows module arguments

$ ansible all -i hosts -m debug -a "msg='This line will appear as a message'"


Playbooks:-
------------
You can use your own variables and invoke them in task. we can do it in 2 ways
	1. define in the YAML file in "vars" section as below.
	2. define all variables in a file and invoke that file in the YAML file. 

In vars section we can define the variables.
----------------------------------
- hosts: all
  vars:
    user: joe
    home: /home/joe
  tasks:
  - name: Creates the user {{ user }}	# This line will read: Creates the user joe
    user:
      name: "{{ user }}"	 # This line will create the user named Joe
------------------------------------

-> When using variable as first element for value, must use " ". Should be written as: with in Quotations "{{  }}"
--------------------------
     loop:
       - "{{ foo }}"
       - "{{ abc }}"
       - "{{ xyz }}"
--------------------------

Example: Definition Reuse:-
--------------------------
- name: Installs Apache and starts the service
  hosts: webserver
  vars:
    base_path: /srv/users/host1/mgmt/sys/users
    users:
      joe:
        name: Joe Foo
        home: "{{ base_path }}/joe"
      bob:
        name: Bob Bar
        home: "{{ base_path }}/bob"

  tasks:
  - name: Print user details records
    debug: msg="User {{ item.key }} full name is {{ item.value.name }}. Home is {{ item.value.home }}"
    with_dict: "{{ users }}"
-----------------------------------------

Variable Precedence: 
---------------------
-> Variables can be defined in multiple locations
-> If Ansible finds variables with same name, uses chain of precedence
-> Ansible 2: Variables evaluated in 16 categories of precedence order

1. Role default variables:
--------------------------

Set in roles vars directory:

[configuration]
users:
  - joe
  - jane
  - bob

2. Inventory variables:
-----------------------

[host_group]
demo.exmample.com ansible_user: joe

3. Inventory group_vars variables:
----------------------------------

[hostgroup:children]
host_group1
host_group2

[host_group:vars]
user: joe

4. Inventory host_vars variables:
---------------------------------

[hostgroup:vars]
user: joe

5. group_vars variables defined in group_vars directory:
--------------------------------------------------------
--
user: joe

6. host_vars variables defined in host_vars directory:
------------------------------------------------------

---
user: joe

7. Host facts:
--------------

-> Facts discovered by Ansible:

"ansible_facts": {
        "ansible_all_ipv4_addresses": [
        "172.25.250.11"
        ],
        "ansible_all_ipv6_addresses": [
        "fe80::5054:ff:fe00:fa0b"
        ],
        "ansible_architecture": "x86_64",
        "ansible_bios_date": "01/01/2011",
        "ansible_bios_version": "0.5.1",
...

8. Registered variables:
------------------------

Registered with register keyword:

---
- hosts: all
  tasks:
    - name: Checking if Sources are Available
      shell: echo "This is a test"
      register: output

9. Variables defined via set_fact:
----------------------------------

- set_fact:
  user: joe

10. Variables defined with -a or --args:
----------------------------------------

ansible-playbook main.yml -a "user=joe"
ansible-playbook main.yml --args "user=joe"

11. vars_prompt variables:
--------------------------

vars:
from: "user"
  vars_prompt:
    - name: "user"
      prompt: "User to create"

12.Variables included using vars_files:
---------------------------------------

vars_files:
  - /vars/environment.yml

13. role and include variables:
-------------------------------

---
- hosts: all
  roles:
    - { role: user, name: 'joe' }
  tasks:
    - name: Includes the environment file and sets the variables
      include: tasks/environment.yml
      vars:
        package: httpd
        state: started

14. Block variables:-
-----------------

For tasks defined in block statement:

tasks:
  - block:
    - yum: name={{ item }} state=installed
      with_items:
        - httpd
        - memcached

15. Task variables:-
----------------

Only for task itself:

- user: name=joe

16. extra variables:
----------------------

Precedence over all other variables

[user@demo ~]$ ansible-playbook users.yml -e "user=joe"


Variable Scope:
---------------
variable Scope determined by location in which you declare variable. Defines where variable is accessible from

 Three are 3 levels

Global	: Set by configuration, environment variables, command line
Play	: Set by playbook, play, defined by vars, include, include_vars
Host	: Set at host level, Example: ansible_user defines user to connect with on managed host


Variable evaluated when playbook is played:
--------------------------------------------
vars:
  user: joe
  
-----------------------------------------

Host independent of play:
-------------------------
-> To make variable available for host independent of play, define as group variable in inventory file:

---------------------------------
[servers]
demo.example.com

[servers:vars]
user: joe

--------------------------------

Extra-Vars:
-----------
-> To enable variable to override playbook, declare as extra:

[user@demo ~]$ ansible-playbook users.yml -e 'user=joe'

Variables Management:
---------------------
-> Declare playbook variables in various locations:
-> In inventory file as host or group variables
-> In vars statement as playbook variables
-> In register statement
-> Passed as arguments using -a
-> Passed as extra arguments using -e

Host Variables:-
----------------
[servers]
demo.example.com ansible_user=joe

Group Variables:
-----------------
[servers]
demo1.example.com
demo2.example.com

[servers:vars]
user=joe

Host Group Variables:
-----------------------------------
[servers1]
demo1.example.com
demo2.example.com

[servers2]
demo3.example.com
demo4.example.com

[servers:children]
servers1
servers2

[servers:vars]
user=joe

------------------------------------

-> To define variables for all hosts in group, use host variables
-> To define variables for multiple groups, use group variables

General Value for All Servers:
------------------------------
Sample scenario: Managing two datacenters

Goal: Define general value for all servers in both datacenters

Recommended: Use group variables
------------------------------------------------
[datacenter1]
demo1.example.com
demo2.example.com

[datacenter2]
demo3.example.com
demo4.example.com

[all:vars]
package=httpd

------------------------------------------------

Value Varying by Datacenter:
----------------------------
Recommended: Use group variables

[datacenter1]
demo1.example.com
demo2.example.com

[datacenter2]
demo3.example.com
demo4.example.com

[datacenter1:vars]
package=httpd

[datacenter2:vars]
package=apache

Example 3: Value Varying by Host:
---------------------------------
Recommended: Use host variables

[datacenter1]
demo1.example.com package=httpd
demo2.example.com package=apache

[datacenter2]
demo3.example.com package=mariadb-server
demo4.example.com package=mysql-server

[datacenters:children]
datacenter1
datacenter2

Example 4: Default Value That Host Overrides:
---------------------------------------------
Recommended: Host group variable with manual override

[datacenter1]
demo1.example.com
demo2.example.com

[datacenter2]
demo3.example.com
demo4.example.com

[datacenters:children]
datacenter1
datacenter2

[datacenters:vars]
package=httpd

$ ansible-playbook demo2.exampe.com main.yml -e "package=apache"

Variables: "register"
---------------------
register variable is used in the tasks, to To capture command’s output. use "register" statement to store the output saved into variable. Use for debugging purposes or other tasks. below is the exmple used for the same. 

Example: register
-----------------------------
---
- name: Installs a package and prints the result
  hosts: all
  tasks:
    - name: Install the package
      yum:
        name: httpd
        state: installed
      register: install_result
    - debug: var=install_result
-------------------------------
	- shell: echo "{{ item }}"
	  loop:
	    - one
	    - two
	  register: echo
	  
  ------------------------------
Tasks and Variables:
--------------------
Examples:
-> dev.yml imported when Ansible configures development servers
-> prod.yml imported when Ansible configures production environment
-> Variable file useful for segmenting sensitive data
-> File encryption with Ansible Vault protects data


Example: Importing Variables:
-----------------------------
Module: include
----------------
include module is used to call/use other playbook in to current YAML file. with help of this we can call multiple plays with in a YAML file. remember (include_tasks, include_role, import_playbook, import_tasks) that have well established and clear behaviours. This module will still be supported for some time but we are looking at deprecating it in the near future. this can't be used for importing variable files. you import variable file need to use other module call include_vars.

------------------------
----
- hosts: localhost
  tasks:
    - debug:
        msg: play1

- name: Include a play after another play
  include: otherplays.yaml
-----------------------------

Module: include_vars
---------------------
include_vars is a module to load variables from a file dynamically with in a task. and if you want to use this variables in all tasks you must include it in the begining of all tasks. then only the variables defined can be used across the play. other wise we will get error, because YAML is sequential exicution of tasks. until the include_vars are not exicuted it will not fetch the values in to the memory. 

variables.yml
------------------------
packages:
   web_package: httpd
   db_package: redis
   
----------------------
---
- hosts: all
  tasks:
  - name: Includes the tasks file and defines the variables
    include_vars: /tmp/variables.yml

  - name: Debugs the variables imported
    debug:
      msg: "{{ packages['web_package'] }} and {{ packages.db_package }} have been imported"
-------------------------

Loop:
------
Ansible offers the "loop", "with_<lookup>", and "until" keywords to execute a task multiple times. "loop" will help you to reuse the same code for same tasks to repeat. it Eliminates need to rewrite tasks that are repeated for modules that support list.

Example: If installing multiple packages, loop avoids using yum module multiple times

Simple Loops:
------------
---
- hosts: all
  tasks:
  - yum:
      name: "{{ item }}"
      state: latest
    loop:
    - postfix
    - dovecot
----------------------

Simple Loop Array:
------------------
use a vairable and list the array of values and use that in the loop. 

Example: Pass loop array as argument
-----------------------------
vars:
  mail_services:
    - postfix
    - dovecot

tasks:
  - yum:
      name: "{{ item }}"
      state: latest
    loop: "{{ mail_services }}"
---------------------------

List of Hashes:
---------------
to pass list of arrays, we can pass it as below. 

- user:
    name: {{ item.name }}
    state: present
    groups: {{ item.groups }}
  loop:
    - { name: 'jane', groups: 'wheel' }
    - { name: 'joe', groups: 'root' }

Ansible Return Values:
----------------------
-> Ansible modules normally return data structure that can be:
	-> Registered into variable
	-> Seen directly when output by Ansible
-> Optionally, module can document unique return values
	-> Viewable using ansible-doc



changed		: Boolean indicating if task had to make changes

failed		: Boolean indicating if task failed

msg		: String with generic message relayed to user

results		: Indicates:
		: Loop was present for task
		: It contains list of normal module result per item

stderr		: Contains error output of command-line utilities
		: Utilities executed by some modules to run commands
		: Examples: raw, shell, command

ansible_facts	: Contains dictionary appended to facts assigned to host
		: Facts are directly accessible
		: Registered variable not required

warnings	: Contains list of strings presented to user

deprecations	: Key containing list of dictionaries presented to user
		: Dictionary keys: msg, version
		: Values: String
		: Value for version key can be empty string

=================================================================================
Lab-3: Variables Lab:
=================================================================================
In this lab, you define and use variables in a playbook. You create a playbook that installs the Apache web server and opens the ports for the service to be reachable. The playbook queries the web server to ensure that it is up and running.

Goals:
------
1.  Define variables in a playbook and create tasks that include defined variables
2.  Gather facts from a host and create tasks that use the gathered facts
3.  Define variables and tasks in separate files and use the files in playbooks

2. Create Playbook to Set Up Web Services:
-------------------------------------------
In this section, you create a playbook to set up web services on the webservers. Create the variable_test.yml playbook and define the following variables in the vars section. below are the steps involved creating the play

	1.  Create the tasks block and add a first task, which uses the yum module to install the required packages.
	2.  Add two more tasks to start and enable the httpd and firewalld services.
	3.  Add a task that creates content in /var/www/html/index.html.
	4.  Add a task that uses the "firewalld" module to add a rule for the web service.

---------------------------------------------
$ cat << EOF > variable_test.yml
---------------------------------------------
---	
- name: Install Apache and start the service
  hosts: webservers
  become: yes
  vars:
    web_pkg: httpd		# web_pkg defines the name of the package to install for the web server
    firewall_pkg: firewalld	# firewall_pkg defines the name of the firewall package
    web_service: httpd		# web_service defines the name of the web service to manage
    firewall_service: firewalld		# firewall_service defines the name of the firewall service to manage
    python_pkg: python-httplib2		# python_pkg defines a package to be installed for the uri module
    rule: http			# rule defines the service to open
  tasks:
    - name: Install the required packages
      yum:
        name:
          - "{{ web_pkg  }}"
          - "{{ firewall_pkg }}"
          - "{{ python_pkg }}"
        state: latest
    - name: Start and enable the {{ firewall_service }} service
      service:
        name: "{{ firewall_service }}"
        enabled: true
        state: started

    - name: Start and enable the {{ web_service }} service
      service:
        name: "{{ web_service }}"
        enabled: true
        state: started
    - name: Create web content to be served
      copy:
        content: "Example web content"
        dest: /var/www/html/index.html
    - name: Open the port for {{ rule }}
      firewalld:
        service: "{{ rule }}"
        permanent: true
        immediate: true
        state: enabled

EOF
-----------------------------------------------

-> Check the syntax of the variable_test.yml playbook:
	$ ansible-playbook --syntax-check variable_test.yml

3. Create Playbook for Smoke Test:
----------------------------------
this will help to find the above YAML play is working/not. we will check the URL for the content on the servers. and will look for the output is as expected or not.

-------------------------------------
cat << EOF > webserver_smoketest.yml
---
- name: Verify the Apache service
  hosts: localhost
  tasks:
    - name: Ensure the webserver is reachable
      uri:
        url: http://app1.${GUID}.internal
        status_code: 200
EOF
---------------------------------

-> In this section, you run the variable_test.yml playbook to set up the web services of app1 and app2. Then you run the webserver_smoketest.yml smoke-test playbook to verify that the web services are running on the correct hosts.
-> Note that Ansible starts by installing the packages, and then starts and enables the services.

-> Run the webserver_smoketest.yml playbook to make sure that the web server is reachable

=================================================================================
Lab-4: Variable inclusion: 
=================================================================================
In this lab, you manage inclusions in Ansible Playbooks. You create a task file, variable file, and playbook. The variable file defines, in YAML format, a variable used by the playbook. The task file defines the required tasks and includes variables that are passed later on as arguments.

-> Goal : Create an Ansible Playbook that uses inclusions

2. Create Task File:
--------------
	1.  Create a tasks directory under ~/ansible_implementation.
	2.  In the tasks directory, create the environment.yml task file.
	3.  In the playbook, define the two tasks that install and start the web server.
	4.  Use the "package" variable for the package name, "service" for the service name, and "svc_state" for the service state.

-------------------------------
$ mkdir tasks
$ cd tasks
$ cat << EOF > environment.yml
  - name: Install the {{ package }} package
    yum:
      name: "{{ package }}"
      state: latest
  - name: Start the {{ service }} service
    service:
      name: "{{ service }}"
      state: "{{ svc_state }}"
EOF
-------------------------------

-> Change back to the main project directory:

3. Create Variable File:
------------------------
-> Create and change to the vars directory
	$ mkdir vars
	$ cd vars

-> Create the variables.yml variable file with the following content:
------------------------
$ cat << EOF > variables.yml
firewall_pkg: firewalld
EOF
------------------------
-> The file defines the firewall_pkg variable in YAML format.

-> Change back to the main project directory:

4. Create Main Playbook:-
------------------------
In this section, you create and edit the main playbook, main_playbook.yml, which imports the tasks and variables, and installs and configures the firewalld service.

steps:
	1.  Create the playbook main_playbook.yml.
	2.  Add the webservers host group and define a rule variable with a value of http.
	3.  Define the first task with the include_vars module and the variables.yml variable file.
	4.  The include_vars module imports extra variables that are used by other tasks in the playbook.
	5.  Define a task that uses the import_tasks module to include the base environment.yml playbook:
	6.  Because the three defined variables are used in the base playbook, but are not defined, include a vars block.
	7.  Set three variables in the vars section:
		package: httpd
		service: httpd
		svc_state: started

	8.  Create a task that installs the firewalld package using the firewall_pkg variable.
	9.  Create a task that starts the firewalld service.
	10. Create a task that adds a firewall rule for the HTTP service using the rule variable.
	11. Add a task that creates the index.html file for the web server using the copy module:
	12. Create the file with the Ansible ansible_fqdn fact, which returns the fully qualified domain name.
	13. Include a time stamp in the file using an Ansible fact.

----------------------------------------
 cat << EOF > main_playbook.yml
- hosts: webservers
  become: yes
  vars:
    rule: http
  tasks:
    - name: Include the variables from the YAML file
      include_vars: vars/variables.yml

    - name: Include the environment file and set the variables
      import_tasks: tasks/environment.yml
      vars:
        package: httpd
        service: httpd
        svc_state: started

    - name: Install the firewall
      yum:
        name: "{{ firewall_pkg }}"
        state: latest

    - name: Start the firewall
      service:
        name: firewalld
        state: started
        enabled: true

    - name: Open the port for {{ rule }}
      firewalld:
        service: "{{ rule }}"
        immediate: true
        permanent: true
        state: enabled

    - name: Create index.html
      copy:
        content: "{{ ansible_fqdn }} has been customized using Ansible on the {{ ansible_date_time.date }}\n"
        dest: /var/www/html/index.html
EOF
---------------------------------------

-> Verify the syntax of the main_playbook.yml playbook:
	$ ansible-playbook --syntax-check main_playbook.yml

-> Run the playbook and examine the output
	$ ansible-playbook main_playbook.yml


-> Note that Ansible starts by including the environment.yml playbook and running its tasks, then continues to execute the tasks defined in the main playbook.
-> Confirm that the app1 web server is reachable from bastion

	$ export GUID=`hostname | awk -F"." '{print $2}'`
	$ curl http://app1.${GUID}.internal

-> You see this output because the index.html file was created.

====================================================

Question 1: What is the preferred method for declaring inventory variables?
In the inventory file
In extra_vars
In the host_vars and group_vars directories
In the role defaults

Question 2: How do you make modules return values which would be stored as Ansible facts?
The JSON returned by the module should have the 'ansible_facts' key, and then all the key/values would be stored as facts
Add "register: true" in the response JSON
Ansible does not have an option to store Ansible returned values as facts; you must use a register in the task
Add "set_fact: true" in the response JSON

Question 3: Which module would you use to add a fact for hosts during runtime?
register
set_fact
fact
group_by

Question 4: Which strategy can significantly speed up the initial task run for some plays?
Disable gather_facts
Omit play names
Omit task names
Disable debug output

Question 5: Inventory variable paths can be used with which of the following?
include_vars
roles
include
Both a and b

Question 6: Which of the following lists variable precedence (from highest to lowest)?
['extra vars', 'role_vars/included_vars/play_vars/etc', 'gathered facts', 'inventory file connection vars', 'other inventory variables', 'role defaults']
['gathered facts', 'role_vars/included_vars/play_vars/etc', 'other inventory variables', 'inventory file connection vars', 'role defaults', 'extra vars']
['extra vars', 'role defaults', 'role_vars/included_vars/play_vars/etc', 'other inventory variables', 'gathered facts', 'inventory file connection vars']
['inventory file connection vars', 'extra vars', 'gathered facts', 'role_vars/included_vars/play_vars/etc', 'other inventory variables', 'role defaults']

Question 7: Which would evaluate to the OS family of a server, defined in inventory as "someserver," while Ansible connected to a different server?
{{ host_vars['all']['someserver']['ansible_os_family'] }}
{{ hostvar['someserver']['ansible_os_family'] }}
{{ host_vars['someserver']['ansible_os_family'] }}
{{ hostvars['someserver']['ansible_os_family'] }}

Question 8: In which directory should local facts be placed?
This is defined in ansible.cfg
/etc/ansible/facts/
~/.ansible/facts.d/
/etc/ansible/facts.d/

Question 9: What must you add to the task in order to store the output of an Ansible module in a variable called 'results'?
out_var: results
results: output
register: results
variable: results

Question 10: Which of the following is not a valid variable name?
__________
50_Shades_of_Ansible
__hammer_time__
awesome_possum

Question 11: Which of that he following can be used to import variables from a YAML file?
add_vars
include
import_vars
include_vars

Question 12: Which of the following is a valid way of defining variables via the command line?
--extra-vars 'hosts:vipers user:starbuck'
-e 'hosts:vipers user:starbuck'
--extra-vars 'hosts=vipers, user=starbuck'
-e 'hosts=vipers user=starbuck'

=======================================

Ansible Roles : 
----------------
we can create custom ansible roles as per our needs, or we can use the comunity supported roles developed by the ansible communicty using ansible-galaxy command. this ansible roles are used to reuse the code in multiple places. depends on requirement. and it will separte the tasks, variables, handleres, etc arganized properly so that they can be used in mutiple places.  Roles can split playbooks into smaller playbooks and files

Role Uses: Enable Ansible to load components from external files. Roles written as general purpose can be reused

Structure Example:

		$ tree user.example
		user.example/
		├── defaults
		│   └── main.yml
		├── files
		├── handlers
		│   └── main.yml
		├── meta
		│   └── main.yml
		├── README.md
		├── tasks
		│   └── main.yml
		├── templates
		├── tests
		│   ├── inventory
		│   └── test.yml
		└── vars
		└── main.yml

Subdirectories:
----------------

defaults	: main.yml contains default values for role variables
		: Values can be overwritten when role is used

files		: Contains static files referenced by role tasks

handlers	: main.yml contains role handler definitions

meta		: main.yml defines role information
		: Includes author, license, platforms, optional dependencies

tasks		: main.yml contains role task definitions

templates	: Contains Jinja2 templates referenced by role tasks

tests		: Can contain inventory and test.yml playbook
		: Used to test role

vars		: main.yml defines role variable values

Variables and Defaults:
----------------------
create vars/main.yml with < name: value > pairs in hierarchy. YAML uses role variables like any other variable: {{ VAR_NAME }}. High priority and it Cannot be overridden by inventory variables

Use default variables to set default values for included or dependent role variables. To define default variables, create defaults/main.yml with name: value pairs in hierarchy. Lowest priority of any variables. Overridden by any other variable

note: Best practice: Define variable in vars/main.yml or defaults/main.yml. Use default variable when role needs value to be overridden

Example:
----------------------------
---
- hosts: remote.example.com
  roles:
    - role1
    - role2
-----------------------------

Roles in Playbooks:
-------------------
For each role, include the following in playbook in this order. 
	1. Tasks
	2. Handlers
	3. Variables
	4. Dependencies

-> Role tasks (copy, script, template, include) reference files, templates, tasks
-> Ansible searches for items in these locations:
	-> Files: files
	-> Templates: templates
	-> Tasks: tasks
-> Eliminates need for absolute or relative path names

Alternative Syntax:-
--------------------
-> role1 same as previous example

If role2 used, default variable values overridden:
---------------------------------------
---
- hosts: remote.example.com
  roles:
    - { role: role1 }
    - { role: role2, var1: val1, var2: val2 }
---------------------------------------
---
dependencies:
  - { role: apache, port: 8080 }
  - { role: postgres, dbname: serverlist, admin_user: felix }
---------------------------------------

Dependency Behavior:
--------------------
-> Default: Role added as dependency to playbook once
	-> If role is listed as dependency again, it does not run
-> To override default, set allow_duplicates to yes in meta/main.yml

Order of Execution:
-------------------
-> Default: Role tasks execute before tasks of playbooks in which they appear
-> To override default, use pre_tasks and post_tasks
	-> pre_tasks: Tasks performed before any roles applied
	-> post_tasks: Tasks performed after all roles completed

Order of Execution Example:
---------------------------

---
- hosts: remote.example.com
  pre_tasks:
    - shell: echo 'hello'
  roles:
    - role1
    - role2
  tasks:
    - shell: echo 'still busy'
  post_tasks:
    - shell: echo 'goodbye'


------------------------------

Directory Structure:
---------------------
-> Ansible looks for roles in:
	-> roles subdirectory
	-> Directories referenced by roles_path
	-> Located in Ansible configuration file
	-> Contains list of directories to search
	-> Each role has directory with specially named subdirectories

Directory Structure Example
Define motd role:

[user@host ~]$ tree roles/
roles/
└── motd
    ├── defaults
    │   └── main.yml
    ├── files
    ├── handlers
    ├── tasks
    │   └── main.yml
    └── templates
        └── motd.j2

Subdirectories:
----------------
-> files and templates
	-> Contain fixed-content files and templates
	-> Can be deployed by role when it is used

-> Other subdirectories
	-> Contain main.yml files
	-> Define default variable values, handlers, tasks, role metadata, variables

-> Empty subdirectory is ignored
-> Subdirectory not used by role can be omitted

Role Creation:
----------------
-> After creating structure, define role content
-> Use ROLENAME/tasks/main.yml
	-> Defines modules to call on managed hosts where role is applied

Content Example:
-----------------
-> tasks/main.yml file manages /etc/motd on managed hosts
-> Uses template to copy motd.j2 to managed host
-> Retrieves motd.j2 from role’s templates subdirectory:

[user@host ~]$ cat roles/motd/tasks/main.yml
---
# tasks file for motd

- name: deliver motd file
  template:
    src: templates/motd.j2
    dest: /etc/motd
    owner: root
    group: root
    mode: 0444

--------------------

Content Output:
-----------------
-> Display contents of templates/motd.j2 template of motd role
	-> References Ansible facts and system_owner variable:

$ cat roles/motd/templates/motd.j2
This is the system {{ ansible_hostname }}.

Today's date is: {{ ansible_date_time.date }}.

Only use this system with permission.
You can ask {{ system_owner }} for access.

Default Variable Values:
------------------------
-> Role can define default value for system_owner
-> Default values set in defaults/main.yml in directory structure
-> Example: defaults/main.yml sets system_owner to user@host.example.com
-> Email address written in /etc/motd of managed hosts where role is applied:

$ cat roles/motd/defaults/main.yml
---
system_owner: user@host.example.com

Use in Playbook:
------------------
-> To access role, reference it in roles: playbook section

Example: Playbook referencing motd role
	-> No variables specified
	-> Role applied with default variable values:

------------------
$ cat use-motd-role.yml
---
- name: use motd role playbook
  hosts: remote.example.com
  user: devops
  become: true

  roles:
    - motd

----------------------

Variables:
-----------
-> Use variables with roles to override default values
-> When referencing roles with variables, must specify variable/value pairs

Variable Example:
------------------
Use motd with different value for system_owner

someone@host.example.com replaces variable reference when role is applied to managed host:
$ cat use-motd-role.yml
---
- name: use motd role playbook
  hosts: remote.example.com
  user: devops
  become: true

  roles:
    - { role: motd, system_owner: someone@host.example.com }

--------------------------

Ansible Galaxy:
-----------------

https://galaxy.ansible.com

-> Library of Ansible roles written by Ansible administrators and users
-> Archive contains thousands of Ansible roles
-> Database helps users identify helpful roles for accomplishing task
-> Includes links to documentation and videos for users and developers

================================================================================
Lab: 5 Roles Lab
================================================================================

-> In this lab, you create Ansible roles that use variables, files, templates, tasks, and handlers to deploy a network service and enable a working firewall. You then use Ansible Galaxy to initialize a new Ansible role, and download and install an existing role.

Goals:
-> Create Ansible roles to deploy a network service and enable a working firewall
-> Use Ansible Galaxy to initialize, download, and install roles

2. Create Roles:
-----------------

-> In this section, you create roles to deploy the web application. You create a role to set up the Apache web server. Then you create a role to install mariadb and use a database backup file to populate the database. Lastly, you create a role for setting up a HAProxy load balancer for high availability for your web application.

2.1. Create Role to Set Up Web Services:
----------------------------------------
-> In this section, you create a role to set up httpd services.
-> Create a role called app-tier using the ansible-galaxy command.
-> Add a task to install and enable firewalld.
-> Add a task to install and start httpd.
-> Add a task to create a custom vhost.conf configuration file under the /etc/httpd/conf.d/ directory.
-> The vhost.conf.j2 template is already created to help you with this step.
-> Add a task to create the /var/www/vhost/ document root directory.
-> Add a task to create an index.php file in the document root directory using index.j2 as the template.
-> Add a task to open the firewall ports as per the requirements.
-> Enable SELinux so that the Apache back-end server can connect to the database:
	httpd_can_network_connect_db
	httpd_can_network_connect
-> Create the vars/main.yml file under the app-tier role directory that contains definitions for all of the variables defined in tasks.
-> Create the file handlers/main.yml under the app-tier role directory that contains a handler to restart services if needed.

=================================================
Lab-6: Roles Lab
=================================================
$ mkdir roles/
$ ansible-galaxy init roles/app-tier
$ cat << EOF > roles/app-tier/tasks/main.yml

-------------------------------------------
---
# tasks file for roles/app-tier
# Installation of packages based on inventory groups
- name: Install Firewalld
  yum:
   name: firewalld
   state: latest

- name: Start firewalld service
  service:
   name: firewalld
   state: started
   enabled: true

- name: Install httpd
  yum:
   name: "{{ item }}"
   state: latest
  with_items:
   - "{{ httpd_pkg }}"

- name: Start httpd
  service:
   name: "{{ httpd_srv }}"
   enabled: true
   state: started


- name: Copy vhost template file
  template:
   src: vhost.conf.j2
   dest: /etc/httpd/conf.d/vhost.conf
  notify:
   - restart_httpd

- name: Create Document Root
  file:
   path: /var/www/vhost/
   state: directory

- name: Copy index.j2 file
  template:
   src: index.j2
   dest: /var/www/vhost/index.php
   mode: 0644
   owner: apache
   group: apache

- name: Open httpd port
  firewalld:
   service: http
   state: enabled
   immediate: true
   permanent: true

- name: enable selinux boolean
  seboolean:
   name: "{{ item }}"
   state: yes
   persistent: yes
  loop:
   - httpd_can_network_connect_db
   - httpd_can_network_connect

EOF

[devops@bastion ansible_implementation]$ cat << EOF > roles/app-tier/handlers/main.yml
---
# handlers file for roles/app-tier

- name: restart_httpd
  service:
   name: "{{ httpd_srv }}"
   state: restarted

EOF

[devops@bastion ansible_implementation]$ cat << EOF > roles/app-tier/vars/main.yml
---
# vars file for roles/app-tier

db:
 user: root
 database: userdb
 password: redhat
httpd_pkg:
 - httpd
 - php
 - php-mysql
httpd_srv: httpd
db_srv: mariadb
EOF

$ cp ~/roles-setup-files/index.j2 roles/app-tier/templates/
$ cp ~/roles-setup-files/vhost.conf.j2 roles/app-tier/templates/

-----------------------------------

2.2. Create Role to Set Up Database:
------------------------------------

-> In this section, you create a role to install mariadb services and restore the backup file.

-> Create a role called db-tier using the ansible-galaxy command.
-> Add tasks to your playbook to install and enable the mariadb service, and start firewalld, in a similar manner as the previous exercise.
-> Open firewall ports as per the requirements.
-> Add tasks to check if the mariadb root password is set and set a password as specified in playbook variables.
-> Add a task to ensure that users have the appropriate privileges on the database.
-> Add a task to copy the userdb.backup database backup file to the server.
-> Add a task to restore the userdb.backup backup file for mariadb data.
-> Create a vars/main.yml file under the db-tier role that defines values for all of the variables defined in the tasks, including these values for the 	database:
	user: root
	password: redhat
	database: userdb
	backup file name: userdb.backup

------------------------------------
[devops@bastion ansible_implementation]$ ansible-galaxy init roles/db-tier
[devops@bastion ansible_implementation]$ cp ~/roles-setup-files/userdb.backup roles/db-tier/files/
[devops@bastion ansible_implementation]$ cat << EOF > roles/db-tier/tasks/main.yml
---
# tasks file for roles/db-tier
- name: Install mysql
  yum:
   name: "{{ item  }}"
   state: latest
  loop:
   - "{{ db_pkg }}"

- name: Start mysql
  service:
   name: "{{ db_srv }}"
   enabled: true
   state: started

- name: Start firewalld
  service:
   name: firewalld
   state: started
   enabled: true

- name: Open mysql port
  firewalld:
   service: mysql
   state: enabled
   immediate: true
   permanent: true

- name: Check if root password is set
  shell: >
    mysqladmin -u root status
  changed_when: false
  failed_when: false
  register: root_pwd_check


- name: Setting up mariadb password
  mysql_user:
   name: "{{ db['user'] }}"
   password: "{{ db['password'] }}"
  when: root_pwd_check.rc == 0

- name: DB users have privileges on all databases
  mysql_user:
   name: "{{ db['user']}}"
   priv: "*.*:ALL"
   append_privs: yes
   password: "{{ db['password']}}"
   login_password: "{{ db['password']}}"
   host: "{{ item }}"
  loop:
   - "{{ inventory_hostname }}"
   - '%'

- name: Copy database dump file
  copy:
   src: "{{ db['backupfile']}}"
   dest: /tmp

- name: Restore database
  mysql_db:
   name: "{{ db['database'] }}"
   state: import
   target: "/tmp/{{ db['backupfile'] }}"
   login_password: "{{ db['password']}}"
EOF

[devops@bastion ansible_implementation]$ cat << EOF > roles/db-tier/vars/main.yml
---
# vars file for roles/db-tier
db_pkg:
 - mariadb
 - mariadb-server
 - MySQL-python
 - firewalld
db_srv: mariadb
db:
 user: root
 database: userdb
 password: redhat
 backupfile: userdb.backup
EOF
-----------------------------------

2.3. Create Role to Set Up Load Balancer:
------------------------------------------
-> In this section, you create a role to install HAProxy services and use the webservers host group as the back end.

-> Create a role called lb-tier using the ansible-galaxy command.
-> Add tasks to install and start the firewall, then start HAProxy.
-> Add a task to copy an HAProxy template to the server, using the haproxy.j2 file as the template.
-> Add a task to open the required HAProxy ports.
-> Create a vars/main.yml file under the lb-tier role directory that contains definitions for the variables defined in the tasks.
-> Create the handlers/main.yml file under the lb-tier role directory that contains a handler to restart services if needed.

-------------------------------------------
$ ansible-galaxy init roles/lb-tier
$ cp ~/roles-setup-files/haproxy.j2 roles/lb-tier/templates/
$ cat << EOF > roles/lb-tier/tasks/main.yml
---
# tasks file for roles/lb-tier
- name: Install Firewalld
  yum:
   name: firewalld
   state: latest


- name: Start firewalld service
  service:
   name: firewalld
   state: started
   enabled: true

- name: Install haproxy
  yum:
   name: "{{ item  }}"
   state: latest
  loop:
   - "{{ haproxy_pkg }}"


- name: Start haproxy
  service:
   name: "{{ haproxy_srv }}"
   enabled: true
   state: started


- name: Copy haproxy template
  template:
   src: haproxy.j2
   dest: /etc/haproxy/haproxy.cfg
  notify:
   - restart_haproxy

- name: Open haproxy port
  firewalld:
   service: http
   state: enabled
   immediate: true
   permanent: true

- name: Open haproxy statistics port
  firewalld:
   port: 5000/tcp
   state: enabled
   immediate: true
   permanent: true
EOF


[devops@bastion ansible_implementation]$ cat << EOF > roles/lb-tier/handlers/main.yml
# handlers file for roles/lb-tier
- name: restart_haproxy
  service:
   name: "{{ haproxy_srv }}"
   enabled: true
   state: restarted
EOF

[devops@bastion ansible_implementation]$ cat << EOF > roles/lb-tier/vars/main.yml
---
# vars file for roles/lb-tier
haproxy_pkg:
 - haproxy
 - firewalld
haproxy_srv: haproxy
EOF

-------------------------------------

3. Create and Execute Main Playbook:
------------------------------------
-> In this section, you create and execute a main playbook to call all of the roles.

-> Create the main playbook to invoke the roles as follows:
-> Execute the lb-tier role on the lb host group servers.
-> Execute the db-tier role on the db host group servers.
-> Execute the app-tier role on the webservers host group servers.

------------------------------------
$ cat << EOF > webapp-main.yml
- hosts: webservers
  become: yes
  roles:
   - app-tier

- hosts: db
  become: yes
  roles:
   - db-tier

- hosts: lb
  become: yes
  roles:
   - lb-tier
EOF
--------------------------------------

-> Execute the main playbook:

	$ ansible-playbook webapp-main.yml

4. Test Playbook
-----------------
-> Open a web browser window and enter the http://frontend1.${GUID}.example.opentlc.com/ URL.

-> When the web page prompts you for the username, enter kiosk.

=========================================================================

Question 1 : What executes before roles in a playbook?
-> pre_tasks 
post_tasks
tasks
includes

Question 2 : When do handlers execute?
Once, at the end of the task
Once, at the end of the playbook
-> Once, at the end of the play
Once, after includes run

Question 3 : What are handlers most often used for?
-> Restarting services
Adding hosts to inventory with add_host
Specifying host variables
Gathering facts

Question 4 : Which of the following describes how roles are used?
-> Roles are a way of automatically loading certain vars_files, tasks, and handlers
Roles are many logical functions for a single virtual server in your inventory
Roles provide a way to associate different playbooks
Roles concatenate multiple inventories

Question 5 : Under a role's tasks directory, main.yml should include which of the following?
A YAML list of dependent roles
A hosts declaration
A YAML dictionary of variables
-> A YAML list of tasks

Question 6 : Which of the following directories must be included in roles that are used by a playbook?
-> tasks
vars
meta
defaults

Question 7 : What is the default sequence for role and playbook task execution?
-> Role tasks execute before playbook tasks
Role tasks execute as post_tasks for playbooks
Playbook tasks execute as pre_tasks before applying role tasks
There is no default and tasks execute in any order they appear

Question 8 : To configure a specific path for Ansible to look for roles, you can set the following in ansible.cfg:
roles_location
-> roles_path
roles_default
roles_dir

Question 9 : What can the meta directory set?
Version of the playbook
Multiple inventories
-> Dependencies on other roles
remote_user

Question 10 : Variables that are declared in a task in the apache role can be used by the web role, if web is executed after apache.
-> TRUE
FALSE

Question 11 : If roles/rolename/vars/main.yml exists, then the following is true:
The variables in the 'defaults' directory are not evaluated
Those variables overrule hostvars
-> Those variables overrule defaults/main.yml in that role
They behave the same as using extra vars on the command line

Question 12 : What is the defined process for creating and using a role?
Ansible automatically creates and uses a role if it is defined in the YAML file
Roles are downloaded from a repository and used only if needed
Roles are created and used in an ad hoc manner
-> Create the role directory structure; define the role content; use the role in a playbook

Question 13 : Using role defaults is least important in terms of variable precedence.
-> TRUE
FALSE

Question 14 : Which best describes the dependency behavior of a role in a playbook?
A role is listed multiple times, if roles_path is set accordingly
-> A role can run multiple times as a dependency if allow_duplicates is set to "true" or "yes"
Roles can be applied only once
A role can be called multiple times if you intend to call that role both before and after the execution of the current role

Question 15 : In a dependencies list, which entry would call the "apache" role with the variable "vhosts=true?"
- { role: apache, when vhosts == true }
- { role: apache, set_var: "{{ vhosts | stdout.true }}" }
-> - { role: apache, vhosts: true }
- { role: apache, when vhosts is defined }

Question 16 : Under which conditions can Ansible Galaxy be used to install roles?
-> From the Ansible community to your playbook directories
To /dev/null
To target machines so that ansible-agent may run them
From Mercurial

Question 17 : Under which condition can you install multiple roles from Galaxy using a file with a list of role names?
Only if role_path is set
-> Only if the file contains role names in the "username.rolename" format
Only as the ansible user
Only if the file is in json format

Question 18 : What occurs when you execute the "ansible-galaxy init newrole1 -p /etc/ansible/roles" command?
It installs a role by the name "newrole1" in your playbook's roles directory
-> It installs a role by the name of "newrole1" at /etc/ansible/roles
It installs a role by the name of "newrole1" in ansible.cfg's roles_path value
It prepopulates the "newrole1" role with task lists included at /etc/ansible/roles

Question 19 : What is Ansible Galaxy?
An Ansible module used to control various cloud providers
-> A collection of community contributed roles
A collection of Ansible supported roles
A collection of inventory plug-ins

======================================================================

Ansible Vault:
--------------

Ansible Vault Overview :
------------------------
Ansible-vault is used to store the sensitive data. this will be an encrypted file. 

-> Options for data values:
	-> Store as variables in group_vars or host_vars
	-> Load by include_vars or vars_files

Data Storage Options:
---------------------
-> Use external key management tool

-> Option 1: Privately deployed tool --> Example: Vault by HashiCorp

-> Option 2: SAAS cloud tool

	-> Amazon Web Services' Key Management Service
	-> Microsoft Azure’s Key Vault

-> Store data alongside playbook
	-> Use Ansible Vault
	-> Built into Ansible

File Types:
-------------
what files can be encrypted. any Ansible structured data file can be done. below are the list
	-> Inventory variables
	-> Variable files included in playbook
	-> Variable files passed as argument during playbook execution
	-> Variables defined in roles

create ansible-vault Files:
-----------------------
To create encrypted file, use ansible-vault 	

$ ansible-vault create secret.yml

  New Vault password: redhat
  Confirm New Vault password: redhat

-> Default: File opens using vim editor
	-> To use different editor, set and import EDITOR
	-> Example: To use nano editor, set nano: export EDITOR=nano

-> Default encryption cipher: Advanced Encryption Standard (AES)
	-> Shared secret-based

create encrypted file using Password File:
------------------------------------------
with help of --vault-password-file we don't need to enter the password. we can just pass the password file to the command. vault-pass.txt is a password file contain password information.

	$ ansible-vault create --vault-password-file=vault-pass.txt secret.yml
	vault-pass.txt
	----------------
	Passw0rd
	----------------

Encrypting a File:
------------------
-> To encrypt existing file, use ansible-vault encrypt FILENAME
-> To encrypt more than one file, enter file names as arguments:

	$ ansible-vault encrypt secret1.yml secret2.yml
	New Vault password: redhat
	Confirm New Vault password: redhat
	Encryption successful

-> To save file with new name, use --output=OUTPUT_FILE
	-> Available for encrypting single file only

Viewing an Encrypted File:
--------------------------
-> To view file, use ansible-vault view FILENAME:

	$ ansible-vault view secret1.yml
	Vault password: secret
	less 458 (POSIX regular expressions)
	Copyright (C) 1984-2012 Mark Nudelman

	less comes with NO WARRANTY, to the extent permitted by law.
	For information about the terms of redistribution,
	see the file named README in the less distribution.
	Homepage: http://www.greenwoodsoftware.com/less
	my_secret: "yJJvPqhsiusmmPPZdnjndkdnYNDjdj782meUZcw"

-> File not opened for editing

Editing an Encrypted File:
--------------------------
-> To edit file, use ansible-vault edit FILENAME:

$ ansible-vault edit secret.yml
Vault password: redhat
Decrypts file to temporary file

-> Edit temporary file and save changes
-> Content copied to encrypted file
-> Temporary file removed

Changing a File Password:
-------------------------
-> To change vault password, use ansible-vault rekey FILENAME
	-> Enter original and new password:

$ ansible-vault rekey secret.yml
Vault password: redhat
New Vault password: RedHat
Confirm New Vault password: RedHat
Rekey successful

-> Can rekey multiple files sharing same password
-> Enter file names as arguments
-> To use password file, supply file name to rekey
-> To do so, use --new-vault-password-file

Decrypting a File:
-------------------
-> To decrypt file, use ansible-vault decrypt FILENAME:

$ ansible-vault decrypt secret1.yml --output=secret1-decrypted.yml
Vault password: redhat
Decryption successful

Playbooks:
----------
-> Playbook can use variables encrypted by Ansible Vault
	-> Variable types:
	Defined in group_vars or host_vars
	Loaded by include_vars or vars_files
	Passed on ansible-playbook with -e @file.yml or -e @file.json
	Defined as role variables and defaults

-> Playbook decrypted in memory while running

Variable Examples:
------------------
-> To run such playbook, specify:

--ask-vault-pass

--vault-password-file:

$ ansible-playbook --ask-vault-pass site.yml
Vault password: redhat
If no password specified, error returned:

[student@demo ~]$ ansible-playbook site.yml
ERROR: A vault password must be specified to decrypt vars/api_key.yml


Password File:
----------------
-> Alternative: Provide file location to decrypt vault
-> File stores password in plain text or using script
-> Password is string stored as single line in file
-> To provide file location, use --vault-password-file=/path/to/vault-password-file:

$ ansible-playbook --vault-password-file=vault-pass site.yml
Other option: Set vault password file as environmental variable

-> To do so, use ANSIBLE_VAULT_PASSWORD_FILE=~/vault-pass

Python Cryptography:
--------------------

-> Default: python-crypto used for encryption/decryption
-> Decrypting multiple files at startup can cause delay
-> To speed up decryption, install python-cryptography:

$ sudo yum install python-cryptography
python-cryptography: Alternative library that provides:

-> Modern interface
-> Improved cryptographic operations
-> If installed, used by default in place of python-crypto

Benefits:
----------
-> Performance issues with other Python-based libraries:
	PyCrypto
	M2Crypto
	PyOpenSSL

-> python-cryptography benefits:
	-> Better algorithm implementation
	-> High-level cryptography for human-readable APIs
	-> Included algorithms (AES-GCM and HKDF)
	-> Stronger community of maintenance for libraries

GCM (Galois Counter Mode) is a mode of operation for block ciphers.

HKDF (HMAC-based Extract-and-Expand Key Derivation Function) is suitable for deriving keys of a fixed size used for other cryptographic operations.

==============================================================
Ansible Vault Lab:
--------------------
-> In this lab, you explore using encryption and decryption of files. Then you use an encrypted file with an Ansible Playbook to store usernames and passwords.

Goals:
------
-> Create and edit an encrypted file
-> View the contents of an encrypted file
-> Change the password of an encrypted file
-> Encrypt and decrypt an existing file
-> Define playbook variables in an encrypted file
-> Create a playbook that uses the encrypted variables file
-> Run a playbook using an encrypted file


LAB-7: Ansible Vault
================================================================

2. Manage Encrypted Files:
--------------------------
-> In this exercise, you create and edit an encrypted file and change the password on an existing encrypted file. You also encrypt and decrypt an existing file.

------------------------------------
2.1. Create and View Encrypted File:
------------------------------------
Create an encrypted file called super-secret.yml under ansible_implementation, entering redhat as the vault password when prompted:

$ ansible-vault create super-secret.yml
Sample Output
New Vault password: redhat
Confirm New Vault password: redhat
----------------------------

This is encrypted.

----------------------------

-> Attempt to view the contents of the encrypted super-secret.yml file:

$ cat super-secret.yml
Sample Output
$ANSIBLE_VAULT;1.1;AES256
30353232636462623438613666393263393238613363333735626661646265376566653765633565
3663386561393538333864306136316265636632386535330a653764616133343630303633323831
33653136313933636633623431646634636661333762393764396135333236316338656338383933
3635646662316335370a363264366138333434626261363465636331333539323734643363326138
34626565353831666333653139323965376335633132313162613838613561396462323037313132
3264386531353862396233323963613139343635323532346538

-> Because super-secret.yml is encrypted, you cannot view the contents in plain text.
-> The default cipher (AES) used to encrypt the file is based on a shared secret.

-> View the content of the encrypted file, entering redhat as the vault password when prompted:

$ ansible-vault view super-secret.yml
Sample Output
Vault password: redhat

This is encrypted.


----------------------------------
2.2. Edit and View Encrypted File:
----------------------------------
-> In this section, you add content to super-secret.yml and then view the file.

-> Edit super-secret.yml, specifying redhat as the vault password when prompted:

$ ansible-vault edit super-secret.yml
	Sample Output
	Vault password: redhat

-> Add the following to the end of the file:

This is also encrypted.

-> Save the file and exit the editor.

-> View the content of super-secret.yml, using redhat as the vault password:

$ ansible-vault view super-secret.yml
	Sample Output
	Vault password: redhat
	This is encrypted.
	This is also encrypted.

------------------------------------
2.3. Change Encrypted File Password:
------------------------------------
-> Change the vault password of the encrypted super-secret.yml file from redhat to ansible:

$ ansible-vault rekey super-secret.yml
Sample Output
Vault password: redhat
New Vault password: ansible
Confirm New Vault password: ansible
Rekey successful

----------------------------------------
2.4. Decrypt and Encrypt Encrypted File:
----------------------------------------

-> Decrypt the encrypted super-secret.yml file and save the file as super-secret-decrypted.yml, using the ansible-vault decrypt subcommand with the --output option and ansible as the vault password:

$ ansible-vault decrypt super-secret.yml --output=super-secret-decrypted.yml
Sample Output
Vault password: ansible
Decryption successful

-> View the contents of the super-secret-decrypted.yml file to verify that it is decrypted:

$ cat super-secret-decrypted.yml
Sample Output
This is encrypted.
This is also encrypted.

-> Encrypt the super-secret-decrypted.yml file and save the file as passwd-encrypted.yml, this time entering redhat as the vault password:

$ ansible-vault encrypt super-secret-decrypted.yml --output=super-secret-encrypted.yml
Sample Output
New Vault password: redhat
Confirm New Vault password: redhat
Encryption successful

3. Use Ansible Vault:
------------------------
In this section, you use Ansible Vault to encrypt a local file containing passwords and use the encrypted version in a playbook to create users on the frontend1.${GUID}.internal remote system.

------------------------------------
3.1. Create Encrypted Variable File:
------------------------------------
-> In this exercise, you create an encrypted file called secret.yml in the ansible_implementation directory. This file defines the password variables and stores the passwords to be used in the playbook. You use an associative array variable called newusers to define two users and passwords with the name variable as ansibleuser1 and ansibleuser2 and the pw variable as redhat and Re4H1T, respectively. You set the vault password to redhat.

-> Make sure that you are in the ansible_implementation directory:

$ cd ~/ansible_implementation

-> Create an encrypted file called secret.yml in ansible_implementation, providing the password redhat for the vault:

$ ansible-vault create secret.yml
Sample Output
New Vault password: redhat
Confirm New Vault password: redhat
---------------------------------
newusers:
  - name: ansibleuser1
    pw: redhat
  - name: ansibleuser2
    pw: Re4H1T
---------------------------------
-> The password is stored as plain text in the pw variable.
-> Save the file and exit the editor.

-------------------------------------------------------
3.2. Create Playbook That Uses Encrypted Variable File:
-------------------------------------------------------
-> In this exercise, you create a playbook that uses the variables defined in the secret.yml encrypted file. You name the playbook create_users.yml and create it under the ansible_implementation directory.

-> You configure the playbook to use the lb host group defined by the lab setup script in the inventory file. Then you run this playbook as the devops user on the remote managed host and configure the playbook to create users based on the newusers associative array. This creates the ansibleuser1 and ansibleuser2 users on the hosts in the lb host group.

-> Create an Ansible Playbook in ansible_implementation/create_users.yml:

$ cat << EOF > create_users.yml
-----------------------------------

---
- name: create user accounts for all our servers
  hosts: lb
  become: True
  remote_user: devops
  vars_files:
    - secret.yml
  tasks:
    - name: Creating users from secret.yml
      user:
        name: "{{ item.name }}"
        password: "{{ item.pw | password_hash('sha512') }}"
      with_items: "{{ newusers }}"
EOF

------------------------------------

-> The password is converted into a password hash that uses the password_hash hashing filters and sha512 algorithm.

-> You use the user module and pass this hashed password as an argument, as shown in this simplified example:

user:
  name: user1
  password: "{{ 'passwordsaresecret' | password_hash('sha512') }}"

-> Perform a syntax check of create_users.yml using ansible-playbook --syntax-check, and include the --ask-vault-pass option to prompt for the vault password set on secret.yml:

$ ansible-playbook --syntax-check --ask-vault-pass create_users.yml
Sample Output
Vault password: redhat

playbook: create_users.yml

-> Resolve any syntax errors before continuing.

-> Create a password file called vault-pass with redhat as the contents and set the permissions of the file to 0600:

$ echo 'redhat' > vault-pass
$ chmod 0600 vault-pass

-> This file is used during playbook execution rather than prompting for a password.

---------------------------------------------------
3.3. Execute Playbook With Encrypted Variable File:
---------------------------------------------------
-> In this section, you execute the Ansible Playbook, using the vault password file to create the ansibleuser1 and ansibleuser2 users on a remote system. The usernames and passwords are stored as variables in the encrypted secret.yml file. You then connect to frontend1.${GUID}.internal via SSH to verify that the playbook executed properly and created both users.

-> Execute the Ansible Playbook, using vault-pass as the vault password:

$ ansible-playbook --vault-password-file=vault-pass create_users.yml

-> Connect to frontend1.${GUID}.internal via SSH first as ansibleuser1 and then as ansibleuser2 to verify that the users were created.

-> For the ansibleuser1 user, use redhat as the password. For the ansibleuser2 user, use Red4H1T as the password.

---------------------------------------------
Question 1 : When it is necessary to store secrets in variables, and what is the appropriate way to secure them?
Rely on user/group security and ACLs
Encrypt the entire playbook using GnuPG
-> Encrypt the secret variables using Ansible Vault
Change the playbook to use var_prompt for all secrets

Question 2 : When calling Ansible from another script, and a vault file is in use, what is the best way to specify the vault password?
Use the --ask-vault-pass option with echo and a pipe to supply the vault password prompt
Supply the password on the Ansible command line with --vault-pass
Decrypt the vault in the script to avoid the prompt
-> Store the password in a temp file and use the --vault-password-file option

Question 3 : Which command displays the contents of a vault-encrypted variable file while still leaving the file encrypted on disk?
Encrypted file contents cannot be viewed
-> ansible-vault view encryptedvars.yml
ansible-vault decrypt encryptedvars.yml
ansible --decrypt-vault encryptedvars.yml

Question 4 : How should a vault-encrypted variable file be referenced from a playbook?
-> Add an include_vars directive to the play
Add an include task to the play
Add an include_encrypted_vars directive to the play
Add a --include-vault directive on the command line

Question 5 : What is the best way to modify a vault-encrypted file?
vi encryptedvars.yml
-> ansible-vault edit encryptedvars.yml
ansible-vault decrypt encryptedvars.yml; vi encryptedvars.yml
Re-create the encrypted file
------------------------------------------
