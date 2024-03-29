Docker: Overview 
--------------------
Docker is a Containerization platform. It will provide an environment to run your containers with out having to worry about the underlying OS. Docker is avaiable for Linux and Windows OS. so you can run your containers on any of the platfarms. just install the Docker and deploy your containers.  Containerization will encapsulate or package softwares and all its dependencies, so that it can run uniformly and consistently on any infrastructure. 

What is a Container?
----------------------
A container is light weight isolated object, that will pack your application and its dependencies with libraries and OS together. So that you don't have to worry. it can be deployed/run accross any platform without worrying the underlying OS.

Docker: Architecture Overview
--------------------------------
Docker architecture involve 3 componenets. 

	1). Docker Daemon: The daemon (dockerd) is a process that keeps running in the background and waits for commands from the client. The daemon is capable of managing various Docker objects.
	2). Docker client: The client  (docker) is a command-line interface program mostly responsible for transporting commands issued by the users.
	3). REST API: The REST API acts as a bridge between the daemon and the client. Any command issued using the client passes through the API to finally reach the daemon.

![Picture1-15](https://user-images.githubusercontent.com/33980623/234473946-a618580d-8b8f-4705-a100-6f6f98f4049e.png)

Docker uses a `Client-Server` architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. You as a user will usually execute commands using the client component. The client then use the REST API to reach out to the long running daemon and get your work done. 

docker.service file Location	: `/lib/systemd/system/docker.service` | `/usr/lib/systemd/system/docker.service`

Docker Configuration Files	: `/etc/docker/daemon.json` (Linux) --> docker configurations are stored in daemon.json

Docker Data Directory		: `/var/lib/docker/` (Linux)  --> all docker objects are stored here like "containers, images, networks, volumes, plugins"

Docker Storage Drivers		: `/var/lib/docker/overlay2/` (Linux) --> it is where Docker stores the layered file system for containers using the OverlayFS storage driver. 

Docker Logs			: `/var/lib/docker/containers/container-id/` (Linux)

Docker Volumes			: `/var/lib/docker/volumes/volume-name/` (Linux) 

Docker daemon service is run on ports : `2375(plain) / 2376(secure)`

Docker environment variable for accessing remotely : `export DOCKER_HOST="tcp://docker-host-ip:2375"` --> secure use 2376

Docker: Install
----------------------------
Docker installation on CentOS. When docker is installed, it create a dircectory `/var/lib/docker` where all the docker objects are stored. such as containers, images, volumes, network and others. Docker installtion comes with this binaries. 

	$ docker		--> It is used to interact with the Docker daemon and manage Docker containers and services.
	$ docker-compose	--> It allows you to define a multi-container environment in a single file and manage the entire application stack.
	$ docker-init		--> for initializing Docker containers. It helps set up the container environment before executing the main process.
	$ docker-proxy		--> Docker Proxy is involved in networking for Docker containers. It handles the routing of network traffic to and from Docker containers.
	$ dockerd		--> This is the Docker daemon binary. It is the background process that manages Docker containers on a system. 
	
Install: Docker
----------------
Installing the docker on a Linux OS.

	$ sudo yum install -y yum-utils  								--> install yum-utils package
	$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo	--> add repository 
  	$ sudo yum install docker-ce docker-ce-cli containerd.io  					--> installs 3 components. 

  Note: 
  1. `docker-ce` is the main Docker package that includes the Docker daemon `dockerd`, client tools, and additional components for managing containers and images. 
  2. `docker-ce-cli` is a separate package that includes only the Docker command-line tools, It provides the Docker CLI commands for interacting with the Docker daemon and managing containers and images.
  3. `containerd.io` is an industry-standard core container runtime that manages the container lifecycle (start, stop, pause, resume, etc.).

Docker Daemon Status check:
----------------------------
Docker run as a system service, which will run in the background. it has `docker.socket` and `docker.service` are both components of the Docker Engine, but they serve different purposes. 

`docker.socket` is a systemd socket that Docker creates during installation. It listens for incoming Docker API requests on a Unix domain socket (`/var/run/docker.sock` by default). When a client program (e.g., Docker CLI) wants to interact with the Docker daemon, it communicates through this socket. This socket allows users to interact with the Docker daemon without needing to start the Docker daemon directly.

`docker.service` is systemd service unit that manages the Docker daemon. It is responsible for starting, stopping, and managing the Docker daemon process.The Docker daemon (dockerd) is the background process that manages Docker containers, images, networks, and volumes.

	$ systemctl status docker	--> to check running status
  	$ service docker status		--> to check running status

Start/Stop Docker service:
---------------------------
Docker installtion creates `docker.service`, this file located `/lib/systemd/system/docker.service` | `/usr/lib/systemd/system/docker.service`. to handle docker services to start/stop/restart use as below. 

	$ sudo service docker start	--> start the docker service.
 
	$ sudo systemctl start docker	--> start docker service.
 	$ sudo systemctl stop docker	--> stop docker service.
 	$ sudo systemctl status docker 	--> check Docker service status RUNNING/NOT.
  
	$ sudo systemctl enable docker  --> enable the service to auto start post system reboot, it will add file in /etc/systemd/system directory.
 	$ sudo systemctl cat docker	--> to read the docker.service file.
	$ sudo systemctl reload docker 	--> Reloaded Docker Application Container Engine and its configurations.
    
	$ journalctl -u docker.service 		--> docker daemon troubleshooting with service logs
 	$ journalctl -u docker --follow		--> docker daemon log troubleshoot, follow the logs runtime.
  
 	$ ps aux | grep docker 			--> to see process running inside container

objects: 
-----------------------------
	$ docker image ls	--> list docker images
	$ docker network ls	--> lists docker networks
	$ docker container ls	--> lists running docker containers
	$ docker volume ls 	--> lists volumes created

Daemon:
-----------------------------
Once the docker daemon starts, it listens on an internal unix socket `docker.sock` (/var/run/docker.sock). this is how the docker-cli interact with docker daemon. this is Unix Socket is only limited to that perticular system itself. You can start a Docker Daemon manually using `dockerd` command. 

	 $ dockerd 		--> starting Docker Daemon manually 
  	 $ dockerd &		--> run it in background using "&"
	 $ dockerd --debug	--> running in debug mode. using option "--debug" 
  
	 $ dockerd --debug --host=tcp://192.168.1.10:2375  --> remote docker service (export DOCKER_HOST="tcp://192.168.1.10:2375) no SSL (not secure)
  	 $ dockerd --debug --host=tcp://192.168.1.10:2376\ --> secure connection is made with help of encription keys.
    			   --tls=true \
			   --tlscert=/var/docker/server.pem \
			   --tlskey=/var/docker/serverkey.pem \
      			   --tlsverify=true \
			   --tlscacerts=/var/docker/caserver.pem

The above configurations can also be moved to the configuration file located in `/etc/docker/daemon.json`. this is the docker configuration file like below.  

/etc/docker/daemon.json
--------------------------
```
{
"debug": true,
"hosts": ["tcp://192.168.1.10:2376"]
"tls": true,
"tlscert": "/var/docker/server.pem",
"tlskey": "/var/docker/serverkey.pem"
"tlsverify": true,
"tlscacerts": /var/docker/caserver.pem
}
```
  
if we want to control the docker daemon from remote host we need to add `--host=tcp://192.168.1.10:2375`. this will enable the TCP Socket, so that the daemon can be interacted from remote host. In the remote host we need to install `docker-cli`  and need to export the `DOCKER_HOST` environment variable. then you can use docker-CLI to connect to the remote daemon. 

	`export DOCKER_HOST="tcp://192.168.1.10:2375`(2375 unencrypted)  
 	`export DOCKER_HOST="tcp://192.168.1.10:2376` (2376 is encrypted SSL) this. 

Unix Sockets: If you're connecting to the Docker daemon via a Unix socket, the default location is `/var/run/docker.sock`. There's no port number associated with Unix socket connections.
TCP Socket: When Docker is configured to listen on a TCP socket, the default port number is `2375` for insecure connections and `2376` for connections secured with TLS.
	
 	Unix Socket: this will only listens with in the same machine.
	TCP Socket: this will enable you to communicate with remote machines.

Note: In normal situations when the docker daemon crashed, it will takedown all the containers which are running. to avoid this behaviour we can configure the system. this methord is called as `LIVE RESTORE`. we just need to add one line in the docker configuration file (`/etc/docker/daemon.json`) as below and restart the docker service using `$ systemctl restart docker.service` command.

```
{
"debug": true,
"hosts": ["tcp://192.168.1.10:2376"]
"live-restore": true	# Live-restore 
}
```

Version: 
---------------------------------
	$ docker --version		--> docker version
	$ docker-compose --version	--> docker compose version
 	$ docker system info 		--> docker full information (debug mode)
 
Process: 
---------------------------------------------
	$ docker ps 		--> only running containers list
	$ docker ps -a 		--> to see all containers (running/stopped/paused/created)
	$ docker ps -q		--> shows only container-ID of running process
	$ docker ps -s 		--> shows "Size" of a running container  
 	$ docker ps -l 		--> latest container created
   
   	$ docker ps -f "label=env=DEV"	--> filter containers labelled as "DEV"
    	$ docker ps -f "label=env=PROD"	--> filter containers labelled ad "PROD"

Docker Registry
---------------------------------------------
An image registry is a centralized place where you can upload your images and can also download images created by others. Docker Hub is the default public registry for Docker. create a docker hub account and login using link: https://hub.docker.com/

	$ docker login 				--> to login to docker repository (default: docker hub repository)
	$ docker logout 			--> to logout docker repository
	$ docker login gcr.io			--> to login to GCP repository
	$ docker login docker.io 		--> to login to docker hub repository
 	$ docker login nexus-registry-url 	--> to login to nexus private registry 

--------------------------------------------------------------------------------------------------------------------------
Containers - ( run, create/start/stop, pause/unpause, rm/kill, logs, inspect, ports, cp, diff, events, exec, info, ps, stats, top)
-------------------------------------------------------------------------------------------------------------------------- 


Q. What is a Docker Container? 
---------------------------------------------
A container is a light weight & isolated object, that wraps the application and its dependencies along with libraies and supporting file that are used to run the application indipendently with out having to worry about the underlying operating system. with containers you can run your application on any platform uniformly. this contaienrs are light wight objects. docker container life cycle. once the containers job is finished they closed.
	
	Creation --> Running --> Pausing --> Unpausing --> Starting --> Stopping --> Restarting --> Killing --> Destroying

 Usage:  $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
	
		-i 					--> interactive mode
		-t 					--> terminal 
		-d 					--> detached
  		--rm 					--> remove the container when it is stopped, means destroys the cotainer perminently
      		--cpus 1.0				--> cpu  (0.1 cpu(10%) - 0.5 cpu(50%) - 1.0 cpu(100%) )
		--memory 512M				--> memory (K,M,G,)
		-u user-id:group-id			--> user group are assigned to containers
  		-l env=PROD --label domain=FINANCE	--> label your container for easy access
		-v <Host-volume>:<container-volume> 	--> mapping container volumes with host volume
		-p <Host-port>:<container-port> 	--> publish container port with host port 
		-e key1=value1 -e key2=value2	 	--> environment variable
		--network my-network1		 	--> mapping to custom network group
		attach 					--> to attach to the running container
run:
-----------------------------
docker containers can be "created and started" at  the sametime using `$ docker run ` command. 

	$ docker run nignx 			--> it creates & starts nginx container, and docker daemon will give a unique name to it.
	$ docker run --name my-nginx nginx 	--> it creates & starts nginx container named as my-nginx
	$ docker run -d nginx 			--> container run in background
	$ docker run -it nginx /bin/bash 	--> this will open a terminal to connect with running container 

 	$ docker run -d  -i -t --name my-nginx -p 8082:80 -v /some/content:/usr/share/nginx/html:ro --rm nginx 		--> `:ro` suffix indicates that the mounted volume should be read-only. 
  
create: 
-----------------------------
docker containers can be created using `$ docker create` command. this will not start the container until you start it using `$ docker start` command. 
	
 	$ docker create nginx			--> create a new container, it will be in "created" state
  	$ docker create --name my-nginx nginx	--> naming cotainer as "my-nginx"
   	$ docker create --label env=DEV nginx	--> label the containers.
    	$ docker create -e key1=value1	nginx 	--> setting env variables.

     	$ docker create --name my-httpd --label --rm  ENV=DEV -p 8081:80 -v /tmp/httpd:/usr/local/apache2/htdocs/:ro  httpd  	--> `:ro` suffix indicates that the mounted volume should be read-only. 

start/stop:
-----------------------------
	$ docker create  nginx 		--> creates nginx container, named as my-nginx
	$ docker start my-nginx		--> starts newly created nginx 
	$ docker stop my-nginx 		--> stop nginx container, it will be avaiable to restart again
	$ docker kill my-nginx 		--> it will obruptly kills the nginx container
 	$ docker rm my-nginx		--> it will delete the stopped/killed container process.
 
"stop" vs "kill" commands. stop will gracefully shutdown the container, that means  it can perform cleanup operations or execute any defined exit procedures. it will  releasing resources, and then exit. Stopping a container allows it to save any changes to its file system, commit them to an image, and exit gracefully. it will invoke "SIGTERM" signal 

Kill will forcefully terminate, which immediately terminates the container without allowing it to perform any cleanup or exit procedures. any changes or in-memory data that haven't been saved will be lost. Killing a container is useful when a container is unresponsive or needs to be stopped forcefully. it will invoke "SIGKILL" signal

Port Publish:
-----------------------------
publishing the container port using the `--publish` or `-p` option. `-P` will allocate a random host port to the container. `-P` has some drawbacks when the container restart it will reset the hostport with different port. so it is recommunded to use `-p` option to publish the contianer. 

     	$ docker run -p 8080:80 nginx 		--> publish the nginx to external network using host-port 8080 (-p <host-Port>:<container-port> ) 
 	$ docker run -p 8081:80 nginx 		--> We can't map the nginx with same host port, so we used 8081 port. 	
	$ docker run –p 3306:3306 mysql 	--> publish mysql port

  	$ docker run -P httpd			--> publish the port automatically by the system. 

sometimes physical mechine have multipule NICs (network interface cards), it means that system can have mutipule IP address. so we want to publish the container on the internal NIC card then we can specify the IP of that NIC and create the container. so that the applicaton can only accessable on that IP only. 

 	$ docker run –p 192.168.1.5:8000:5000 kodekloud/simple-webapp	--> pulishing the container on a specific NIC card. 
port:
-----------------------------
to list the  ports mapped to the containers.

	$ docker port my-nginx/container-ID	--> to check container ports status
	$ docker port my-nginx 8080/tcp 
	$ docker port my-nginx 8080/ud
 
Label:
------------------------
you can label your containers according to your need so that you can filter them later using the labels that are defined for the containers. this will help you to filter the containers easly. 

   	$ docker run -l env=PROD -d nginx	--> Label a container with PROD 
    	$ docker run --label env=DEV -d nginx	--> Lable a container with DEV

env:
-------------------------
passing the environment variables during the container. this variables are visible inside the container. and they use this environment variables. 

     	$ docker run -e key1=value1 nginx			--> passing environment varialbes 
      	$ docker run -e key1=value1 -e key2=value2 httpd	--> passing 2 env variables.  
       
copy:
-----------------------------
Copy file from local host to container, this will allow you to update the container data. 

	$ docker cp host-file container-id/name:container-file/path
 
	$ docker cp /tmp/web.conf webapp:/etc/web.conf 		--> copy file/directories to webapp container from localhost --> container 
 	$ docker cp webapp:/etc/web.conf /tmp			--> copy files from container --> localhost

rename:
-----------------------------
	$ docker rename my-nginx app1-nginx 	--> to rename nginx container from my-nginx to app1-nginx   

exec:	
-----------------------------
to run/perform any operations inside the container, like checking the process, user, data, etc. 

	$ docker exec my-nginx uname -a 		--> to check the container OS details
	$ docker exec my-nginx cat /etc/*release* 	--> to check container OS details
	$ docker exec -it my-nginx /bin/bash		--> opens a bash container terminal 
 
CPU/Memeory:
-----------------------
You can allocate system resources to the container, so that the container can only limit the system resources as defined. this will eliminate the cpu and memory crunch. 

 	$ docker run -cpus 0.5 -d nginx		--> assign CPU units 0.5 means half CPU
  	$ docker run -memory 512M -d nginx	--> assign MEMORY units 512MB to a container

pause/unpause: 
-----------------------------
Pausing a container is a Docker operation that temporarily stops all processes within a running container, Pausing a container allows you to temporarily free up system resources, such as CPU and memory, for other containers that need them. When you're troubleshooting issues within a container, pausing it can help you examine the container's file system or configurations without the interference of running processes. 

you can't perform any operation during this time, the container running but it will be in paused state. 

	$ docker pause my-nginx my-redis 	--> it will pause the container
	$ docker unpause my-nginx my-redis 	-->it will unpause the containers

diff:
------------------------------
This will show which file changed  from actual container image to  running  contianer.

	$ docker diff my-nginx		--> it will print the files and directories changes post  container is up.

  	A: Added: Indicates that a new file or directory has been added to the container's filesystem.
	C: Changed: Indicates that an existing file has been modified within the container.
	D: Deleted: Indicates that a file or directory has been deleted from the container's filesystem.
	R: Renamed: Indicates that a file or directory has been renamed within the container.
	U: Unchanged: Indicates that a file or directory remains unchanged since it was started.

inspect:	
-----------------------------
This will show all the details of docker container/image/volume/network. 

	$ docker inspect my-nginx/container-ID --> to see the docker container details.
 	$ docker inspect image
  	$ docker inspect volume
   	$ docker inspect network

logs:	
-----------------------------
docker logs are stored in `/var/lib/docker/containers/container-id/` location.  

	$ docker logs my-nginx			--> recarded container logs
 	$ docker logs -f my-nginx		--> Live container logs monitoring. 
 	$ docker container logs -f my-nginx	--> Live log monitoring. like tail command. 
  
Docker uses the `logging drivers` to store the logs on the specific container. there are different types of logging drivers available. to view the  drivers available use `$ docker system info`, there you can see the available driver plugins. to change the drivers add the below configurations in `/etc/docker/daemon.json` file. 

	{
 		"debug": true,
		"hosts": ["tcp://192.168.1.10:2376"]
		"log-driver": awslogs	# logging drivers change 
  		"log-opt": {
    			"awslogs-region": "us-east-1"
		}
  	}
Note: to store the docker logs on the aws cloud we must need to pass the AWS credentials, so that the docker daemon can store the logs on the aws. 

remove: 
-----------------------------
To delete the container once it done its work is done use `--rm`  option with container.

	$ docker rm container-ID/container-name		--> to  delete the stopped container.	
	$ docker run --rm ubuntu cat /etc/*release*	--> remove the docker container once the container exited.

attach:	
-----------------------------
to attach to the detached container, first your container must enable the interactive terminal `-it`. then only you can reattach to the attached container with out stopping the container.

	$ docker run -it -d nginx 	--> start container like this.
	$ docker attach my-nginx 	--> to attach to the detached container, to detach (Ctrl+p + Ctrl+q )
 
top:
-----------------------------
	$ docker top my-nginx/container-ID 	--> to see process running for that container.
	$ docker stats				--> provide the stats of the containers like memory,cpu,PID,usage and etc.
 	$ docker stats my-nginx 		--> check the stats for a specific container
  
auto restart: Restart policy
-----------------------------
To make the container auto restart we need to add the command with `--restart ` option with parameters like `no` | `on-failure` | `always` | `unless-stopped`. when your use `--restart` you can't use `--rm`.
	
  	$ docker run --restart=on-failure -d nginx	--> It will restart the container on failure.

	   no:			--> never automatically restart
	   on-failure:		--> depends on the exit code, if the exit code is ZERO it will not restart. if the exit code is NOT ZERO then it will restart
	   always:		--> it will restart the container. 
	   unless-stopped:	--> you stop the container, then it will be in stopped state.
events:	
-----------------------------
`docker system events ` vs `docker events` both  are same. 

	$ docker system events --since 60m		--> system events recorded for 60m 
 	$ docker events --since 60m -f "label=env=DEV" 	--> filter the events using  labels. (-f =  --filter)

system:	
-----------------------------

	$ docker system df	--> docker objects created count and memeory usage
	$ docker system info	--> docker daemon configuration details.
	$ docker system prune	--> it will remove all stopped, dangling images
		- all stopped containers
  		- all networks not used by at least one container
  		- all dangling images
  		- all dangling build cache

 Advanced commands:
 ----------------------------
 
	$ docker stop $(docker ps -q) 	--> it stops all containers running
	$ docker rm $(docker ps -aq) 	--> it will remove all containers in stopped state.
	
	$ docker container stop $(docker container ls -q) 	--> stop all containers at once
	$ docker container rm $(docker container ls -aq) 	--> remove all container at once.


--------------------------------------------------------------------------------------------------------------------------
Images ( build, history, rmi, tag, save/load, export/import, commit, login/logout, push/pull, 
--------------------------------------------------------------------------------------------------------------------------
 
Q. What is a Docker: Image?
----------------------------
Docker image is a lightweight, standalone, and executable package that encapsulates the software, its dependencies, and configuration needed to run an application. It serves as a blueprint for creating Docker containers. Docker images are built from a set of instructions called a Dockerfile, which specifies the base image, application code, environment settings, and other components. 

Sample docker image creation using the Dockerfile is shown below

Dockerfile
--------------------------------------------------
```
FROM nginx:latest			# Use an official Nginx runtime as a base image

COPY index.html /usr/share/nginx/html	# Copy the local index.html file to the container's web root

EXPOSE 80				# Expose port 80 for incoming traffic

CMD ["nginx", "-g", "daemon off;"]	# Define the default command to run when the container starts

```

	FROM	--> define OS prefered for your image
	RUN	--> for runing a command 
	COPY	--> copy the file from local to image
	ADD	--> similer to COPY, but it has some additinal features, it can untar and copy, it can donwload from internet and copy
	EXPOSE	--> to expose the container port
	CMD 	--> the program with container should start when container start
	ENTRYPOINT --> similer to CMD, but need to pass the CMD at the end.  
	ENV	--> image environment variables defined druing the container run
	WORKDIR	--> define the working directory 
	VOLUME	--> define mountable directories in image
	ARG	--> arguments to pass in the image

pull/push:
---------------------
	$ docker pull nginx 		--> will pull the image from docker repository, it will pull only one.
	$ docker push custome-image 	--> to push you image to the docker repository

history:
---------------------
	$ docker images  	--> to list the docker images pulled and avaiable
	$ docker history nginx 	--> to see image creation steps

remove:
---------------------
	$ docker rmi nginx 	--> to remove the nginx image in local repository

build:
---------------------
create a Dockerfile, then build the docker image using the below commands. commands are executed from the same directory. where Dockerfile is available. 

	$ docker build . 					--> this will build the image with out any tags or name for your build
 	$ docker build -f Dockerfile.dev 			--> use custom docker file to crate docker image.
	$ docker image tag container-ID my_custom_nginx:latest 	--> this will add tags to the image
	$ docker build . -t custom-tag1 			--> directory should contain `Dockerfile` to build the docker image
	
	$ docker build https://github.com/karunakarrao/my-nignx  		--> to build the image from a git repo
	$ docker build https://github.com/karunakarrao/my-nginx#branchname 	--> can also specify the branch 
	$ docker build https://github.com/karunakarrao/my-nginx:<build-folder-name> 	--> this way we can pass the directory
	
	$ docker build -f Dockerfile.dev https://github.com/karunakarrao/my-nginx:<build-folder-name> 

tag:
---------------------
	$ docker image tag image-ID custom_name:custom_tag	--> rename the image with new name and tag
	$ docker image tag httpd:alpine httpd:customv1 		--> rename the tagged image value with custom name
	$ docker image tag httpd:alpine gcr.io/company/httpd:customv1 

save/load:
---------------------
Images can be shared as a .tar file and extract it using the save and  load commands. 

	$ docker image save alpine:latest -o alpine.tar	--> to save the image as .tar file and share
	$ docker image load -i alpine.tar  		--> to extract the .tar file 
	
export/import:
---------------------
we can export and import containers also using export and import command. 

	$ docker export <container-name> file1.tar
	$ docker image import file1.tar newimage:latest
 
commit:
-------------------------------
The docker `commit` command is used to create a new image from the changes made to a container. This can be useful when you have made changes to a container and want to save those changes as a new image that can be reused or shared with others. example as below.

	$ docker run --name my-nginx -d nginx			--> you started a container.
 	$ docker exec -it my-nginx apt-get update -y 		--> you have done changes in container like upgrade
  	$ docker exec -it my-nginx apt-get install -y vim	--> installed few  softwares
   	$ docker commit my-nginx my-custom-nginx		--> create a new image "my-custom-nginx"

What is Multistage-docker build ? how to?
----------------------------------------------
Multistage Docker builds are a feature that allows creating more efficient and smaller Docker images. by using multiple build stages within a single Dockerfile. Each stage represents a phase of the build process. This helps reduce the size of the final Docker image by excluding unnecessary build dependencies and files, making it more lightweight and suitable for production deployment. 

Dockerfile
------------------
```
FROM node AS builder
COPY . .
RUN npm install
RUN npm run build 	# npm utility is used to create a application directory and its dependencies in a /dist directory  that will used to copy all the files to the image directory.

FROM nginx 
COPY --from=builder dist /usr/share/nginx/html	# we use ---from option to use the output image of first stage in the secound stage. 
CMD [ "nginx", "-g", "daemon off;" ]

```
In the above docker file we used `npm` utility to package the application files and everything into a single directory that can be used to create the docker image very effectively. 

Best practices to create docker images:
----------------------------------------
below are the list of best practices that we can follow during the docker build. 

	1. Create slim/minimal images
	2. Find an official minimal image that exists
	3. Only install necessary packages
	4. Maintain different images for different
		environments:
		• Development – debug tools
		• Production - lean
	5. Use multi-stage builds to create lean production
	ready images.
	6. Avoid sending unwanted files to the build context 

 Q. What is the difference between COPY vs ADD ?
----------------------------------------------
COPY: The COPY instruction is used to copy files and directories from the host machine to the image. It is a straightforward and simple operation. You specify the source and destination paths. It's generally recommended to use COPY when you want to copy files or directories from the host into the image.

ADD: The ADD instruction is more versatile. It can do everything COPY can do, but it also has some additional features. It can copy local files, directories, and remote URLs, and it can automatically extract compressed files, such as tarballs, if the source is a URL or compressed archive.

Q. What is the difference between CMD vs ENTRYPOINT ?
---------------------------------------------------
CMD and ENTRYPOINT are Dockerfile instructions used to define the default command that runs when a container starts. The main difference is that CMD allows users to override the command when starting the container, while ENTRYPOINT sets a fixed command that cannot be easily overridden. Typically, CMD is used to provide default arguments, while ENTRYPOINT sets the primary command that is always executed, allowing additional arguments to be provided when running the container. This difference makes CMD more flexible for customization and ENTRYPOINT more suitable for defining the core functionality of a container.

	$ docker run --entrypoint sleep2.0 ubuntu-sleeper 20 	--> this is to override the default `entrypoint` cmd.

Q. What is the difference between ENV vs ARG ?
---------------------------------------------
ENV and ARG are both used to define variables in Docker, but they serve different purposes. ENV sets environment variables in the container, making them available during runtime. ARG defines build-time variables for the image, providing flexibility during the build process but not accessible in the running container.
	
Q. what is the use of docker namespaces ?
------------------------------------------
Docker uses Namespaces to isolate the containers from the hosted OS, Docker containers running on hosted severs are not fully isolated, means they share same kernal. So the containers running on host are given a process-ID. Docker uses namespaces for each container so with in the container only container process are visible. but if we actually see hosted system process, respective process are visible in the hosted system with different PID. there are different namespaces like  belwo
	
1. PID Namespace : it isolate the PID of Containers. Each container gets its own set of process IDs, and processes in one namespace are unaware of processes in other namespaces. This prevents processes in one container from seeing or affecting processes in other containers. Running `ps aux` inside a container will only show processes running within that container, not processes from other containers or the host system.

2. Network Namespace : Network namespaces isolate network resources such as network devices, IP addresses, routing tables, and port numbers. Each container gets its own network namespace, providing isolation at the network level. Containers can have their own network interfaces, IP addresses, and routing rules. Example: Running ifconfig inside a container will only show the network interfaces associated with that container, not interfaces from other containers or the host system.

3. Mount Namespace: Mount namespaces isolate the filesystem mount points. Each container gets its own mount namespace, providing an isolated filesystem view. Containers can have their own set of mounted filesystems, independent of other containers or the host system. Example: Mounting a volume inside a container with docker run -v /host/path:/container/path will only affect that container's filesystem, not other containers or the host system.
   	
4. User Namespace: Isolates user and group IDs. 

5. UTS Namespaces: UTS (Unix Time-sharing System) namespaces isolate the hostname and domain name. Each container gets its own UTS namespace, allowing it to have a unique hostname and domain name. Containers can have different hostnames and domain names, even if they share the same kernel. Example: Setting a custom hostname inside a container with docker run --hostname my-container will only affect the hostname within that container, not other containers or the host system.

6. IPC Namespaces :  Isolates System V IPC and POSIX message queues.

7. Cgroup Namespace: This is not directly used by Docker but is used by Linux Control Groups (cgroups) to manage resource allocation and tracking.

Q. What is CGroups?
-----------------------
CGroups(control groups) are the linux feature that allows to allocate the system resources such as CPU, MEMORY and Network bandwidth, block-IO among the different system process on the host. docker uses this CGroups to share the resource among the docker containers. 

Q. What is a Docker: Volumes ?
-------------------------------
Containers are short lived object they are destroyed once the container work is over, but the data it collected also removed once the container is destroied. so to make the data persistant or to use for time to time we need to map the container path to localhost path so that the data is save persistantly. this is where the volumes come in to picture. 

Q. What is Docker storage drivers?
-----------------------------------
docker uses the storage drivers to maintain the layered architecture, creating writable layer on images, copy and write and etc. are done with help of storage drivers.  Depeding on underlying OS respective driver is used to perform this operations. Docker will chose the best option available for the system automatically. 

 	1. AUFS
  	2. ZFS
   	3. BTRFS
    	4. Device Mapper
     	5. Overlay
      	6. Overlay2
       
--------------------------------------------------------------------------------------------------------------------------
volumes:
--------------------------------------------------------------------------------------------------------------------------

Q. What are docker volumes?
-----------------------------------
Docker volumes are a way to persist data generated by and used by Docker containers. They allow you to share data between the host machine and containers, as well as between different containers. Volumes are separate from the container's filesystem and can exist even after the container is stopped or deleted.

1. Named Volumes: Named volumes are explicitly created using the `docker volume create` command or automatically created when specified in a container's configuration. They have a meaningful name assigned to them, making it easier to manage and reference. Named volumes are typically the recommended way to persist data in Docker. this will create a volume in the docker-host `/var/lib/docker/volumes`

2. Host-mounted Volumes: Host-mounted volumes allow you to mount directories from the host machine into Docker containers. With host-mounted volumes, the data resides on the host's filesystem, and changes made in the container are reflected on the host and vice versa. They are useful for sharing files between the host and containers. `docker run -d -v  /home/user1:/usr/local/contaner nginx`

3. Anonymous Volumes: Anonymous volumes are created automatically by Docker when a container is started without explicitly specifying a volume. They are assigned a random, unique identifier and are managed by Docker internally. Anonymous volumes are typically used when you don't need to manage the volume explicitly or when temporary data storage is sufficient. `docker run -d nginx`.

4. Bind Mounts: Bind mounts allow you to map a directory or file on the host machine directly into a container's filesystem. Unlike named volumes, bind mounts can specify a specific file or directory path on the host. Bind mounts offer greater flexibility in terms of specifying the location of the data on the host.

5. TMPFS Volumes: TMPFS volumes store data in memory instead of on disk. They are useful for storing temporary data that doesn't need to persist across container restarts. TMPFS volumes are specified using the --tmpfs option with the docker run command.
   
		$ docker volume ls 
		$ docker volume create my-volume1 	--> this will create a volume in the docker-host /var/lib/docker/volumes
		$ docker volume remove my-volume1	--> remove my-volume1
		$ docker inspect my-volume1		--> inspec the volume details. 
	
run: 
-----------------------------
	$ docker run -v my-volume:/var/lib/mysql mysql 		--> volume mapped to container default storage location "/var/lib/mysql".
	$ docker run -v my-volume2:/var/lib/mysql mysql 	--> if we didn't create a volume, docker will create the volume and map.
	$ docker run -v /home/mysql:/var/lib/mysql mysql 	--> we can map the external location to store the data persistantly
 
	$ docker run --mount type=bind,source=/home/mysql,target=/var/lib/mysql mysql 	--> this way also we can mount the volumes.

--------------------------------------------------------------------------------------------------------------------------
Networks:
--------------------------------------------------------------------------------------------------------------------------

Q. What is Docker: Networking ?
--------------------------------
Docker installtion comes with 3 types of networks

	1. Bridge (default) --> network 
	2. Host
	3. None
	
Bridge:  Is the default network that a conatiner will attach to. this network 172.17.0.1 range. 
Host: container ports are attached to Host Network, this results port conflict. so extra precusions are needed.
None: no network created to that containers.
	
	$ docker run nginx 			--> this will map to default Bridge network.
	$ docker run --network=host nginx 	--> to map to host network.
	$ docker run --network=none nginx 	--> to map to none network.
	
	$ docker network ls			--> List networks 
	$ docker inspect my-nginx 		--> to see the network details attached to the container
	
	$ docker network create --driver bridge --subnet 182.18.10.0/16  my-network1 --> create docker network my-network1

ping will not work in default bridge network, containers are isolated. to test this create 2 containers and try to ping.

	$ docker run -d --name cont1 --network  my-network1  nginx 		--> created cont1 &  cont2 on custom network  my-network1. 
 	$ docker exec cont1 apt update -y &&  apt install iputil-ping  -y	-->  install required  software then ping in  cont1  and cont2
  	$ docker exec cont1 ping cont2						--> ping will  work	
	
	$ docker network connect custom-network1 first 		--> to establish the connection between 2 networks
	$ docker exec customfirst ping first 			--> will work.
	
	$ docker network disconnect my-network1 my-nginx1	--> disconnect from  network
	$ docker network connect my-network2 my-nginx1		--> connect with new network 
	$ docker network rm my-network1				--> remove  network
	
Note: Docker containers reach each other using container name, this is achived using docker built Embedded DNS, which will resolve all the container names. when we map the containers, we specify the container name. the built in DNS server runs always on 127.0.0.11 

Bridge: bridge network is the default network for containers created. it ranges from 172.17.x.x. the containers communicate each other using bridge network.

example: scenario1
----------------------
In a real life scenario in 3-tire environment, we have web-containers network range (175.17.0.0/16), app-containers network range (182.18.0.0/16) and DB-containers network range (192.19.0.0/16). to deploy containers in differnt networks, first we need to create the respective networks and map them to the containers. if we want to used the other network for database containers we can create a new bridge network and mapp this network to the database containers, so they will be isolated with different network. 

 	$ docker network create --driver bridge --subnet 175.17.0.0/16 web-network1	
	$ docker network create --driver bridge --subnet 180.17.0.0/16 app-network1
	$ docker network create --driver bridge --subnet 182.17.0.0/16 db-network1
	
	$ docker run -d --network web-network1 nginx
	$ docker run -d --network 
	$ docker run --network=my-nginx1 nginx 

--------------------------------------------------------------------------------------------------------------------------
docker-compose:
-------------------------------------------------------------------------------------------------------------------------- 

Q. What is `docker-compose` ? 
---------------------------------
If we deploying fullscale application on docker, we need to use mutiple containers like web-server(nginx), in-memorydb(redis), persistant-db(mangodb), orchestration(ansible), etc. So to deploy all containers as a stack we use docker-compose . Docker-compose files are writen in YAML. this will deploy the complete application stack with one command. 

docker-compose file must be named like this `docker-compose.yml`, `docker-compose.yaml`, other wise docker-compose will not notice your configuration file. else you need to specify the `-f` flag to pass the compose file. 

 	$ docker-compose up	--> Builds, (re)creates, starts, and attaches to containers.
	$ docker-compose down	--> Stops and removes containers, networks, volumes, and images created by up.
	$ docker-compose ps	--> Lists containers.
	$ docker-compose logs	--> Displays log output from services.
	$ docker-compose exec	--> Runs a command in a running service.
	$ docker-compose build	--> Builds or rebuilds services.
	$ docker-compose stop	--> Stops services.
	$ docker-compose restart --> Restarts services.
	$ docker-compose pull	--> Pulls images for services.
	$ docker-compose up -d	--> Starts the services in the background.

 	$ docker-compose -f my-compose.yaml up -d	--> to bringup the custom named docker-compose file
   	$ docker-compose -f my-compose.yaml logs -f web	--> to view the logs like 'tail' command

there are 2 versions in docker-compose file, mention the version details in "" like "2" or "3". 

docker-compose.yml 
-------------------
```
version: "3"
services:
  redis:
    image: redis
    networks:
      - backend
  db:
    image: postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    networks:
      - backend
  voting-app:
    image: eesprit/voting-app-vote
    ports:
      - 5001:80
    networks:
      - frontend
      - backend
  result-app:
    image: eesprit/voting-app-result
    ports:
      - 5002:80
    networks:
      - frontend
      - backend
  worker-app:
    image: eesprit/voting-app-worker
    networks:
      - backend

networks:
  frontend:
  backend:

```
----------------------------
```
version: 2
services:
	redis:
		image: redis
		networks: 
			- back-end
	db:
		image: postgres:9.4
		networks: 
			- back-end
	vote:
		image: voting-app
		depends_on: 
			- redis
		networks: 
			- front-end
			- back-end
	result:
	  image: result
		depends_on: 
			- db
		networks: 
			- front-end
			- back-end
networks: 
	- front-end
	- back-end
```
-------------------
 
Q. how the Docker Image works?
-----------------------------------------------
1. To understand DockerImage better, we need to understand how Docker images are build. DockerImages are build using Dockerfiles. Dockerfiles are contructed in multipule layers ( base(OS), package, dependencies, souce-code(application), entrypoint) bind together and builds and image. this image is docker image. 

2. DockerImages are readonly images, means they are act as a template to create a container. so docker uses the same image to create n number of containers.

3. when a container is created, it will create a layer on the DockerImage

	
Q. how the Docker container works ?
---------------------------------------------------------------------------------------------------------------------
1). You execute "docker run hello-world" command where hello-world is the name of an image.

2). Docker client reaches out to the daemon, tells it to get the hello-world image and run a container from that.

3). Docker daemon looks for the image within your local repository and realizes that it's not there, resulting in the Unable to find image 'hello-world:latest' locally that's printed on your terminal.

4). The daemon then reaches out to the default public registry which is Docker Hub and pulls in the latest copy of the hello-world image, indicated by the latest: Pulling from library/hello-world line in your terminal.

5). Docker daemon then creates a new container from the freshly pulled image.

6). Finally Docker daemon runs the container created using the hello-world image outputting the wall of text on your terminal.


Q. How to Publish a Port to access the application ?
---------------------------------------------------------------------------------------------------------
Containers are isolated environments. Your host system doesn't know anything about what's going on inside a container. Hence, applications running inside a container remain inaccessible from the outside. To allow access from outside of a container, you must publish the appropriate port inside the container to a port on your local network. any request sent to port 8080 of your host system will be forwarded to port 80 inside the container. Now to access the application on your browser, visit http://localhost:8080 | http://dockerhost:8080

	$ docker run nginx  --publish 8080:80 --name=my-nginx


Q. how to update running container to publish port?
----------------------------------------------------
No, to publish the port, we need to do it in the begining of container creation. other wise we need recreate a new container with port details. 


Dockerfiles: Image handling
---------------------------------------------------------------
make a custom NGINX image, you must have a clear picture of what the final state of the image will be.

	1. The image should have NGINX pre-installed which can be done using a package manager or can be built from source.
	2. The image should start NGINX automatically upon running.

How to Ignore Unnecessary Files:   The `.dockerignore` file contains a list of files and directories to be excluded from image builds.This `.dockerignore` file has to be in the build context. Files and directories mentioned here will be ignored by the COPY instruction. But if you do a bind mount, the .dockerignore file will have no effect. 

step-1: Now, create a new file named Dockerfile in an empty directory. A Dockerfile is a collection of instructions.

Dockerfile
-----------------------------------------
```
FROM ubuntu:latest

EXPOSE 80

RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
```
----------------------------------------

FROM: 	Every valid Dockerfile starts with a FROM instruction. This instruction sets the base image for your resultant image.
EXPOSE: The EXPOSE instruction is used to indicate the port that needs to be published. 
RUN: 	The RUN instruction in a Dockerfile executes a command inside the container shell. 
CMD: 	Finally the CMD instruction sets the default command for your image.

	$ docker push <Image-repositry-name>:<tag>	-->syntax
	
	$ docker login		--> to login to docker hub registory.
	$ docker logout		--> to logout from docker registroy
	
	$ docker build . 	--> to build the docker image without tags

	$ docker image build --tag custom-nginx:packaged .	--> to tag the docker image. REPOSITORY-name is custom-nginx  and  TAG is package
	$ docker image build --tag my-nginx:latest 		--> to tag the image
	$ docker image history <image-name> 		--> to see the image layers of docker image.
	$ docker image prune --force			--> this will delete name less images. 
 	$ docker image push karna-nginx:latest		--> to push the latest image

-----------------------------------------------------------------------
```
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install build-essential\ 
                    libpcre3 \
                    libpcre3-dev \
                    zlib1g \
                    zlib1g-dev \
                    libssl1.1 \
                    libssl-dev \
                    -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY nginx-1.19.2.tar.gz .

RUN tar -xvf nginx-1.19.2.tar.gz && rm nginx-1.19.2.tar.gz

RUN cd nginx-1.19.2 && \
    ./configure \
        --sbin-path=/usr/bin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --with-pcre \
        --pid-path=/var/run/nginx.pid \
        --with-http_ssl_module && \
    make && make install

RUN rm -rf /nginx-1.19.2

CMD ["nginx", "-g", "daemon off;"]
```
--------------------------------------------------------------------------

To create a exicutable docker images. use this 

--------------------------------------------------------------------------
```
FROM python:3-alpine

WORKDIR /zone

RUN apk add --no-cache git && \
    pip install git+https://github.com/fhsinchy/rmbyext.git#egg=rmbyext && \
    apk del git

ENTRYPOINT [ "rmbyext" ]
```
---------------------------------------------------------------------------


Q. Docker: Network Manipulation Basics in Docker:
--------------------------------------------------------------------------
real life, the majority of projects that you'll have to work with will have more than one container. 

Scenario:1
------------
Now consider a scenario where you have a notes-api application powered by Express.js and a PostgreSQL database server running in two separate containers. These two containers are completely isolated from each other and are oblivious to each other's existence. So how do you connect the two? Won't that be a challenge? you connect them by putting them under a user-defined bridge network. 

		$ docker network ls 	--> to list the docker networks 

using above command, You should see three networks in your system. Now look at the DRIVER column of the table here. These drivers are can be treated as the type of network. By default, Docker has five networking drivers.
	
1. bridge - The default networking driver in Docker. This can be used when multiple containers are running in standard mode and need to communicate with each other.
2. host - Removes the network isolation completely. Any container running under a host network is basically attached to the network of the host system.
3. none - This driver disables networking for containers altogether. I haven't found any use-case for this yet.
4. overlay - This is used for connecting multiple Docker daemons across computers and is out of the scope of this book.
5. macvlan - Allows assignment of MAC addresses to containers, making them function like physical devices in a network.
	
How to Create a User-Defined Bridge in Docker:
----------------------------------------------------------------------------
As you can see, Docker comes with a default bridge network named bridge. Any container you run will be automatically attached to this bridge network. Containers attached to the default bridge network can communicate with each others using IP addresses. A user-defined bridge, however, has some extra features over the default one. 

1. User-defined bridges provide automatic DNS resolution between containers: This means containers attached to the same network can communicate with each others using the container name. So if you have two containers named notes-api and notes-db the API container will be able to connect to the database container using the container names.

2. User-defined bridges provide better isolation: All containers are attached to the default bridge network by default which can cause conflicts among them. Attaching containers to a user-defined bridge can ensure better isolation.

3. Containers can be attached and detached from user-defined networks on the fly

Note: Keep in mind, though, that in order for the automatic DNS resolution to work you must assign custom names to the containers. 

	$ docker network ls
	$ docker network inspect --format='{{range .Containers}}{{.Name}}{{end}}' bridge --> to inspect which container using which network-ID.(bridge/my-network/host)
	$ docker network create my-network 	--> this will create a bridge network	

newly created network doesn't have any containers attached to it. two ways of attaching a container to a network. 

	$ docker network connect my-network my-nginx 			--> to attach a container to a newly created network  to a running container. 
	$ docker run --network=my-network  -p 8081:80 -d --rm nginx 	--> creating a new container and attaching to custom network.
	$ docker network disconnect my-network my-nginx			--> to Detach Containers from a Network in Docker. we can detach all networks.
	$ docker network rm my-network 					--> to remove a network 

----------------------------------
```
docker container run \
    --detach \
    --name=notes-db \
    --env POSTGRES_DB=notesdb \
    --env POSTGRES_PASSWORD=secret \
    --network=notes-api-network \
    postgres:12
 ```   
--------------------------------------

Q. How to Work with Named Volumes in Docker
---------------------------------------------------------------------------
Although the containers are running, there is a small problem. Databases like PostgreSQL, MongoDB, and MySQL persist their data in a directory. PostgreSQL uses the `/var/lib/postgresql/data` directory inside the container to persist data. Now what if the container gets destroyed for some reason? You'll lose all your data. To solve this problem, a named volume can be used. A named volume is very similar to an anonymous volume except that you can refer to a named volume using its name. Volumes are also logical objects in Docker and can be manipulated using the command-line. 

	$ docker volume create my-volume1	--> creating new volumes, this is a named volume. 
	$ docker volume ls			--> to list the volumes
 
	$ docker container inspect --format='{{range .Mounts}} {{ .Name }} {{end}}' notes-db	--> volumes attached to container notes-db

Q How to Access Logs from a Container in Docker
------------------------------------------------------------------------------

	$ docker container logs my-nginx	--> to check the container logs. 
	
	
Q. Securing the Docker Daemon (/var/run/docker.sock)?
-------------------------------------------------------
this to secure the docker environment from accedental stopping/starting/deleting. it also provide the security from hackers where he/she can attack if they have got access to the docker daemon. 
	
	step-1: Fist we need to secure the docker host.
	-------------------------------------------------
	1. disable password based authentication
	2. enable logging using SSH based authentication.
	3. determine USERS who need access to servers. 

 	Step-2: remote access restrictions
  	------------------------------------
   	1. secure the external connection using the TLS certificates
    	2. create the CA certificates and install it on the docker host is mandate. in "/etc/docker/daemon.json"
     	{
	"debug": true,
	"hosts": ["tcp://192.168.1.10:2376"]
	"tls": true,
	"tlscert": "/var/docker/server.pem",
	"tlskey": "/var/docker/serverkey.pem"
	"tlsverify": true,
	"tlscacerts": /var/docker/caserver.pem
	}
	3. share the ca-client.pem and client-key.pem and cacert.pem to the remote  host and copy it to the docker HOME directory under ~/.docker. 
 	4. export DOCKER_TLS_VERIFY=true


Scenarios:
------------------------------------------------------------

**Scenario-1: I stopped the docker service using `$ sudo systemctl stop docker`, but i could still start new containers even after the docker daemon is inavtive/dead. Why? explain?**

Answer: Docker service is stopped using `systemctl stop docker` command,  you've stopped the Docker service, if a Docker client attempts to communicate with the Docker daemon, the `docker.socket` can trigger the Docker service to start again. This can happen because the socket unit is configured to activate the service when a connection is made. for example a docker command executed from command-line tool, it will communicates with the Docker daemon.

Scenario-2: 
