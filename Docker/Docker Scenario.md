
Scenario-1: I stopped the docker service using `$ sudo systemctl stop docker`, but i could still start new containers even after the docker daemon is inavtive/dead. Why? explain?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Answer: Docker service is stopped using `systemctl stop docker` command,  you've stopped the Docker service, if a Docker client attempts to communicate with the Docker daemon, the `docker.socket` can trigger the Docker service to start again. This can happen because the socket unit is configured to activate the service when a connection is made. for example a docker command executed from command-line tool, it will communicates with the Docker daemon.

Scenario-2: if you map your container port 80 with host port 8080, and you have a requirement to increase the number of containers to 4, and the web URL should be one, how do you configure?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Answer: If we map a container-port 80 with host-port 8080, we can't map another container with same 8080 port, because its already been used (error: Bind for 0.0.0.0:8080 failed: port is already allocated.).
To achieve load balancing across multiple containers on the same host port (e.g., port 8080) with a single web URL, you must use a load balancer or reverse proxy. The reverse proxy will distribute incoming requests to the different containers based on various load balancing algorithms.

Step-1: create a dedicated network for this setup

        $ docker network create my-nginx-network
      
Note: Docker provides network isolation between containers that are connected to the same network. Containers on the same network can communicate with each other, but they are isolated from containers on other networks. This helps prevent unintended network communication between unrelated containers. also it provides 

Step-2: Start your four containers, each with a different host port, such as 8081, 8082, 8083, and 8084.

        $ docker run -d --name container-1 -p 8081:80 --network my-nginx-network nginx
        $ docker run -d --name container-2 -p 8082:80 --network my-nginx-network nginx
        $ docker run -d --name container-3 -p 8083:80 --network my-nginx-network nginx
        $ docker run -d --name container-4 -p 8084:80 --network my-nginx-network nginx

Step-2: Set up a reverse proxy (e.g., Nginx) to listen on the desired host port (8080) and distribute requests to the containers. 
