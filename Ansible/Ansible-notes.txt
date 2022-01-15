Red Hat Ansible Engine Implementation:-
--------------------------------------

Topics:-
--------
1. Overview :-
--------------

-> Ansible is an Open source configuration management and orchestration utility
-> Automates and standardizes configuration of remote hosts and virtual machines
-> Coordinates launch and shutdown of multitiered applications
-> Performs rolling updates of multiple systems with zero downtime
-> Originally written by Michael DeHaan
-> Creator of Cobbler provisioning application
-> System administrators find it simple to use
-> Developers can learn it easily
-> Built on Python
-> Supported by DevOps tools such as Vagrant and Jenkins

Ansible Limitations:-
---------------------
-> Cannot audit changes made by other users on system
	-> Cannot determine who made change to a file
-> Does not perform initial minimal installation of system
	-> Start with minimal installation via Kickstart or base cloud starter image
	-> Then use Ansible to add packages and do configuration
-> Does not monitor configuration drift
	-> Can remediate it
-> Does not track changes made to files on system
	-> Does not track which user or process made changes
	-> To track changes, use version control system or Linux® Auditing System

2. Architecture:-
-----------------

-> Two types of machines in Ansible architecture: control node and managed hosts
	-> Ansible software installed and maintained on control node
	-> Managed hosts listed in host inventory
	-> Text file on control node with managed host names or IP addresses
-> System administrators log in to control node and launch Ansible
	-> Specify playbook
	-> Specify target host to manage: single system, group of hosts, or wild card
-> SSH used as network transport to communicate with managed hosts
	-> Modules referenced in playbook copied to managed hosts
	-> Modules execute in order with arguments specified in playbook
-> Core modules perform most system administration tasks
	-> Users can write custom modules

Control Node Components:-
------------------------
Ansible configuration:-
	-> Defines how Ansible behaves. Settings include:
		-> Remote user for command execution
		-> Passwords for executing remote commands with sudo
	-> To override default values, use environment variables or values defined in configuration files

Host inventory:-
	-> Defines configuration groups to which hosts belong
	-> Defines how Ansible communicates with managed host
	-> Defines host and group variable values

Core modules:-
	-> Programs copied to managed hosts to perform work for Ansible
	-> Over 400 core modules built in

Custom modules:-
	-> Extend functionality
	-> Typically written in Python
		-> Alternative: Any interpreted programming language
	-> Add custom modules to Ansible library

Playbooks:-
	-> Files written in YAML syntax
	-> Define modules, with arguments, to apply to managed hosts
	-> Declare tasks that need to be performed

Connection plug-ins:-
	-> Enable communication with remote hosts and cloud
	-> Include native SSH (default), Paramiko SSH, and local
		-> Paramiko: Python implementation of OpenSSH for Red Hat Enterprise Linux 5 and 6
	-> Provides ControlPersist performance setting required by Ansible

Plug-ins:- 
	-> Extend Ansible’s functionality
		Examples: Email notifications and logging

Control Node Role:-
------------------
	-> System administrators log in and initiate Ansible operations from control node
	-> Ansible software installed and configuration files maintained on control node
	-> Other names for control node: Ansible host and control machine

Control Node Requirements:-
-------------------------
	-> Must have Python 2.6 or 2.7 installed
	-> Includes Linux, macOS, any BSD-based UNIX system
	-> Windows not currently supported for control node
	-> On Red Hat Enterprise Linux 6 or 7, ansible package and dependencies must be installed

Managed Host Role:-
------------------
	-> Ansible does the following on managed host systems:
		-> Logs in
		-> Installs modules
		-> Executes remote commands for configuration
	-> Other names for managed host: managed node and remote node

Managed Host Requirements:- 
--------------------------
	-> SSH must be installed and configured
		-> Allows incoming connections and communication with managed hosts
	-> Python 2.4 or later
		-> Lets you use Ansible to manage Red Hat Enterprise Linux 5, 6, and 7 hosts
	-> python-simplejson package must be installed on Red Hat Enterprise Linux 5 managed hosts
		-> Not required on Red Hat Enterprise Linux 6 and 7 managed hosts
		-> Python 2.5 and newer versions provide functionality by default

