
### What is a Container?
A container will pack your application and its dependencies,libraries,OS together so that it can be deployed/run accross any platform without worrying the underlying OS.

Docker: Overview :
--------------------
Docker is a Containerization platform. Containerization will encapsulate or package softwares and all its dependencies, so that it can run uniformly and consistently on any infrastructure. 

Docker: Architecture Overview
--------------------------------
The docker engine consists of 3 componenets.
	1). Docker Daemon
	2). Docker client
	3). REST API

![Picture1-15](https://user-images.githubusercontent.com/33980623/234473946-a618580d-8b8f-4705-a100-6f6f98f4049e.png)
	
**Docker Daemon:** The daemon (dockerd) is a process that keeps running in the background and waits for commands from the client. The daemon is capable of managing various Docker objects.

	1. docker objects are stored in this location (containers/images/volumes/networks/etc) : /var/lib/docker 
	2. docker daemon service is run on ports : 2375(plain)/2376(secure) 
	3. docker environment variable for accessing remotely : export DOCKER_HOST="tcp://docker-host-ip:2375" --> secure use 2376
	
	4. docker service check : 	$ systemctl status docker 
	5. docker service start : 	$ systemctl start docker
	6. docker service enable: 	$ systemctl enable docker
	
	7. docker daemon troubleshooting with service logs : $ journalctl -u docker.service 
	8. docker configuration files are stored in : $ vi /etc/docker/daemon.json 
	9. docker config reload : $ systemctl reload docker

**Docker Client:** The client  (docker) is a command-line interface program mostly responsible for transporting commands issued by users.

**REST API:** The REST API acts as a bridge between the daemon and the client. Any command issued using the client passes through the API to finally reach the daemon.

"Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers".

You as a user will usually execute commands using the client component. The client then use the REST API to reach out to the long running daemon and get your work done.

Docker: Install
-------------------
Docker installation on CentOS, when docker install it create a dircectory in /var/lib/docker where all the docker objects are stored. such as containers, images, volumes, network and others.  
	
Install:
----------------------------

	 $ sudo yum install -y yum-utils	--> install yum-utils package
	 $ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo	--> add repository 
	 $ sudo yum install docker-ce docker-ce-cli containerd.io	-->install 3 components. 
	 $ sudo systemctl start docker	--> start docker as service.
	 $ sudo systemctl enable docker --> enable the docker service on restart

Daemon:
-----------------------------
	 $ dockerd	--> to start the docker service manually
	 $ dockerd --debug	--> starting the docker service in debug mode. 
	 $ dockerd --debug --host=tcp://192.168.1.10:2375 --> remote docker service (export DOCKER_HOST="tcp://192.168.1.10:2375)
	
Version:
-----------------------------
	$ ps aux |grep docker 		--> to see process running inside container 
	$ docker --version		--> docker version
	$ docker-compose --version	--> docker compose version
	$ docker system info 		--> docker full information (debug mode/
	$ docker run hello-world	--> running simple docker image hello-world

Process:
-----------------------------
	$ docker ps 	--> only running containers list
	$ docker ps -a 	--> to see all containers (running/stopped/paused/created)
	$ docker ps -q	--> shows only container-ID of running process
	$ docker ps -qa --> shows all containers-ID (running/stopped/paused/created)

objects:
-----------------------------
	$ docker image ls	--> list docker images
	$ docker network ls	--> lists docker networks
	$ docker container ls	--> lists running docker containers
	$ docker volume ls 	--> lists volumes created

Q. What is a Docker: Registry? (Docker Hub)
---------------------------------------------
An image registry is a centralized place where you can upload your images and can also download images created by others. Docker Hub is the default public registry for Docker. create a docker hub account and login using link: https://hub.docker.com/
	
Registry:

	$ docker login 	--> to login to docker repository (default: docker hub repository)
	$ docker logout --> to logout docker repository
	$ docker login gcr.io	--> to login to GCP repository
	$ docker login docker.io --> to login to to docker hub repository
	
Q. What is a Docker: Container? 
--------------------------------
A container is a isolated env which will package the softwares and its dependencies requied to run an application on any platform uniformly. this contaienrs are light wight objects. docker container life cycle..
		
	Creation --> Running --> Pausing --> Unpausing --> starting --> Stopping --> Restarting --> Killing --> Destroying
		
Usage:  $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
	
		-i 	--> interactive mode
		-t 	--> terminal 
		-d 	--> detached
		-c 	--> cpu
		-m 	--> memory
		-l 	--> labels
		--rm 	--> remove the container once its stopped
		-v <host-volume>:<container-volume> 	--> volumes
		-p <Host-port>:<container-port> 	--> publish ( port )
		-e key1=value1 	--> environment variable
		--network <network-name> 	--> 
		attach --> to attach to the running container
	
	$ docker ps --> it will show only running containers
	$ docker ps -a --> to list all stopped and running
	$ docker info  ---> to see all docker information.
	
	$ docker --help
	$ docker <command> --help

start/stop:
-----------------------------
	$ docker create --name my-nginx nginx --> creates nginx container, named as my-nginx
	$ docker start my-nginx		--> starts newly created nginx 
	$ docker stop my-nginx 		--> stop nginx container, it will be avaiable to restart again
	$ docker kill my-nginx 		--> it will obruptly kills the nginx container

run:
-----------------------------
	$ docker run nignx 	--> it creates & starts nginx container, and docker daemon will give a unique name to it.
	$ docker run --name my-nginx nginx 	--> it creates & starts nginx container named as my-nginx
	$ docker run -d nginx 	--> container run in background
	$ docker run -it nginx /bin/bash --> this will open a terminal to connect with container 

	$ docker run -p 8080:80 nginx --> publish the nginx to external network (-p <host-Port>:<container-port> ) 
	$ docker run –p 3306:3306 mysql --> publish mysql port
	$ docker run –p 192.168.1.5:8000:5000 kodekloud/simple-webapp	--> 

remove:
-----------------------------
	$ docker run --rm ubuntu cat /etc/*release*	--> remove the docker container once the container exited.

ports:
-----------------------------
	$ docker port my-nginx/container-ID	--> to check container ports status
	$ docker port my-nginx 8080/tcp 
	$ docker port my-nginx 8080/ud

copy:
-----------------------------
	$ docker cp <local file path> <contiainer-id:/container-path> 
	$ docker cp /tmp/web.conf webapp:/etc/web.conf --> copy file/directories to container from localhost to container 

rename:
-----------------------------
	$ docker rename my-nginx app1-nginx --> to rename nginx container from my-nginx to app1-nginx

attach:	
-----------------------------
to attach to the detached container, first your container must enable the interactive terminal(-it) then only you can reattach to the attached container with out stopping the container.

	$ docker run -it -d nginx --> start container like this.
	$ docker attach my-nginx --> to attach to the detached container, to detach (Ctrl+p + Ctrl+q )

execute:	
-----------------------------
	$ docker exec my-nginx uname -a --> to check the container OS details
	$ docker exec my-nginx cat /etc/*release* --> this is to check container OS details
	$ docker exec -it my-nginx /bin/bash --> this is to connect with running nginx 

pause: 
-----------------------------
you can't perform any operation during this time, the container running but it will be in paused state. 

	$ docker pause my-nginx my-redis --> it will pause the container
	$ docker unpause my-nginx my-redis -->it will unpause the containers
	$ docker rm my-redis --> to delete the container permanently

inspect:	
-----------------------------
	$ docker inspect  my-nginx/container-ID --> to see the docker container details.

logs:	
-----------------------------
	$ docker logs my-nginx

top:
-----------------------------
	$ docker top my-nginx/container-ID 	--> to see process running for that container.
	$ docker stats	--> provide the stats of the containers
	
	$ docker stop $(docker ps -q) --> it stops all containers running
	$ docker rm $(docker ps -aq) --> it will remove all containers in stopped state.
	
	$ docker container stop $(docker container ls -q) --> stop all containers at once
	$ docker container rm $(docker container ls -aq) --> remove all container at once.

events:	
-----------------------------
	$ docker system events --since 60m	--> system events recorded for 60m 

system:	
-----------------------------
	$ docker system df	--> docker objects created count and memeory usage
	$ docker system info	--> docker daemon configuration details.
	$ docker system prune	--> it will remove all stopped, dangling images
		- all stopped containers
  		- all networks not used by at least one container
  		- all dangling images
  		- all dangling build cache

	
Q. What is a Docker: Image?
----------------------------
Images are multi-layered self-contained files that act as the template for creating containers. They are like a frozen, read-only copy of a container. Images can be exchanged through registries.

during the build process, if we want to avoid the file which we don't want to build, then create a file named .dockerignore file and add the file which need to be ignored during the build process. 

Sample docker image creation using the Dockerfile:
--------------------------------------------------
```
FROM ubuntu:latest

EXPOSE 80

RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
```

	FROM	--> define OS prefered for your image
	RUN	--> for runing a command 
	COPY	--> copy the file from local to image
	ADD	--> similer to COPY, but it has some additinal features, it can untar and copy, it can donwload from internet and copy
	EXPOSE	--> to expose the container port
	CMD 	--> the program with container should start when container start
	ENDPOINT --> similer to CMD, but need to pass the CMD at the end.  
	ENV	--> image environment variables defined druing the container run
	WORKDIR	--> define the working directory 
	VOLUME	--> define mountable directories in image
	ARG	--> arguments to pass in the image


pull/push:
---------------------
	$ docker pull nginx --> will pull the image from docker repository, it will pull only one.
	$ docker push custome-image --> to push you image to the docker repository

history:
---------------------
	$ docker images  --> to list the docker images pulled and avaiable
	$ docker history nginx --> to see image creation steps

remove:
---------------------
	$ docker rmi nginx --> to remove the nginx image in local repository

build:
---------------------
	$ docker build . -t custom-tag1 --> directory should container `Dockerfile` to build the docker image
	$ docker build https://github.com/karunakarrao/my-nignx  --> to build the image from a git repo
	$ docker build https://github.com/karunakarrao/my-nginx#branchname --> can also specify the branch 
	$ docker build https://github.com/karunakarrao/my-nginx:<build-folder-name> --> this way we can pass the directory
	$ docker build -f Dockerfile.dev https://github.com/karunakarrao/my-nginx:<build-folder-name> 

tag:
---------------------
	$ docker image tag httpd:alpine httpd:customv1 --> rename the tagged value with custom name
	$ docker image tag httpd:alpine gcr.io/company/httpd:customv1 

save:
---------------------
	$ docker image save alpine:latest -o alpine.tar  --> to save the image as .tar file and share
	$ docker image load -i alpine.tar  --> to extract the .tar file 
	
export/import:
---------------------
	$ docker export <container-name> file1.tar
	$ docker image import file1.tar newimage:latest
	
Q. what is the use of docker namespaces ?
------------------------------------------
Docker uses Namespaces to isolate the containers from the hosted OS, Docker containers running on hosted severs are not fully isolated, means they share same kernal. So the containers running on host are given a process-ID. Docker uses namespaces for each container so with in the container only container process are visible. but if we actually see hosted system process, respective process are visible in the hosted system with different PID.  

Q. What is a Docker: Volumes ?
-------------------------------
Containers are short lived object they are destroyed once the container work is over, but the data it collected also removed once the container is destroied. so to make the data persistant or to use for time to time we need to map the container path to localhost path so that the data is save persistantly. this is where the volumes come in to picture.

docker uses the storage drivers to do the all the below actions when we execute the command. they are mutiple types like AUFS, ZFS, BTRFS, Device Mapper, Overlay, Overlay2 and etc. Depeding on dockerimage base OS respective driver is used to perform this operations. 

	$ docker volume ls 
	$ docker volume create my-volume1 	--> this will create a volume in the docker-host /var/lib/docker/volumes
	$ docker volume remove my-volume1	--> remove my-volume1
	$ docker inspect my-volume1		--> inspec the volume details. 
	
run: 

	$ docker run -v my-volume:/var/lib/mysql mysql --> volume mapped to docker contianer. /var/lib/mysql default storage location.
	$ docker run -v my-volume2:/var/lib/mysql mysql --> if we didn't create a volume, docker will create the volume and map.
	$ docker run -v /home/mysql:/var/lib/mysql mysql --> we can map the external location to store the data persistantly
	$ docker run --mount type=bind,source=/home/mysql,target=/var/lib/mysql mysql --> this way also we can mount the volumes.

Q. What is **`docker-compose`** ? 
---------------------------------
If we deploying fullscale application on docker, we need to use mutiple containers like web-server(nginx), in-memorydb(redis), persistant-db(mangodb), orchestration(ansible), etc. So to deploy all containers as a stack we use docker-compose .YAML files. this will deploy the complete application with one command. 

docker-compose file must be named as this other wise docker-compose will not notice your configuration file. docker-compose.yml, docker-compose.yaml, compose.yml, compose.yaml

there are 2 versions in docker-compose file, mention the version details in "" like "2" or "3". 

docker-compose.yml 
-------------------
```
version: "3"
services:
  redis:
    image: redis
  db: 
    image: postgres
    environment: 
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
  voting-app:
    image: eesprit/voting-app-vote
    ports:
      - 5000:80
  result-app:
    image: eesprit/voting-app-result
    ports:
      - 5001:80
  worker-app:
    image: eesprit/voting-app-worker
```

	$ docker-compose up	--> to bringup the application components. 

Q. What is Docker: Networking ?
--------------------------------
Docker installtion comes with 3 types of networks
	1. Bridge (default) --> 
	2. Host
	3. None
	
	$ docker run nginx --> this will map to default Bridge network.
	$ docker run --network=host nginx --> to map to host network.
	$ docker run --network=none nginx --> to map to none network.
	
	$ docker network ls
	$ docker inspect my-nginx --> to see the network details attached to the container
	
	$ docker network create --driver bridge --subnet 182.18.10.0/16  my-network1 --> create docker network my-network1
	$ docker run -itd --name first nginx --> run on default network 
	$ docker run -itd --name second nginx --> runs on default bridge network
	$ docker exec first ping second --> ping will not work, in default network containers are isolated 
	
	$ docker run -itd --name customfirst --network my-network1 nginx
	$ docker run -itd --name customsecond --network my-network1 redis
	$ docker exec customsecond ping customfirst --> ping with in the custom network will work, by default ping is enabled
	
	$ docker network connect custom-network1 first --> to establish the connection between 2 networks
	$ docker exec customfirst ping first --> will work.
	
	$ docker network disconnect my-network1 my-nginx1
	$ docker network disconnect my-network1 first
	$ docker network rm my-network1
	

Note: Docker containers reach each other using container name, this is achived using docker built Embedded DNS, which will resolve all the container names. when we map the containers, we specify the container name. the built in DNS server runs always on 127.0.0.11. 

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

	

Q. Full picture how the Docker Image works?
-----------------------------------------------
1. To understand DockerImage better, we need to understand how DockerImages are build. DockerImages are build using Dockerfiles. Dockerfiles are contructed in multipule layers ( base(OS), package, dependencies, souce-code(application), endpoint) bind together and builds and image. this image is docker image. 

2. DockerImages are readonly images, means they are act as a template to create a container. so docker uses the same image to create n number of containers.

3. when a container is created, it will create a layer on the DockerImage and 

	
Q. Full Picture how the Docker container works ?
-----------------------------------------------------------------------------------------------------------------------------------------------------------
1). You execute "docker run hello-world" command where hello-world is the name of an image.

2). Docker client reaches out to the daemon, tells it to get the hello-world image and run a container from that.

3). Docker daemon looks for the image within your local repository and realizes that it's not there, resulting in the Unable to find image 'hello-world:latest' locally that's printed on your terminal.

4). The daemon then reaches out to the default public registry which is Docker Hub and pulls in the latest copy of the hello-world image, indicated by the latest: Pulling from library/hello-world line in your terminal.

5). Docker daemon then creates a new container from the freshly pulled image.

6). Finally Docker daemon runs the container created using the hello-world image outputting the wall of text on your terminal.


Q. How to Publish a Port to access the application ?
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Containers are isolated environments. Your host system doesn't know anything about what's going on inside a container. Hence, applications running inside a container remain inaccessible from the outside. To allow access from outside of a container, you must publish the appropriate port inside the container to a port on your local network. 

	$ docker run <image-fullname> --publish <host-port>:<container-port> --> common syntax for the --publish or -p option is as follows

When you wrote --publish 8080:80, any request sent to port 8080 of your host system will be forwarded to port 80 inside the container. Now to access the application on your browser, visit http://localhost:8080 | http://dockerhost:8080

Note: it is mandate you pass the arguments like --> Usage:  $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

	$ docker run nginx  --publish 8080:80 --name=my-nginx
	

Q. Docker commands: container handling
------------------------------------------------------
	$ docker --version
	$ docker-compose --version

	Note: docker image should be specified at the end of the command. other wise docker image will not get created. show options are not avialbe.
		Usage:  $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

	$ docker run -p 8081:80 nginx	--> deploying nginx image
	(or) $ docker container run -p 8082:80 nginx	

	$ docker create --name=my-redis	redis --> it will create docker container, we need to start the container to use it.

	$ docker run --name=my-nginx -p 8081:80 --rm nginx --> to name container as "my-nginx" and --rm to remove the contianer once its stopped. 
	$ docker run -d -p 8082:80 nginx --> to detach container, it will run in background. to attach again use --attach
	$ docker attach <container-name/container-ID>	--> to attach the detached container

	$ docker start <container-name/container-ID>	--> start the stopped container
	$ docker stop <container-name/container-ID>	--> shuts down a container gracefully 
	$ docker restart <container-name/container-ID>	--> restart the container
	$ docker kill <container-name/container-ID> 	--> to kill the process

	$ docker ps	--> to list the docker process
	$ docker ps -a 	--> to list all the process which are stopped also

	$ docker rm <container-name/container-ID>	--> to remove a stopped/Exited container

	$ docker exec -it <container-name/container-ID> <command> 	--> -i interactive and -t terminal
	$ docker exec -it my-nginx /bin/bash	--> connecting to running docker conatainer (my-nginx is container name)
	$ docker exec my-nginx uname -a --> to exicute a command to check os details cmd: uname -a




Q. how to update running container to publish port?
----------------------------------------------------

Docker : Image handling
------------------------------------------------------

Dockerfiles:
---------------------------------------------------------------
to customize the image, we need to lear vision of what you want from the image. 
make a custom NGINX image, you must have a clear picture of what the final state of the image will be.
	1. The image should have NGINX pre-installed which can be done using a package manager or can be built from source.
	2. The image should start NGINX automatically upon running.
How to Ignore Unnecessary Files: .dockerignore,  The .dockerignore file contains a list of files and directories to be excluded from image builds.This .dockerignore file has to be in the build context. Files and directories mentioned here will be ignored by the COPY instruction. But if you do a bind mount, the .dockerignore file will have no effect. 

step-1: Now, create a new file named Dockerfile in an empty directory custom-nginx. A Dockerfile is a collection of instructions that, once processed by the daemon, results in an image. Content for the Dockerfile is as follow
-------------------------------------------------------------
```
FROM ubuntu:latest

EXPOSE 80

RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
```
----------------------------------------

Images are multi-layered files and in this file, each line (known as instructions) that you've written creates 

	FROM: Every valid Dockerfile starts with a FROM instruction. This instruction sets the base image for your resultant image.
	EXPOSE: The EXPOSE instruction is used to indicate the port that needs to be published. 
	RUN: The RUN instruction in a Dockerfile executes a command inside the container shell. 
	CMD: Finally the CMD instruction sets the default command for your image.

to build the image need to use the command build from custom-nginx directory


	$ docker push <Image-repositry-name>:<tag>
	
	$ docker login		--> to login to docker hub registory.
	$ docker logout		--> to logout from docker registroy
	
	$ docker image push karna-nginx:latest		--> to push the latest image
	$ docker pull <Image-repositry-name>:<tag>
	

	$ docker build . 	--> to build the docker image without tags

	$ docker image build --tag custom-nginx:packaged . --> to tag the docker image. REPOSITORY-name is custom-nginx  and  TAG is package

	$ docker image build --tag my-nginx:latest 	--> to tag the image

	$ docker images --> to list the images.

	$ docker image history <image-name> --> to see the image layers of docker image.

	$ docker image prune --force	--> this will delete name less images. 

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

to share the docker image online 

$ docker login

Q. Docker: Network Manipulation Basics in Docker:
--------------------------------------------------------------------------
real life, the majority of projects that you'll have to work with will have more than one container. 

Scenario:1
Now consider a scenario where you have a notes-api application powered by Express.js and a PostgreSQL database server running in two separate containers.
These two containers are completely isolated from each other and are oblivious to each other's existence. So how do you connect the two? Won't that be a challenge? you connect them by putting them under a user-defined bridge network. 

$ docker network ls 	--> to list the docker networks 

using above command, You should see three networks in your system. Now look at the DRIVER column of the table here. These drivers are can be treated as the type of network. By default, Docker has five networking drivers.
	
1. bridge - The default networking driver in Docker. This can be used when multiple containers are running in standard mode and need to communicate with each other.
2. host - Removes the network isolation completely. Any container running under a host network is basically attached to the network of the host system.
3. none - This driver disables networking for containers altogether. I haven't found any use-case for this yet.
4. overlay - This is used for connecting multiple Docker daemons across computers and is out of the scope of this book.
5. macvlan - Allows assignment of MAC addresses to containers, making them function like physical devices in a network.
	
How to Create a User-Defined Bridge in Docker:
----------------------------------------------------------------------------
As you can see, Docker comes with a default bridge network named bridge. Any container you run will be automatically attached to this bridge network. Containers attached to the default bridge network can communicate with each others using IP addresses. 

A user-defined bridge, however, has some extra features over the default one. 

1. User-defined bridges provide automatic DNS resolution between containers: This means containers attached to the same network can communicate with each others using the container name. So if you have two containers named notes-api and notes-db the API container will be able to connect to the database container using the notes-db name.

2. User-defined bridges provide better isolation: All containers are attached to the default bridge network by default which can cause conflicts among them. Attaching containers to a user-defined bridge can ensure better isolation.

3. Containers can be attached and detached from user-defined networks on the fly

Note: Keep in mind, though, that in order for the automatic DNS resolution to work you must assign custom names to the containers. 

$ docker network ls

$ docker network inspect --format='{{range .Containers}}{{.Name}}{{end}}' bridge --> to inspect which container using which network-ID.(bridge/my-network/host)

$ docker network create my-network 	--> this will create a bridge network	

newly created network doesn't have any containers attached to it. two ways of attaching a container to a network. 

$ docker network connect my-network my-nginx 	--> to attach a container to a newly created network  to a running container. 
(or)
$ docker run --network=my-network  -p 8081:80 -d --rm nginx --> creating a new container and attaching to newly created network.

$ docker network disconnect my-network my-nginx		--> to Detach Containers from a Network in Docker. we can detach all networks.

$ docker network rm my-network 		--> to remove a network 

----------------------------------

docker container run \
    --detach \
    --name=notes-db \
    --env POSTGRES_DB=notesdb \
    --env POSTGRES_PASSWORD=secret \
    --network=notes-api-network \
    postgres:12
--------------------------------------

Although the container is running, there is a small problem. Databases like PostgreSQL, MongoDB, and MySQL persist their data in a directory. PostgreSQL uses the /var/lib/postgresql/data directory inside the container to persist data. Now what if the container gets destroyed for some reason? You'll lose all your data. To solve this problem, a named volume can be used.

How to Work with Named Volumes in Docker
---------------------------------------------------------------------------
A named volume is very similar to an anonymous volume except that you can refer to a named volume using its name. Volumes are also logical objects in Docker and can be manipulated using the command-line. 

$ docker volume create my-volume1	--> creating new volumes 

$ docker volume ls	--> to list the volumes

$ docker container inspect --format='{{range .Mounts}} {{ .Name }} {{end}}' notes-db	--> volumes attached to container notes-db

How to Access Logs from a Container in Docker
------------------------------------------------------------------------------

$ docker container logs my-nginx	--> to check the container logs. 

$ docker container create 
	
	
Q. Securing the Docker Daemon (/var/run/docker.sock)?
-------------------------------------------------------
this to secure the docker environment from accedental stopping/starting/deleting. it also provide the security from hackers where her/she can attack if they have got access to the docker daemon. 
	
	step-1: Fist we need to secure the docker host.
	-------------------------------------------------
	1. disable password based authentication
	2. enable logging using SSH based authentication.
	3. determine users who need access to servers. 
	
	step-2: 
