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
user:
----------------------------------------------------
	$ ansible all -m user -a "user=devops" -i inventory	--> to create new user "devops"
	$ ansible all -m command -a "id -a devops" 		--> to check user "devops" details.

----------------------------------------------------
authorized_key:
----------------------------------------------
	$ cat ~/.ssh/id_rsa.pub

to add a public key to remote `authorized_keys` file. to trust Ansible_master for password less authentication.
	
 	$ ansible all -m authorized-key -a "user=devops  state=present  key='ssh-rsa AAAAB3NzaC1ycQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b
	
to Remove the same key, we can use the same command with belwo option. `state=absent` and option `-b` is to become sudo user

	$ ansible all -m authorized_key -a "user=devops state=absent key='ssh-rsa AAAABfvVQgdMNVsHM+dV0oNQnqG+ devops@bastion.0926.internal'" -b

----------------------------------------------------
lineinfile:
----------------------------------------------------
 this module check the line present if not we can add. /etc/sudoers is a sudo users list.
 
	$ ansible all -m lineinfile -a "dest=/etc/sudoers state=present line='devops ALL=(ALL) NOPASSWORD: ALL'" -b

	$ ansible all -m command -a "whoami"	--> to check the user at remote host

----------------------------------------------------
copy: 
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
ansible facts:
--------------------------------------------------------------------
To collect facts for managed host "web1" facts like OS, version, network info, ip info, and much more\.. etc...
	
 	$ ansible -m setup -i inventory web1				--> to collect facts. 

Note:  to disable collecting ansible facts can be done using gather_facts: no

```
---
- name: Disable ansible facts
  hosts: large_farm
  gather_facts: no  	# to avoid ansilbe collecting facts.
...
```

(or)  change the values in the ansible.cfg file `/etc/ansible/ansible.cfg`
	
 	gathering = implicit/explicit --> `implicit` it will gather facts | `explicit` it will not gather facts.

(or)  using ansible environment variables `ANSIBLE_GATHERING` variable

 	$ ANSIBLE_GATHERING=explicit ansible-playbook play1 -i inventory  --> command line gather facts disable

--------------------------------------------------------------------
Variables:
--------------------------------------------------------------------
Ansible variables are declared in multipule loctions

	1. vars					--> direct in script
 	2. vars_file / include_vars		--> File as an input
  	3. vars_prompt				--> enter values dynamically during the exicution.
   	4. register				--> register output to a variable in YAML file.
    	5. -e / --extra-vars			--> command line variables
     	6. inventory				--> define vars in the inventory file using [web:vars] etc.
      	7. facts				--> define variables as custom facts and add to managed host in "/etc/ansible/facts.d" with file name "custom.facts"

1. vars
------------------------
defined in the playbook using vars sections
```
---
- name: variables						# vars
  hosts: all
  vars:
    home_path: /home/users
    users:
      rama:
        name: sri rama
        home: "{{ home_path }}/rama"
      seetha:
	name: seetha devi
        home: "{{ home_path }}/seetha"
```

2. vars_file / include_vars
-------------------------------
we can call the `vars.yaml` file in the playbook using `vars_file` / `include_vars` 
```
---
- name: variables						# vars_file
  hosts: all
  vars_file:
    - /root/vars.yml
```
(or)
```
---
- name: variables						# include_vars
  hosts: all
  include_vars:
    - /root/vars.yml
```

3. vars_prompt
------------------------------
To get input from end user during the execution
```
---
- name: dynamic inputs						# vars_prompt
  hosts: all
  vars_prompt:
    - name: "new_user"
      prompt: "User to create"
```

4. register
------------------------------
To register a ansible tasks output to a variable called `register`
```
---
- name: testing register					# register
  hosts: all
  tasks:
    - name: install httpd
      apt: name=apache2 state=latest
      register: out_httpd
    - name: print
      debug:
        msg: SUCCESS
        when: out_httpd.rc == 0
```

	stdout: 	Contains the standard output of the command.
	stderr: 	Contains the standard error output of the command.
	stdout_lines: 	Contains the standard output split into a list of lines.
	stderr_lines: 	Contains the standard error output split into a list of lines.
	stdout_json: 	Contains the standard output parsed as JSON (if possible).
	changed: 	Indicates whether the task made any changes on the target system (true or false).
	failed: 	Indicates whether the task failed (true or false).
	msg: 		Contains a human-readable message describing the outcome of the task.
	rc: 		Contains the return code of the command.