3. Use Cases:-
--------------
-> Configuration management
	-> Deploy and manipulate remote host’s configuration files
	-> Use static files or create files on fly using templates
-> Multi-node deployment tool
	-> Use playbooks to define applications installed and configured on remote machines
	-> Apply playbook to multiple machines, building them in consistent manner
	-> Orchestrate multi-node applications with Ansible rules
-> Remote task execution
	-> Example: Specify ad hoc commands on command line
	-> Causes Ansible to execute commands on remote hosts

4. Deployments:-
---------------
-> Ansible strength: Simplifies software configuration of servers
-> When Ansible accesses managed hosts, it can discover version of Red Hat Enterprise Linux running on remote server
-> Ansible determines if host is properly entitled by comparing installed applications and applied software subscriptions
-> Ansible Playbooks can consistently build development, test, and production servers
	-> Kickstart can get bare-metal servers running
	-> Ansible builds them further
	-> Provision servers to corporate baseline standard or specific role within datacenter

Red Hat JBoss® Middleware:-
---------------------------
-> Ansible can discover Red Hat JBoss Middleware versions and reconcile subscriptions
-> Ansible supports managed hosts running Windows
-> Red Hat JBoss Middleware products can be deployed consistently, regardless of target machine operating systems
-> Ansible can also deploy and manage Red Hat JBoss Middleware applications
-> All Red Hat JBoss Middleware configurations are centrally stored on Ansible control node

Red Hat OpenShift®:-
------------------
-> Ansible can manage software development life cycle for applications deployed into Red Hat OpenShift Container Platform
-> OpenShift Container Platform 3.1 provides:
	-> Ansible software for Red Hat Enterprise Linux
	-> Playbooks for provisioning and managing applications

Red Hat Satellite:-
------------------
-> Ansible can supplement functionality provided by Red Hat Satellite
-> Deploy Satellite agents to existing servers in datacenter
-> Discover and manage software subscriptions on Red Hat Satellite clients
-> Perform post-install configuration of hosts provisioned by Red Hat Satellite

5. Orchestration Methods:-
--------------------------
-> Ansible commonly used to finish provisioning application servers
	-> Example: Write playbook to perform these steps on newly installed base system:
		-> Configure software repositories
		-> Install application
		-> Tune configuration files
		-> (Optional) Download content from version control system
		-> Open required service ports in firewall
		-> Start relevant services
		-> Test application and confirm it is functioning

6. Connection Plug-ins:-
------------------------
-> Connection plug-ins: Allow Ansible to communicate with managed hosts and cloud providers
-> Preferred connection plug-in for newer versions of Ansible is native SSH plug-in, ssh
	-> Default connection method used by Ansible
		-> If OpenSSH on control node supports ControlPersist option
-> Ansible supports passwords for SSH authentication
	-> Most common practice: Use SSH user keys to access managed hosts

local:-
-------
-> local: Another connection plug-in for Linux applications
-> Use to manage Ansible control node locally, without SSH
Common uses:
	-> When writing playbooks that interface with cloud services or other API
	-> When Ansible is invoked locally by cron job

paramiko and ControlPersist:
----------------------------
-> paramiko: Connection plug-in used on Red Hat Enterprise Linux 5 and 6 machines
	-> Paramiko SSH is Python-based OpenSSH implementation that implements persistent SSH connections
	-> Connection solution for older systems using versions of OpenSSH that do not implement ControlPersist
-> ControlPersist allows for persistent SSH connections
	-> Improves Ansible performance
	-> Eliminates SSH connection overhead when multiple SSH commands execute in succession
winrm and docker:-
------------------
-> winrm: Allows Microsoft Windows machines to be managed hosts
	-> pywinrm Python module must be installed on Linux control node to support winrm
