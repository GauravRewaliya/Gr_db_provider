# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


#### env file info
.env.development
.env.test
.env.production
.env

.env.example

## Docker installation
 2262  sudo apt install docker.io -y
 2263  sudo apt update\nsudo apt install docker-compose-plugin -y\n

## Docker
>> docker compose up


# docker network

4  docker network ls\n

 2283  docker network inspect db_network\n
 2284  docker network create db_network\n

 2287  docker exec -it --user root adminer_container /bin/sh\n

 2288  docker network inspect gr_db_provider_db_network\n
 2289  docker network inspect db_network\n


 2291  docker network inspect db_network\n
 2292  docker network inspect gr_db_provider_default\n
 2293  docker compose ps\n

  2264  docker compose up\n
 2265  docker compose down\n

./docker-compose.bash

