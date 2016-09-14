# MediaWiki 4 Intranet

Mediawiki4Intranet is a bundle installation of MediaWiki with a lot of extensions included.

http://wiki.4intra.net/Mediawiki4Intranet

# Run it with Docker

To run Mediawiki4Intranet using Docker, clone this repository and execute:

    docker build -t mediawiki4intranet .

    docker run --name mw4i -p 8077:80 -v /home/wiki4intranet/data -t -d mediawiki4intranet

Then point your browser to http://localhost:8077

Use "WikiSysop" login name and "MediaWiki4Intranet" password to authorize.

# Docker cheatsheet

Some basic commands to work with the resulting container:

* list running containers: `docker ps`
* list system images: `docker images`
* stop container: `docker stop mw4i`
* start container again: `docker start mw4i`
* run shell in the container: `docker exec -it mw4i bash`
