-----------------------------------------------------------------------------
Ansible installtion & Configuration files :
-----------------------------------------------------------------------------
	/etc/ansible/ansible.cfg 				--> main ansible configuration file
	/etc/ansible/hosts  	 				--> default host inventory file
	/usr/bin/ansible	 				--> ansible binaries are available here
	/usr/lib/python2.7/site-packages/ansible/modulescd  	--> ansible modules are available here
	/etc/ansible/facts.d/custom.fact			--> for defining the custom facts
------------------------------------------------------------------------------
Ansible installation Binaries:
------------------------------------------------------------------------------
	ansible binaries are installed in /usr/bin.
	$ ansible 
	$ ansible-doc
	$ ansible-playbook
	$ ansible-glaxy
	$ ansible-vault
	$ ansible-config
	$ ansible-pull
	$ ansible-console
	$ ansible-inventory

--------------------------------------------------------------------------------
Ansible configuration loading order:
--------------------------------------------------------------------------------
Ansible searches for its config file(ansible.cfg) in below order in system. First file found is used, all others paths ignored.
	
	1st. ANSIBLE_CONFIG (environment variable, if set)
	2nd. ansible.cfg (in current directory)
	3rd. ~/.ansible.cfg (in home directory)
	4th. /etc/ansible/ansible.cfg

---------------------------------------------------------------------------------------------
Inventory file arguments
---------------------------------------------------------------------------------------------
	ansible_connection
	ansible_host
	ansible_port
	ansible_user
	ansible_password
	ansible_ssh_private_key_file
	ansible_become
	ansible_become_user
	ansible_become_method
	ansible_ssh_private_key_file

---------------------------------------------------------------------------------------------
Ansible commands: ansible (-a, -b, -C, -e, -i, -m, -o, -t, -v, -vvv, -k, -s, -u, -U, -K)
---------------------------------------------------------------------------------------------
	-m  			--> module
	-C, --check 		--> check 
	-i 			--> inventory
	-a arguments/instructions
	--list-hosts 
	-o 			--> one line output
	-e 			--> extra vars
	--syntax-check 
	-t, --tree 		--> log output to this directory
	-v, --verbose
	-vvvv 			--> enable debugging
	-s, --sudo 		--> run operations with sudo 
	-b, --become
	-K, --ask-become-pass 
	-u 			--> remote user
	-U 			--> sudo user

----------------------------------------------------
ansible:
----------------------------------------------------
	$ ansible --verison --> to check the ansible version.
 
----------------------------------------------------
ansible-doc:
----------------------------------------------------
	$ ansible-doc -l  --> to list the modules 
	$ ansible-doc -l | more --> to see page by page
	$ ansible-doc -s copy
	$ ansible-doc yum 
	$ ansible-doc aws_s3
  	$ ansible-doc ec2 
   	$ ansible-doc copy

----------------------------------------------------
ansible-inventory:
----------------------------------------------------
	$ ansible-inventory -i inventory/ -y

----------------------------------------------------
ansible-config:
----------------------------------------------------
	$ ansible-config dump |grep -i ROLE 
	$ ansible-config list
	$ ansible-config view

----------------------------------------------------
ansible-playbook:
----------------------------------------------------
	$ ansible-playbook play1.yaml -i hosts 
	$ ansible-playbook play1.yaml --tags "install"
	$ ansible-playbook play1.yaml --skip-tags "upgrade"
	$ ansible-playbook play1.yaml --start-at-task "start httpd server"

----------------------------------------------------
SSH keys:
----------------------------------------------------
	$ ssh -i id_rsa user@hostname

---------------------------------------------------
Ping/Pong status check:
----------------------------------------------------
	$ ansible all -m ping -i inventory						--> ad-hoc command to ping all the severs 
	$ ansible all -m command -a uptime -i inventory 				--> to check server uptime on all inventory hosts
	$ ansible all -m copy -a "src=~/src/file1 dest=~/dest/file1" -i inventory 	--> copy the source file to destination.
	$ ansible localhost -m command -a uptime -i inventory 				--> to check the server uptime on localhost using ansible command

Note: to make the custom inventory file as a default, we can have a copy of the `ansible.cfg` file in home directory. and modify field `#inventory` with new path. so you don't have to use the parameter -i for each command. 

----------------------------------------------------
list host inventory:
----------------------------------------------------
	$ ansible all -m ping -i inventory  	--> to check the ping status for inventory file hosts.
	$ ansible all --list-hosts 		--> to list the hosts
	$ ansible all --list 			--> to list the hosts.

----------------------------------------------------
creating users on worker nodes:
----------------------------------------------------
	$ ansible all -m user -a "user=devops" -i inventory	--> to create new user "devops"
	$ ansible all -m command -a "id -a devops" 		--> to check user "devops" details.

----------------------------------------------------
authorized_key : module - public key 
----------------------------------------------
	$ cat ~/.ssh/id_rsa.pub

to add a public key to remote authorized_keys file. to trust Ansible_master for password less authentication.
	
 	$ ansible all -m authorized-key -a "user=devops  state=present  key='ssh-rsa AAAAB3NzaC1ycQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b
	
