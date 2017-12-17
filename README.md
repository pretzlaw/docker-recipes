# docker-recipe - Build Dockerfiles

> Helping you build your Dockerfile and compile container without hurt.

- Some packages don't compile without hurt / unknown dependencies.
- I don't want to figure out why a build failed.
- I want a chef cook that gets the ingredients and serve me a working `Dockerfile`!

This is what `docker-recipe` is for:

    $ docker-recipe php/curl
    
    # PHP cURL
    RUN apt-get install -qqy libcurl4-openssl-dev
        && docker-php-ext-install curl

Nice!

## Building Dockerfiles from scratch

Imagine you have a `Dockerfile.dist` like this:

    FROM pretzlaw/php:7.2-apache
    MAINTAINER John Doe <me@myself.i>

Now you like to build the `Dockerfile` install some packages using `docker-recipe` on the shell:

    cat Dockerfile.dist > Dockerfile
    
    # Some version control with GIT and SVN.
    docker-recipe vcs >> Dockerfile
    
    # Some other things for the container
    docker-recipe php/curl php/gd php/intl >> Dockerfile

So you can parse one or many recipes as an argument.
The output for `docker-recipe foo` will be something like:

    # foo
    RUN this \
        && that

Which you can append to the Dockerfile using `>> Dockerfile`.

## Inject recipes in Dockerfile

When you already have a `Dockerfile`  you may want to do something like this:

    FROM pretzlaw/php:7.2-apache
    MAINTAINER John Doe <me@myself.i>
    
    # docker-recipe: base
    # docker-recipe: php/composer
    
    # Install VCS
    RUN apt-get install -qqy git subversion
    
    # docker-recipe: wordpress
    
    # cleanup
    RUN rm -rf /var/lib/apt/lists/*
    
    CMD ["apache2-foreground"]

Using `docker-recipe Dockerfile` will complete the parts with `# docker-recipe: ` comments. 

## What do we want?

- Be as silent as possible where it is okay (except for errors).
- Low number of intermediate container (using `&&` in every recipe).
- Clean up afterwards (like `apt purge -y some-package-dev`).