-> docker: Allows Ansible to treat Docker containers as managed hosts without using SSH
	->Introduced in Ansible 2

7. Ansible Configuration:-
--------------------------
Configuration File:-
	-> Settings in Ansible adjustable via configuration file (ansible.cfg)
	-> Default configuration file, /etc/ansible/ansible.cfg, sufficient for most users
		-> There may be reasons to change it
Environment Variables:-
-> Ansible also allows configuration of settings using environment variables
	-> If set, they override settings loaded from configuration file
Command Line Options:
-> Not all configuration options available via command line, just those deemed most useful or common
-> Settings in command line override those passed through configuration file and environment

Ansible Configuration Settings:-
--------------------------------
-> ansible-config utility allows users to see all available configuration settings, their defaults, how to set them, and where current values come from
-> Changes can be made in configuration file
-> Ansible searches for file to use in this order:
	-> ANSIBLE_CONFIG (environment variable, if set)
	-> ansible.cfg (in current directory)
	-> ~/.ansible.cfg (in home directory)
	-> /etc/ansible/ansible.cfg
-> First file found is used, all others ignored

8. Prerequisites:-
------------------
Control Node:-
--------------
-> Ansible uses agentless architecture
	-> Differs from other configuration management utilities like Puppet, Chef
-> Software installs on control node
	-> Few steps
	-> Only requirement: Python version 2.6 or later
	-> To check installed Python version:
		[root@controlnode ~]# yum list python
		Loaded plugins: langpacks, search-disabled-repos
		Installed Packages	
		python.x86_64	2.7.5-34.el7	installed
-> Ansible currently not included in Red Hat Enterprise Linux
-> For installation instructions and other information: https://www.ansible.com/get-started

Managed Hosts:-
---------------
-> No special Ansible agent needed
-> Require Python 2.4 or later
-> Python prior to 2.5, also requires python-simplejson
-> Control node communicates with managed hosts over network
	-> Multiple options available
	-> SSH connection used by default
-> Ansible normally connects to managed hosts using same username running Ansible on control node
-> SSH sessions require authentication at initiation of each connection
	-> Password authentication for each connection becomes unwieldy as number of managed hosts increases
	-> Key-based authentication preferable in enterprise environments

SSH Key-Based Authentication:-
------------------------------
-> To authenticate ssh logins without password, use public key authentication
-> ssh lets users authenticate using private/public key scheme
	-> Two keys generated: private and public
-> Private key file used as authentication credential
	-> Must be kept secret and secure
-> Public key copied to systems user wants to log in to
	-> Used to verify private key
	-> Does not need to be secret
-> SSH server with public key issues challenge
	-> System with private key answers
	-> Possession of private key used to complete authentication

ssh-keygen:-
-------------
-> To generate keys, use ssh-keygen
	-> Private key: ~/.ssh/id_rsa
	-> Public key: ~/.ssh/id_rsa.pub
-> Default: SSH keys stored in .ssh/ directory of user’s home directory
-> File permissions on private key allow:
	-> Read/write access to user who owns file
	-> Octal 0600
-> File permissions on public key allow:
	-> All system users read access
	-> Only file owner write access
	-> Octal 0644

ssh-copy-id:-
-------------
-> Before using key-based authentication, need to copy public key to destination system
-> To do this, use ssh-copy-id:
	[student@controlnode ~]$ ssh-copy-id student@managedhost

-> After copying key, use key-based authentication to authenticate SSH connections to host

9. Modules:-
------------
To see modules available on control node, run ansible-doc with -l option

-> Use modules to perform operations on managed hosts
	-> Ready-to-use tools for specific tasks
	-> Run from command line or use in playbooks
	-> Copied to and run from managed host
-> Over 200 prepackaged modules
	-> Let you perform wide range of tasks
	-> Examples: Cloud, user, package, service management

Module Type: -
--------------

Core modules:-
--------------
-> Included with Ansible
-> Written and maintained by Ansible Engineering Team
-> Integral to basic foundations of Ansible distribution
-> Used for common tasks
-> Always available

