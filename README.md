# MediaWiki 4 Intranet

Mediawiki4Intranet is a bundle installation of MediaWiki with a lot of extensions included.

http://wiki.4intra.net/Mediawiki4Intranet

# Run it with Docker

Mediawiki4Intranet requires a lot of additional software, so the simplest way to
install it is by using Docker.

To run Mediawiki4Intranet using Docker, clone this repository, go inside it and execute:

    docker build -t mediawiki4intranet/basic .

    docker run --name mw4i -p 8077:80 -v /home/wiki4intranet/data -t -d mediawiki4intranet

Then point your browser to http://localhost:8077

Use "WikiSysop" login name and "MediaWiki4Intranet" password to authorize.

# VisualEditor

Basic Mediawiki4Intranet image does not include VisualEditor. To build docker image with
VisualEditor, run:

    docker build -t mediawiki4intranet/ve .

# Docker cheatsheet

Some basic commands to work with the resulting container:

* list running containers: `docker ps`
* list all containers: `docker ps -a`
* list system images: `docker images`
* stop container: `docker stop mw4i`
* start container again: `docker start mw4i`
* run shell in the container: `docker exec -it mw4i bash`
* remove container: `docker rm <container_id>`
* remove image: `docker rmi <image_id>`