to Remove the same key, we can use the same command with belwo option. State=absent and option -b is to become sudo user

	$ ansible all -m authorized_key -a "user=devops state=presnet key='ssh-rsa AAAABfvVQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b

----------------------------------------------------
lineinfile: module:
----------------------------------------------------
 this module check the line present if not we can add. /etc/sudoers is a sudo users list.
 
	$ ansible all -m lineinfile -a "dest=/etc/sudoers state=present line='devops ALL=(ALL) NOPASSWORD: ALL'" -b

	$ ansible all -m command -a "whoami"	--> to check the user at remote host

----------------------------------------------------
copy: module:
----------------------------------------------------
this module is used to copy the file to remote server, if file present it will update else it will create it. 

	$ ansible all -m copy -a "src=/home/devops/test1.txt dest=/home/devops/"
	$ ansible all -m copy -a "content=' this is raj ' dest=~/test1.txt" -i inventory

----------------------------------------------------
inventory
----------------------------------------------------
	[web]
	web1 ansible_host=192.168.11.10 	ansible_user=devops 	ansible_ssh_pass=Password 	ansible_connection=ssh 
	web2 ansible_host=192.168.11.11 	ansible_user=devops 	ansible_ssh_pass=Password 	ansible_connection=ssh
	
	[windows]
	win1 ansible_host=172.168.12.10		ansible_user=win1 	ansible_password=Win1Pass	ansible_connection=winrm
	win2 ansible_host=172.168.12.11		ansible_user=win1 	ansible_password=Win1Pass	ansible_connection=winrm
	
	[db]
	192.168.[1:5].[1:10]  # this means ip addresses 192.168.1.1, 192.168.1.2,....,192.168.1.10 and 192.168.2.1 ...192.168.2.10 and 192.168.3.1 and 192.168.4.1
	
	[webservers:children]
	web
	db
----------------------------------------------------------------------------------------------------

--------------------------------------------------------------------
ansible-playbook:
--------------------------------------------------------------------
this is to check the ansible playbook trial run and check the changes. it will not apply the changes. 

	$ ansible-playbook httpd.yml -i inventory --check 		--> Dry-run the playbook
	$ ansible-playbook httpd.yml --syntax-check -i inventory 	--> this is to check syntax errors in yaml playbook

--------------------------------
```
---
-   name: "task details"
    host: managedhost.example.com
    user: remoteuser
    become: yes
    become_method: sudo
    become_user: root
...
```
--------------------------------

Example: Playbook with Multiple Plays
--------------------------------------------------------------------
```
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
```
--------------------------------------------------------------------

	$ ansible-playbook httpd-play.yaml -i inventory 		--> to run the playbook
	$ ansible-playbook --syntax-check httpd-play.yaml -i inventory 	--> to check the syntax errors.
	$ ansible-playbook httpd-play.yaml -i inventory --step 		--> to exicute step by step task play with user confirmation (yes/no/cancel)

--------------------------------------------------------------------
facts: setup module
--------------------------------------------------------------------
to collect the managed host "web1" facts like OS, version, network info, ip info, and much more\.. etc...
	
 	$ ansible web1 -m setup -i inventory --> to collect facts. 

to disable collecting ansible facts can be done using gather_facts: no
-----------------------------------------------------------------------
```
---
- name: Disable ansible facts
  hosts: large_farm
  gather_facts: no  	# to avoid ansilbe collecting facts.
...
```
(or)  change the values in the ansible.cfg file `/etc/ansible/ansible.cfg`
	
 	gathering = implicit/explicit --> `implicit` it will gather facts | `explicit` it will not gather facts.

(or)

	$ ANSIBLE_GATHERING=explicit ansible-playbook play1 -i inventory  --> command line gather facts disable

--------------------------------------------------------------------
Ansible-vault:
--------------------------------------------------------------------
--ask-vault-pass

--vault-password-file:

	$ ansible-vault create secret.yml	--> to create a new secure file
 
(or)
	
	$ ansible-vault create secret.yml --vault-password-file=./password.txt --> to create a secure file using a password.txt file which contain password

 
password.txt
-----------------------
Passw0rd
-----------------------

$ ansible-vault decrypt secret.yml 	--> to decrypt the secure file
$ ansible-vault encrypt secret.yml	--> to encrypt the existing file
$ ansible-vault edit secret.yml 	--> to edit the encrypted file
$ ansible-vault view secret.yml		--> to view the encrypted file
$ ansible-vault rekey secret.yml	--> to change the password 

$ ansible-vault decrypt super-secret.yml --output=super-secret-decrypted.yml
$ ansible-vault encrypt super-secret-decrypted.yml --output=super-secret-encrypted.yml

vars_files: module
------------------

======================================================================================================
LAB-1:-
======================================================================================================

Ansible Setup and Ad Hoc Command Lab:
In this lab, you set up and configure the Ansible-master server for managing remote hosts. You install the required packages on the Ansible-master server, create a user 
and set up SSH private keys. Then you test connecting to remote hosts. Finally, you run ad hoc commands to manage the remote hosts.

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
You use a "devops" user on the Ansible-Master, and generate an SSH key pair for the user "devops". The "devops" user is used to run all of the Ansible CLI commands 
to manage the remote hosts.

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
====================================================================================================================