Network modules:-
-----------------
-> Currently included with Ansible
-> Written and maintained by Ansible Network Team
-> If categorized as Certified or Community, not maintained by Ansible

Certified modules:-
-------------------
-> Part of a future planned program currently in development

Community modules:-
-------------------
-> Included as a convenience
-> Submitted and maintained by Ansible community
-> Not maintained by Ansible
-> Included as a convenience

Use of Categories: Documentation and Organization:-
---------------------------------------------------
-> Module documentation indexed by category on Ansible documentation website
-> Helps in searching for module for specific task
-> Module storage on Ansible control node organized by categories
-> Modules installed under /usr/lib/python2.7/site-packages/ansible/modules
-> Core and extra modules housed under separate directories
-> Modules within directories organized into subdirectories by category

Module Categories:-
-------------------
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

-> Modules avaibale in Control node locally
	[student@controlnode modules]$ pwd
	/usr/lib/python2.7/site-packages/ansible/modules
	[student@controlnode modules]$ tree -d

-> To display documentation on specific module, pass module name to ansible-doc 
	[student@workstation modules]$ ansible-doc yum

-> To display sinapsis 
	[student@workstation modules]$ ansible-doc -s yum

Methods to Invoke Modules:-
---------------------------
-> To call modules as part of ad hoc command, use ansible
	-m specifies which module to use
	Example: Use ping to test connectivity to all managed hosts:
	[student@controlnode ~]$ ansible -m ping all
-> Can call modules in playbooks as part of task
	Example: Invoke yum module
	Arguments: Package name and desired state:	
	tasks:
  		- name: Installs a package
  		  yum:
    		  name: Postfix
      		  state: latest
-> To call modules from Python scripts, use Ansible Python API
	-> Not supported in case of failures
	-> Can import API into application to leverage Ansible system deployment and configuration

10. Ad Hoc Commands:-
---------------------
-> Ansible lets you run on-demand tasks on managed hosts
-> Ad hoc commands: Most basic operations you can perform
-> To perform ad hoc commands, run ansible on control node
-> As part of command, specify operation to perform
-> Each command can perform only one operation
-> Multiple operations require series of commands

Benefits:-
----------
-> Easy way for administrators to get started using Ansible
-> Introduce advanced Ansible features: modules, tasks, plays, playbooks
-> Quickly make configuration changes to large number of managed hosts
-> Perform noninvasive tasks

Syntax:-
--------
-> For ad hoc commands, run ansible as follows:
	ansible <host-pattern> -m module [-a module arguments] [-i inventory]

-> Host pattern defines list of managed hosts on which Ansible performs command
-> List of managed hosts determined by applying host pattern against default inventory file
	-> Located at /etc/ansible/hosts
-> To specify alternative inventory file location, use -i
-> Control node can include itself as managed host
-> To define control node as managed host, add control node name, its IP address, localhost name, or IP address 127.0.0.1 to inventory

Modules and Arguments:-
-----------------------
-> -m indicates module to use to perform remote operation
	Module: Tool designed to accomplish specific task
-> Arguments passed to module using -a
	-> Some modules cannot accept arguments
	-> Others accept multiple arguments
-> If no argument needed, omit -a
-> If multiple arguments needed, enter as single-quoted, space-separated list:
	-> ansible host pattern -m module -a 'argument1 argument2' [-i inventory]

Default Module:-
----------------
-> To define default module, use module_name setting under defaults section of /etc/ansible/ansible.cfg:
	# default module name for /usr/bin/ansible
	#module_name = command
-> Some Ansible configuration settings are predefined internally and have values set
-> Applies even if settings commented out in configuration file
-> module_name predefined with command module as default

Using Predefined Module:-
-------------------------
-> When -m omitted, Ansible:
	-> Consults configuration file
	-> Uses module defined there
-> If no modules defined, predefined command module used
	Result: Following commands are technically equivalent:
	$ ansible host pattern -m command -a module arguments
	$ ansible host pattern -a module arguments

