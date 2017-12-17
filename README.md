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

So cURL needs the `libcurl4-openssl-dev` to be compiled
and our Docker recipe brought that in.
**Now it won't fail.** Nice! 🎉

## Introduction

### What do we want? This is the big goal!

1. Work on any OS!
2. Be as silent as possible where it is okay (except for errors).
3. Low number of intermediate container (using `&&` in every recipe).
4. Clean up afterwards (like `apt purge -y some-package-dev`).

### Building Dockerfiles

Adding packages to a `Dockerfile` is easy as:

    docker-recipe vcs >> Dockerfile
    docker-recipe php/curl php/gd php/intl >> Dockerfile

We just added GIT, SVN, php-curl, php-gd and php-intl to the `Dockerfile`
with all dependencies.
The build should not fail but if so then let us know in the bug tracker.

### Parse Dockerfile

You can also have a `Dockerfile.recipe` template:

    FROM pretzlaw/php:7.2-apache
    MAINTAINER John Doe <me@myself.i>
    
    # @docker-recipe php/composer
    
    RUN apt-get install -y git
    
    # @docker-recipe wordpress

Running `docker-recipe Dockerfile.recipe` (or simply `docker-recipe`)
will parse this file and inject the recipes.

## Features

The commands:

- `docker-recipe` writes the `Dockerfile` using `Dockerfile.recipe` by default.
- `docker-recipe some-other.drecipe` parses another file flushing the result on STDOUT.
- `docker-recipe parse some-other.drecipe` parses a file (without recursion).
- `docker-recipe find php/curl` shows the path to the recipe.

Environment variables:

- Use `DOCKER_RECIPE_OS="debian"` to switch concerns and maybe use other recipes.
- Use `DOCKER_RECIPE_PATH="/some/other/recipes` to fetch recipes from another directory.
- `DOCKER_RECIPE_BASE` points to the path of all commands and should not be overridden.

Other nice stuff:

- Each `.df` file is allowed to contain additional `# @docker-recipe` references (recusively parse).