5. -e / --extra-vars
-------------------------------------
To pass the variables as an input during execution use the -e / --extra-vars option.

	$ ansible-playbook your_playbook.yml --extra-vars "users={'rama': {'name': 'sri rama', 'home': '/home/users/rama'}, 'seetha': {'name': 'seetha devi', 'home': '/home/users/seetha'}}"

6. inventory
----------------------------
To pass the varialbes as an inventory file, 
```
[web]								# inventory
web1 ansible_host=192.168.1.11
web2 ansible_host=192.168.1.10

[web:vars]
home_path=/home/users
users:
  - rama
  - seetha

[all:vars]
ansible_user=devops

```

7. facts
-----------------------------
ansible facts are the custom facts that are defined in `/etc/ansible/facts.d` in managed hosts using file extention `custom.facts`. this will be used in the playbook. these facts are pushed using the playbook using `copy` moduels to the respective managed hosts. 

8. include
------------------------------
The include directive in Ansible allows you to include external YAML files, tasks, or even other playbooks within your main playbook.

```
---
- name: install							# include
  hosts: all
  tasks:
   - name: include file
     include: /root/install.yml

```

```
vars.yaml
-----------------------------------
package:
- apache2
- nginx
- redis
- mangodb
-----------------------------------
- name: install                            			# include_vars
  hosts: all
  tasks:
  - include_vars:
      file: /root/vars.yaml
      name: package
  - include_tasks:
      file: /root/install.yaml
      name: Install
      
  - name: install package
    apt: name="{{ item }}" state=latest
    loop: "{{ package.package }}"
```
-----------------------------------------------------
```
--- 
- name: Install                             			# include_tasks
  hosts: all
  tasks:
  - include_tasks: /root/install-db.yaml
  - include_tasks: /root/install-app.yaml
  - include_tasks: /root/install_web.yaml
  - include_tasks: /root/start-service_db.yaml
```  

--------------------------------------------------------------------
Loop
--------------------------------------------------------------------
using `loop` is a generic directive that replaces `with_items` other looping directives.
```
---
- name: looping							#  loop
  hosts: all
  tasks:
    - name: install packages
      yum:
        name: "{{ item }}"
        state: present
      loop:
         - httpd
         - nginx
```

```
- user:
    name: {{ item.name }}
    state: present
    groups: {{ item.groups }}
  loop:
    - { name: 'jane', groups: 'wheel' }
    - { name: 'joe', groups: 'root' }
```

```
vars:
  mail_services:
    - postfix
    - dovecot

tasks:
  - yum:
      name: "{{ item }}"
      state: latest
    loop: "{{ mail_services }}"
```

--------------------------------------------------------------------
with_items
--------------------------------------------------------------------
This directive is used to loop over a list of items. It's one of the older looping directives in Ansible and is still widely used, especially in older playbooks.
```
- name: Install packages					# with_items
  apt:
    name: "{{ item }}"
    state: latest
  with_items:
    - vim
    - git
    - curl
```

--------------------------------------------------------------------
until
--------------------------------------------------------------------
The until directive is used to retry a task until a certain condition is met.
```
- name: Wait for a service to start				# until
  command: /usr/bin/foo --check
  register: result
  retries: 5
  until: result.stdout == "Service started"

```

--------------------------------------------------------------------
when
--------------------------------------------------------------------
```
---
- name: install list of packages on Debian                      # When
  hosts: all
  vars:
     list:
     - firewalld
     - apache2
     - nginx
  tasks:
   - name: install list on Ubuntu
     yum: 
        name: "{{ item }}" 
        state: latest
     when: ansible_os_family == "Ubuntu"
     loop: "{{ list }}"
   - name: install list on Debian
     apt: 
        name: "{{ item }}" 
        state:  latest
     when: ansible_os_family == "Debian"
     loop: "{{ list }}"
```