Module: command :-
-----------------
-> Lets you run command on managed hosts
-> Command specified by arguments following -a
	Example: Run hostname on managed hosts referenced by mymanagedhosts host pattern:

	[student@controlnode ~]$ ansible mymanagedhosts -m command -a /usr/bin/hostname
	host1.lab.example.com | SUCCESS | rc=0 >>
	host1.lab.example.com
	host2.lab.example.com | SUCCESS | rc=0 >>
	host2.lab.example.com

-o Option:
----------
-> Previous example returned two lines of output for each managed host
-> First line is status report showing:
	-> Managed host on which operation was performed
	-> Outcome of operation
-> Second line is output of remotely run command
-> -o option generates just one line of output for each operation performed:
	[student@controlnode ~]$ ansible mymanagedhosts -m command -a /usr/bin/hostname -o
	host1.lab.example.com | SUCCESS | rc=0 >> (stdout) host1.lab.example.com
	host2.lab.example.com | SUCCESS | rc=0 >> (stdout) host2.lab.example.com
-> Offers better readability and parsing of command output

Module: Shell :-
----------------
-> command module lets you quickly run remote commands on managed hosts
-> Not processed by shell on managed hosts
-> Cannot access shell environment variables
-> Cannot perform shell operations
-> To run commands that require shell processing, use shell module
-> Pass commands to run as arguments to module
-> Ansible runs command remotely
-> shell commands processed through shell
-> Can use shell environment variables
-> Can perform shell operations

Ad Hoc Command Configuration:-
------------------------------
-> When running ad hoc command, things occur in background
-> Configuration file (/etc/ansible/ansible.cfg) consulted for parameters
	Example: module_name parameter
-> Other parameters determine how to connect to managed hosts

Connection Settings:-
---------------------
-> After reading parameters, Ansible makes connections to managed host
-> Default: Connections initiated with SSH
	-> Requires connection established using account on managed host
	-> Account referred to as remote user
	-> Defined by remote_user setting under [defaults] section in /etc/ansible/ansible.cfg:
		# default user to use for playbooks if user is not specified
		# (/usr/bin/ansible will use current user as default)
		#remote_user = root

Remote Operations:-
-------------------
-> Default: remote_user parameter commented out in /etc/ansible/ansible.cfg
-> With parameter undefined, commands connect to managed hosts using same remote user account as one on control node running command
-> After making SSH connection to managed host, specified module performs operation
-> After operation completed, output displayed on control node
-> Operation restricted by limits on permissions of remote user who initiated it

Privilege Escalation:-
----------------------
-> After connecting to managed host, Ansible can switch to another user before executing operation
-> Example: Using sudo, can run ad hoc command with root privilege
	-> Only if connection to managed host authenticated by nonprivileged remote user
	-> Settings to enable privilege escalation located under [privilege_escalation] section of ansible.cfg:
		#become=True
		#become_method=sudo
		#become_user=root
		#become_ask_pass=False

Enabling Privilege Escalation:-
-------------------------------
-> Privilege escalation not enabled by default
-> To enable, uncomment become parameter and define as True:
	become=True
-> Enabling privilege escalation makes become_method, become_user, and become_ask_pass parameters available
-> Applies even if commented out in /etc/ansible/ansible.cfg
-> Predefined internally within Ansible
-> Predefined values:
	become_method=sudo
	become_user=root
	become_ask_pass=False

Command Line Options:-
-----------------------
-> Configure settings for remote host connections and privilege escalation in /etc/ansible/ansible.cfg
-> Alternative: Define using options in ad hoc commands
-> Command line options take precedence over configuration file settings
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

Ad Hoc Commands:-
-----------------
-> Use modules to perform operations on managed hosts with ad hoc commands
-> Useful for simple operations
-> Not suited for complex configuration or orchestration scenarios
-> Ad hoc commands invoke one module and one set of arguments at a time
-> Multiple operations must be executed over multiple commands

