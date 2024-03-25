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
