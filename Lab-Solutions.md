## Q. How to setup Sonarqube with Postgres database using docker containers?

      $ docker network create sonarqube_network
      $ docker run --name postgres  -e POSTGRES_USER=root -e POSTGRES_PASSWORD=Test12345  -p 5432:5432 --network sonarqube_network -d postgres
      $ docker run -d --name sonarqube   -p 9000:9000  -e sonar.jdbc.url=jdbc:postgresql://postgres/postgres  -e sonar.jdbc.username=root -e sonar.jdbc.password=Test12345  --network sonarqube_network sonarqube

docker-compose-postgres.yml
--------------------------------------------
```
version: "3"
services:
  sonarqube:
    image: sonarqube
    ports:
      - "9000:9000"
    networks:
      - sonarnet
    environment:
      - sonar.jdbc.url=jdbc:postgresql://db:5432/sonar
    volumes:
      - sonarqube_conf:/opt/sonarqube/conf
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions

  db:
    image: postgres
    networks:
      - sonarnet
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=Test12345
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data

networks:
  sonarnet:
    driver: bridge

volumes:
  sonarqube_conf:
  sonarqube_data:
  sonarqube_extensions:
  postgresql:
  postgresql_data:
```
-----------------------------------------------------------------------