===============================================================================================================
LAB-1:-
---------

Ansible Setup and Ad Hoc Command Lab:-
--------------------------------------
In this lab, you set up and configure the Ansible Controller server for managing remote hosts. You install the required packages on the Controller server, create a user, and set up SSH private keys. Then you test connecting to remote hosts. Finally, you run ad hoc commands to manage the remote hosts.

Goals:-
--------
	-> Install Red Hat Ansible Engine
	-> Create a user on the remote hosts
	-> Test connectivity to the remote hosts
	-> Explore ad hoc commands

1. Connect to Environment:-
---------------------------
-> Connect to an ansible controller host using ssh command 
	
	$ ssh <username>@<hostname>
	  Enter the password: 

2. Configure Ansible Controller:-
---------------------------------
You use a "devops" user on the Ansible Controller, and generate an SSH key pair for the user "devops". The "devops" user is used to run all of the Ansible CLI commands to manage the remote hosts.

2.1. Install Ansible:-
----------------------
-> Install ansible on Linux machine as below

	$ sudo yum/dnf install ansible --> Linux based OS
	$ sudo pip install ansible --> Non yum based OS
	$ sudo apt-get install ansible --> Debian/Ubuntu based OS

2.2. Generate SSH Key Pair:-
----------------------------
-> Generate an SSH key pair for the devops user
	
	$ ssh-keygen -N '' -f ~/.ssh/id_rsa

-> Verify that the SSH key was successfully created
	
	$ ls -ltr ~/.ssh

3. Set Up Remote Hosts:-
------------------------
3.1. Explore Environment:-
--------------------------
In this section, you set up the remote hosts. 
You create the "devops" user on all of the remote hosts and copy its public key to each host.

-> As the devops user, explore the remote hosts in control node:

	$ ansible all --list-hosts
	(or)
	$ ansible all --list

-> To test the connectivity with remote host using ping module
	
	$ ansible -m ping all
	(or)
	$ ansible all -m ping

3.2. Create User and Set Up SSH Keys for Remote Host:-
------------------------------------------------------
In this section, you create the user and set up the SSH keys for the devops user on the remote hosts.

-> Create the devops user on the remote hosts using the Ansible user module

	$ ansible all -m user -a "name=devops" -b 
	(or)
	$ ansible -m user -a "name=devops" -b all

-> Display the SSH public key for the devops user
	
	$ cat ~/.ssh/id_rsa.pub

-> To Add the SSH key to the authorized keys for the devops user, making sure to replace the value of the SSH public key with the one that you just displayed

	$ ansible all -m authorized_key -a "user=devops state=present key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiR9HQUu8OUr7k8oe+odfvVQgdMNVsHM+dV0oNQnqG+Unv5PSf7GVkp1JwCroF4wIdjKKvEJ8qJqAbxoY3gEcfrSTR9e9p3zeydHIY2svENGmSNjlX28tMe9uisA9KfIEqe013MuIsplGV7YhXAV0YyCCuJ+OMDr+iEmsmVTza/MLzd9iQxYffLwrV+yY+VUilpS12ns/gmDR8ijO5b0sxdHk8Umk77h8Q1bXE8gyue3cnc1c9Sdzpm4UVNhp9ZcqZCqepUBQOszEvllWxrIw+mktzMdn8INgYhiUBzFQxS/92Qh9prB33F3TdOjin4d/Z/tV2lsNN8HVexXswmoF3 devops@bastion.0926.internal'" -b 