--------------------------------------------------------------------
Error Handling:
--------------------------------------------------------------------
There are list of directives avaiable in  ansible

Global Level:
 	
  	1. any_error_fatal
  	2. max_fail_percentage

Tasks Level:

    	3. ignore_errors
    	4. failed_when
     	5. block/rescue/always

Stop the playbook on all servers, if any once task failed on the play on any of the servers.
```
---
- name: install                 			#  any_error_fatal
  hosts: all
  any_error_fatal: true
  tasks:
```

--------------------------------------------------
if more than 30% servers are failed then quit the play 
```
---
- name: install                 			# max_fail_percentage
  hosts: all
  max_fail_percentage: 30
  tasks:
 ```
 
---------------------------------------------------
To ignore errors for a task we can use this `ignore_errors`, so the task is igonred if fail/pass.
```
---
- name: install                 			#   ignore_errors
  hosts: all
  tasks:
  - name: install 
    apt: name=apache2 state=latest
  - mail: 
      to: 
      subject:
      body:
    ignore_errors: true
```
  
---------------------------------------------------
if errors found in the server log, we can make the playbook fail. 
```
---
- name: install						# failed_when
  hosts: all
  any_error_fatal: true 
  tasks: 
  - command: cat /var/log/server.log
    register: command_output
    failed_when: '"ERROR"  in command_output.stdout'
```

-----------------------------------------------------
incase failure in the block it will trigger the rescue section. 
```
---
- name: install & service				# block/resuce/always
  hosts: all
  tasks:
  - blocks:
      - name: install apache2
        apt: name=apache2 state=latest
      - name: start apache
        servcie: name=apache2 state=started
    rescue:
    - mail:
        to: dev-group@hcl.com
        subject: failed playbook
        body: 
    always:
    - mail: 
        to: 
        subject:
        body:
```
-------------------------------------------------

how to use blocks and Handling the errors.
```
---
- name: install						# block/resuce/always
  hosts: all
  tasks: 
    - block:
      - name: install mysql
        yum: name=mysql state=present
      - name: start mysql servvice
        service: name=mysql-serverr state=started
      become_user: db-user
      when: ansible_facts['distribution'] == 'centos'
      rescue:
       - mail:
           to: team@xyz.com
           subject: Install my-sql status
           body: DB install failed at {{ ansible_failed_task.name }} 
      always:
      - mail:
          to: team@xyz.com
          subject: Install my-sql status
          body: 
        ignore_errors: yes
```

--------------------------------------------------------------------
Strategy
--------------------------------------------------------------------
There are 2 types of Strategies in Ansible. 

    1. Linear (Defalut) - You don't need to specify.
    2. Free 		- will install tasks on the servers independently with out waiting for other servers

Linear strategy: is the default strategy used by ansible, if we are using linear strategy the ansible tasks execution will be done parallel accross all servers. if one server is completed first it will wait for the other servers to complete. if it got failed then it will also get failed accross all servers. 

Free strategy: when you use Free strategy, it will complete the task execution independently with out witing for other servers to complete.

```
---
- name: install						# strategy
  hosts: all
  strategy: free 
  tasks: 
  - name:
 ```

--------------------------------------------------------------------
Serial
--------------------------------------------------------------------
by default how many servers ansible can perform playbook changes on remote servers is 5. Ansible can create 5 forks by Defalut. this is configured in `ansibile.cfg` file as `forks = 5`. how ever we can change this behaviour using to execute tasks BATCH wise on host servers, we use the `serial` directive. it means, it will performs playbook execution on 3 servers.

```
---
- name: install						#serial
  hosts: all
  serial: 3
  tasks:
  - name:
```

Note: by default how many servers ansible can perform playbook changes is 5. Ansible can create 5 forks by Defalut. this is configured in ansibile.cfg file as `forks = 5`. how ever we can change this behaviour using ansible configuration file. 

--------------------------------------------------------------------
Pre_tasks / Post_tasks
--------------------------------------------------------------------
Playbook-tasks execution order, Roles are executed before the playbook tasks. To execute tasks before the roles, we can use the directives like pre_tasks,  post_tasks. 

