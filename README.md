# MediaWiki 4 Intranet

Mediawiki4Intranet is a bundle installation of MediaWiki with a lot of extensions included.

http://wiki.4intra.net/Mediawiki4Intranet

# Run it with Docker

Mediawiki4Intranet requires a lot of additional software, so the simplest way to
install it is by using Docker.

To run Mediawiki4Intranet using Docker, clone this repository, go inside it and execute:

    sh build.sh

This will build Docker images for mediawiki4intranet. Then create a container:

    docker run --name mw4i -p 8077:80 -t -d mediawiki4intranet

or, if you want VisualEditor:

    docker run --name mw4i -p 8077:80 -t -d mediawiki4intranet/ve

Then point your browser to http://localhost:8077

Use "WikiSysop" login name and "MediaWiki4Intranet" password to authorize.

# Email delivery and overriding configuration in general

You need to configure SMTP to allow MediaWiki to deliver e-mails (user account confirmation,
password reset and etc). To do so you need to add the following into /home/wiki4intranet/www/LocalSettings.php:

    $wgSMTP = array(
        'host' => '<SMTP server>',
        'port' => 25,
        'auth' => false, // or true if you set username&password
        'username' => '<SMTP username>',
        'password' => '<SMTP password>',
    );

You'll probably also want to change other settings: sitename, logo or favicon, or maybe you'll
want to install additional extensions, or create multiple wikis in one shared container.

**The recommended way** to do all these configuration tasks is creating your own Dockerfile
based on `mediawiki4intranet` or `mediawiki4intranet/ve` images with all your configuration and
software changes, build your own Docker image and run container based on it.

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

P.S: If you get "Cannot connect to the Docker daemon. Is the docker daemon running on this host?" error,
add your system user into `docker` group **and relogin**!