-> To Remove the SSH key from authorized_key file use change the state=present to state=removed/absent which will remove the entry from the file.

	$ ansible all -m authorized_key -a "user=devops state=absent key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiR9HQUu8OUr7k8oe+odfvVQgdMNVsHM+dV0oNQnqG+Unv5PSf7GVkp1JwCroF4wIdjKKvEJ8qJqAbxoY3gEcfrSTR9e9p3zeydHIY2svENGmSNjlX28tMe9uisA9KfIEqe013MuIsplGV7YhXAV0YyCCuJ+OMDr+iEmsmVTza/MLzd9iQxYffLwrV+yY+VUilpS12ns/gmDR8ijO5b0sxdHk8Umk77h8Q1bXE8gyue3cnc1c9Sdzpm4UVNhp9ZcqZCqepUBQOszEvllWxrIw+mktzMdn8INgYhiUBzFQxS/92Qh9prB33F3TdOjin4d/Z/tV2lsNN8HVexXswmoF3 devops@bastion.0926.internal'" -b

-> The contents of /home/devops/.ssh/id_rsa.pub is used as the value of the parameter "key" for "authorized_key" Ansible module.

-> Configure sudo on the remote host for privileged escalation for the "devops" user
	
	$ ansible all -m lineinfile -a "dest=/etc/sudoers state=present line='devops ALL=(ALL) NOPASSWD: ALL'" -b

-> Verify the connection to the remote hosts from bastion as the devops user, starting with the app1 server

	$ export GUID=`hostname | awk -F"." '{print $2}'`

	$ ssh <hostname>
	(or)
	$ ssh devops@appdb1.0926.internal

4. Explore Ad Hoc Commands:-
----------------------------
-> After you have successfully configured the Ansible Controller and remote hosts, you can run Ansible ad hoc commands and playbooks as the "devops" user from "Ansible Controller Machine" without being prompted for the password.

-> In this section, you explore ad hoc commands to manage remote hosts.

-> You configure ansible.cfg and the static inventory needed to complete this lab. You use " -u " to specify the " devops " user and "--private-key" to specify the private key.

1. Verify remote user:
	
	$ ansible frontends -a whoami

The command is expected to show "ec2-user" because it is using the default ansible.cfg and the SSH keys defined in the default /etc/ansible/hosts static inventory.

2. Create a directory called "ansible_implementation" as your working directory for all future labs and an "ansible.cfg" file with a [defaults] section for specifying user-specific settings

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

6. Execute an ad hoc command on localhost to identify the user account used by Ansible to perform operations on managed hosts:
		
	$ ansible localhost -m command -a 'id'

7. Execute an ad hoc command to display the contents of the /etc/motd file on app1.${GUID}.internal as the devops user
	
	$ ansible all -m command -a "cat /etc/motd" 

8. Execute an ad hoc command using the copy module and the devops account to change the contents of the /etc/motd file to include the message "Managed by Ansible" on all of the remote hosts	

	$ ansible all -m copy -a 'content="Managed by Ansible \n" dest=/etc/motd'
Error: Expect the ad hoc command to fail due to insufficient permissions

9. Create the /etc/motd file on all of the hosts, but this time, escalate the root user’s privileges using -b or --become

	$ ansible all -m copy -a 'content="Managed by Ansible\n" dest=/etc/motd' -b

10. Execute an ad hoc command to verify the changes to /etc/motd on all of the remote hosts

	$ ansible all -m command -a 'cat /etc/motd' --become

===================================================================================================================
Your First Playbook:-
---------------------

Topics:
--------

Inventories:-
-------------
-> Host inventory defines hosts managed by Ansible
-> Hosts may belong to groups
	-> Typically used to identify host’s role in datacenter
	-> Host can be member of more than one group
-> Two ways to define host inventories:
	-> Static host inventory defined by text file
	-> Dynamic host inventory generated from outside providers

1.Static Host Inventory:-
--------------------------
-> Static host inventory defined in INI-like text file
-> Each section in file defines a host group
	-> Starts with host group name enclosed in brackets: [hostgroupname]
	-> Lists host entries
		-> One line for each managed host
		-> Entries are host names or IP addresses
-> Host entries define how Ansible communicates with managed host
	-> Include transport and user account information
-> Default location for host inventory file: /etc/ansible/hosts
-> ansible* commands use different host inventory file when used with --inventory PATHNAME
	-> -i PATHNAME for short