```
---
- name: install 					# pre_tasks / post_tasks
  hosts: all
  tasks:
  - name: install apache2
    apt: name=apache2 state=latest
  post_tasks:
  - name: start servcie
    service: name=apache2 state=started    
  pre_tasks:
  - name: check os version
    command: 'cat /etc/*release*'
 ```

--------------------------------------------------------------------
handlers:
--------------------------------------------------------------------
Handlers in Ansible are used to trigger actions in response to events during the execution of playbooks. Typically, handlers are defined to perform tasks like restarting a service or taking some other action only when notified by a specific task. 

```
---
- name: install 					# handlers
  hosts: all
  tasks: 
    - name: install
      apt: 
        name:
          - apache2
          - nginx
        state: latest
      notify: start service
  handlers:
    - name: start service
      service:              # The service module handles services individually, so you should provide a single service name.
        name: "{{ item }}"
        state: started
      loop:
        - apache2
        - nginx
 ```       

--------------------------------------------------------------------
Ansible-role:  ansible-galaxy
--------------------------------------------------------------------
Ansible Roles provide a structured way to organize tasks, templates, files, and variables. roles can be reusable in other playbooks. This structure makes it easier to manage complex automation setups. ansible roles are installed/stored in `~/.ansible/roles` (or) `/etc/ansible/roles`. we can  download roles from ansible community which are already created by others using https://galaxy.ansible.com/ link.

	$ ansible-galaxy role install robertdebock.httpd	--> this roles created by user robert to install httpd
	$ ansible-galaxy list 					--> list roles installed using  https://galaxy.ansible.com/.
 	$ ansible-galaxy remove robertdebock.httpd		--> to delete the role 
  
 we can use this role in ansible playbooks using as below
```
---
- name: install httpd						# ansible-galaxy
  hosts: all
  roles:
    - robertdebock.httpd
```

we can create custom roles using ansible galaxy as below, we can upload this  roles to the community. if your are using custom roles, we need to create a directory `roles` in same location where you are running your  main playbook.
 
	$ ansible-galaxy init my-role-httpd	--> create a role structure  to write  ansible plays

	tasks/: 	The main list of tasks that the role executes.
	handlers/: 	Handlers, which may be used within or outside this role.
	library/: 	Modules, which may be used within this role.
	defaults/: 	Default variables for the role. These variables have the lowest priority of any variables available and can be easily overridden by any other variable, including inventory variables.
	vars/: 		Other variables for the role.
	files/: 	static files used by role tasks
	templates/: 	Contains Jinja2 templates referenced by role tasks
	meta/: 		Includes author, license, platforms, optional dependencies

--------------------------------------------------------------------
Ansible-vault: 
--------------------------------------------------------------------
Ansible vault is used to encrypt the sensitive  files, and they can be used in  the playbooks. this way we can protect sensitive information.

	$ ansible-vault create secret.yml					--> to create a new secure file	
	$ ansible-vault create secret.yml --vault-password-file=./password.txt 	--> to create a secure file using a password.txt file which contain password

password.txt
-----------------------
Passw0rd

	$ ansible-vault decrypt secret.yml 	--> to decrypt the secure file
	$ ansible-vault encrypt secret.yml	--> to encrypt the existing file
	$ ansible-vault edit 	secret.yml 	--> to edit the encrypted file
	$ ansible-vault view 	secret.yml	--> to view the encrypted file
	$ ansible-vault rekey 	secret.yml	--> to change the password 
	
	$ ansible-vault decrypt super-secret.yml --output=super-secret-decrypted.yml		--> decrypt to a new output file
	$ ansible-vault encrypt super-secret-decrypted.yml --output=super-secret-encrypted.yml	--> encrypt to a new output file
 
secret.yml
---------------------------------
newusers:
  - name: ansibleuser1
    pw: redhat
  - name: ansibleuser2
    pw: Re4H1T
---------------------------------

main.yaml
------------------------------
```
---
- name: create user accounts for all our servers	`			# ansible-vault
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

```
------------------------------

