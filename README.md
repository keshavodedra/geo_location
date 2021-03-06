# README

# Environment

Ruby 3.1.0

Rails 7.0.1

PostgreSql

RSpec

JSON::API

Rubocop

Docker

# Overview

- Testing Task -  Ruby API - Geolocation with external integration.

- You can post your geo-location data from post method.
  (Used IpStack 3rd party API integration for this)

- You can see a list of geo-location using api with various options.

- You can delete a geo-location by id or by current ip.

- Ip Address will be tracked automatically by the application.

- This project is flexible and scalable like, we can use other 3rd party API service

  by just creating new service class and jst define this new class to main GeoLocatorService service.

- It has a RESTful API

- Geolocation module has been written in the way that in the future it should be easy to change the service provider.

# API Endpoints

- Get a list of geo-locations using paginatin
GET: localhost:3001/api/geo_locations?page[size]=5&page[number]=1

- Get a list of geo-locations using ip-address
GET: localhost:3001/api/geo_locations?filter[ip_address_eq]=2.49.80.142

- Get a list of all geo-locations
GET: localhost:3001/api/geo_locations?all = true

- Get a list of geo-locations based on current ip address
GET: localhost:3001/api/geo_locations

- Post/Create geo-locations based on current ip address
POST: localhost:3001/api/geo_locations

- Delete geo-locations based on id
DELETE: localhost:3001/api/geo_locations/:1 (delete)

- Delete geo-locations based on current ip address
DELETE: localhost:3001/api/geo_locations/delete_my_locations (delete)


# ToDo

- We can implement Users functionality by using Devise GEM.
- So We can make our API secure and only authenticate user can use these endpoints and we can store Geo-locations by UserId

# RUN

- git clone of the project

- Docker file and Docker-compose file is already Added.

- Change databse username password in database.yml and Docker.compose file.

- sudo docker-compose build

- sudo docker-compose up

- systemctl stop postgresql (Only if postgres is already listening on the same port)

- get inside the container of api (sudo docker exec -it geo-location-api_api_1 bash) and run rake db:migrate


# API-Documentation

https://documenter.getpostman.com/view/7436287/UVeFNmn8