Example:-
----------
-> Host inventory defines two host groups: webservers and db-servers
-> SSH on web2.example.com configured to listen on port 1234
-> Ansible must log in to host as ftaylor

	[webservers]
	localhost 				ansible_connection=local
	web1.example.com
	web2.example.com:1234 	ansible_connection=ssh ansible_user=ftaylor
	192.168.3.7

	[db-servers]
	web1.example.com
	db1.example.com

Groups of Groups:-
-------------------
-> Host inventories can include groups of host groups
-> To do this, use :children suffix
-> Example: Create new group nwcapitols that includes all hosts from olympia and salem groups

	[olympia]
	washington1.example.com
	washington2.example.com
	[salem]
	oregon01.example.com
	oregon02.example.com
	[nwcapitols:children]
	olympia
	salem

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
-> Specify values for variables used by playbooks in host inventory files
	-> To specify variable values for individual host, append them at end of host line in inventory
	-> To specify values for group of hosts, declare them in stanza with :vars suffix

-> Example: Defines two group-level variable values, http_port and maxRequestsPerChild, for webservers group
	-> Value of http_port is set to 8080 for web2.example.com:
	
	[webservers]
	web1.example.com
	web2.example.com:1234 http_port=8080

	[webservers:vars] #variables defined for group "webservers" are defined here
	http_port=80 maxRequestsPerChild=500

	[db-servers]
	web1.example.com
	db1.example.com

2. Dynamic Host Inventory:-
---------------------------

-> Host inventory information can be dynamically generated
-> Sources for dynamic inventory information include
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
-> Ansible Playbooks written in YAML language
-> Need understanding of YAML syntax basics
-> YAML designed to represent data structures in easy-to-write, human-readable format
	Examples: Lists, associative arrays
-> Abandons enclosure syntax used to structure data hierarchy in other languages
	Examples: Brackets, braces, open/close tags
-> Uses outline indentation to maintain data hierarchy structures

YAML File Syntax:-
-------------------
-> Optional document markers:
	-> Start of document: ---
	-> End of document: ...
-> Data structures represented in outline format
	-> Space characters used for indentation
-> Indentation rules:
	-> Elements at same level in hierarchy must have same indentation
	-> Child elements must be indented further than parents
	-> No rules about exact number of spaces to use
-> Optional: Insert blank lines for readability

Example: YAML File
-------------------
---
title: 		My book
author:
    first_name:	John
    last_name:	Doe

publish_date: 	2016-01-01

chapters:
    - number:	1
      title:	Chapter 1 Title
      pages:	10

    - number:	1
      title:	Chapter 2 Title
      pages:	10

...	
---------------------

YAML in Playbooks:-
-------------------
-> Ansible Playbooks: YAML files written in list format
-> List items are key/value pairs
	Optional:
	Initiate playbook with --- marker
	Terminate playbooks with ... marker
-> Lack of markers does not affect playbook execution

Example:

--- # My first playbook
...output omitted...
...

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

Dictionaries:-
--------------
-> Other names for key/value data pair: Dictionary, hash, associative array
-> To separate keys from values, use : followed by space:
	keys: value

-> Dictionaries commonly expressed in indented block format:
	---
  	name: Automation using Ansible
  	code: DO407

-> Optional: Express dictionaries in inline block format
-> Enclose multiple key/value pairs between curly brackets
-> Separate pairs with , followed by space:
	---
  	{name: Automation using Ansible, code: DO407}

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

YAML Lint:
-----------
-> Online YAML syntax verification tools available
-> Useful for administrators not familiar with Python
	Example: YAML Lint website: http://yamllint.com/
-> Copy and paste playbook’s YAML contents into form on home page
-> Submit form

--syntax-check :
----------------
-> Ansible offers native feature for validating playbook YAML syntax
-> Use --syntax-check option with ansible-playbook command to check for syntax errors
-> --syntax-check method:
	-> Conducts more rigorous review
	-> Ensures data elements specific to playbooks are not missing
	-> Recommended for verifying playbook YAML syntax

Example:
--------
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
