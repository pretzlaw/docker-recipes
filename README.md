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

So cURL needs the openssl-dev to be compiled
and our recipe brought that in.
Now it won't fail. Nice!

## Building Dockerfiles

Adding packages to a `Dockerfile` is easy as:

    docker-recipe vcs >> Dockerfile
    docker-recipe php/curl php/gd php/intl >> Dockerfile

We just added GIT, SVN, php-curl, php-gd and php-intl to the `Dockerfile`
with all dependencies.
The build should not fail but if so then let us know in the bug tracker.

## Parse Dockerfile

You can also have a `Dockerfile.recipe` template:

    FROM pretzlaw/php:7.2-apache
    MAINTAINER John Doe <me@myself.i>
    
    # @docker-recipe php/composer
    
    RUN apt-get install -y git
    
    # @docker-recipe wordpress

Running `docker-recipe Dockerfile.recipe` (or simply `docker-recipe`)
will parse this file and inject the recipes.

## What do we want?

- Be as silent as possible where it is okay (except for errors).
- Low number of intermediate container (using `&&` in every recipe).
- Clean up afterwards (like `apt purge -y some-package-dev`).
