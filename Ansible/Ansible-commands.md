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
	ansible_connection				--> Method of connection to the remote host. Options: ssh, winrm, local, docker, etc.
	ansible_host					--> Hostname or IP address of the remote host.
	ansible_port					--> Port number used for connection. Default SSH port is 22.
	ansible_user					--> Username used for authentication when connecting to the remote host.
	ansible_password				--> Password used for authentication. (Note: Not recommended for security reasons.)
	ansible_ssh_private_key_file			--> Path to the private SSH key file used for authentication.
	ansible_become					--> Enable privilege escalation. Options: yes or no.
	ansible_become_user				--> User account used for privilege escalation.
	ansible_become_method				--> Method used for privilege escalation. Options: sudo, su, pbrun, etc.
	ansible_ssh_private_key_file			--> Path to the private SSH key file used for authentication.

---------------------------------------------------------------------------------------------
Ansible commands: ansible (-a, -b, -C, -e, -i, -m, -o, -t, -v, -vvv, -k, -s, -u, -U, -K)
---------------------------------------------------------------------------------------------
	-m  			--> module
	-C, --check 		--> check 
	-i 			--> inventory
	-a arguments/instructions
	--list-hosts 
 	--list-tags
  	--list-tasks
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
	$ ansible --verison 	--> to check the ansible version.
 			-m	--> module name
    			-i 	--> inventory file
    			-a	--> arguments
       			-
 
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

to add a public key to remote `authorized_keys` file. to trust Ansible_master for password less authentication.
	
 	$ ansible all -m authorized-key -a "user=devops  state=present  key='ssh-rsa AAAAB3NzaC1ycQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b
	
to Remove the same key, we can use the same command with belwo option. `state=absent` and option `-b` is to become sudo user

	$ ansible all -m authorized_key -a "user=devops state=absent key='ssh-rsa AAAABfvVQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b

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

	$ ansible-vault create secret.yml		--> to create a new secure file	
	$ ansible-vault create secret.yml --vault-password-file=./password.txt 		--> to create a secure file using a password.txt file which contain password

password.txt
-----------------------
Passw0rd

	$ ansible-vault decrypt secret.yml 	--> to decrypt the secure file
	$ ansible-vault encrypt secret.yml	--> to encrypt the existing file
	$ ansible-vault edit 	secret.yml 	--> to edit the encrypted file
	$ ansible-vault view 	secret.yml	--> to view the encrypted file
	$ ansible-vault rekey 	secret.yml	--> to change the password 
	
	$ ansible-vault decrypt super-secret.yml --output=super-secret-decrypted.yml
	$ ansible-vault encrypt super-secret-decrypted.yml --output=super-secret-encrypted.yml

vars_files: module
------------------


